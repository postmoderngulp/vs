import 'dart:convert';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:vs1/entity/details.dart';
import 'package:vs1/entity/history.dart';
import 'package:vs1/entity/location.dart';
import 'package:vs1/entity/message.dart';
import 'package:vs1/entity/my_package.dart';
import 'package:vs1/entity/package.dart';
import 'package:vs1/entity/package_info.dart';
import 'package:vs1/entity/profile.dart';
import 'package:vs1/entity/stage.dart';

class SupaBaseService {
  final supabase = Supabase.instance.client;

  void signUp(
    String name,
    String email,
    String password,
    String number,
  ) async {
    await supabase.auth
        .signUp(
          email: email,
          password: password,
        )
        .then((value) => supabase.from('profile').insert({
              'phone': number,
              'user_id': supabase.auth.currentSession!.user.id,
              'name': name,
              'balance': 1000000,
              'history': [],
              'role': 'client'
            }));
  }

  void signIn(
    String email,
    String password,
  ) async {
    final AuthResponse response = await supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );
    final Session? session = response.session;
    final User? user = response.user;
  }

  void forgotPassword(String email) async {
    supabase.auth.resetPasswordForEmail(email);
  }

  void newPassword(String password) async {
    await supabase.auth.updateUser(UserAttributes(password: password));
  }

  void logOut() async {
    await supabase.auth.signOut();
  }

  void sendFeedback(String body, int stars) async {
    await supabase.from('feedback').insert({
      'body': body,
      'stars': stars,
      'id_user': supabase.auth.currentSession?.user.id
    });
  }

  Future<MyPackage> getPackage() async {
    final response = await supabase
        .from('package')
        .select()
        .filter('id_user', 'eq', supabase.auth.currentSession?.user.id)
        .order('created_at', ascending: false)
        .limit(1);
    List<Details> list = [];
    List<dynamic> maps = response.first['destination_details'];
    for (int i = 0; i < maps.length; i++) {
      list.add(Details.fromMap(jsonDecode(maps[i])));
    }
    return MyPackage(
      stage: Stage.fromMap(jsonDecode(response.first['stage'])),
      id: response.first['id'],
      created_at: response.first['created_at'],
      origin_details:
          Details.fromMap(jsonDecode(response.first['origin_details'])),
      destination_details: list,
      package_details:
          PackageDetails.fromMap(jsonDecode(response.first['package_details'])),
      uuid: response.first['uuid'],
      id_user: response.first['id_user'],
      coordinat: MyLocation.fromMap(jsonDecode(response.first['coordinat'])),
    );
  }

  Future<Profile> getProfile() async {
    final val = await supabase
        .from('profile')
        .select()
        .filter('user_id', 'eq', supabase.auth.currentSession?.user.id);
    List<dynamic>? maps = val.first['history'];
    List<TransactionHistory> list = [];
    if (maps != null) {
      for (int i = 0; i < maps.length; i++) {
        list.add(TransactionHistory.fromMap(jsonDecode(maps[i])));
      }
    }

    return Profile(
        id: val.first['id'],
        created_at: val.first['created_at'],
        user_id: val.first['user_id'],
        phone: val.first['phone'],
        name: val.first['name'],
        balance: val.first['balance'],
        role: val.first['role'],
        transactions: maps != null ? list : []);
  }

  void makePayment(PackageInfo packageInfo, String code, MyLocation myLocation,
      double price, String time) async {
    await supabase.from('package').insert({
      'stage': Stage(
          stage: 'stage1',
          stage1Time: time,
          stage2Time: '',
          stage3Time: '',
          stage4Time: ''),
      'origin_details': packageInfo.originDetail,
      'destination_details': packageInfo.destinationDetails,
      'package_details': packageInfo.package,
      'uuid': code,
      'id_user': supabase.auth.currentSession?.user.id,
      'coordinat': myLocation
    });
    final profile = await getProfile();
    await supabase.from('profile').update({
      'balance': (profile.balance - price).toInt().round(),
    }).eq('user_id', supabase.auth.currentSession!.user.id);
  }

  void addTransaction(
    String date,
    double price,
    String body,
  ) async {
    List<TransactionHistory> transactions = [];
    final profile = await getProfile();
    DateFormat formatter = DateFormat('yyyy-MM-dd');
    final formattedDate = formatter.format(DateTime.now().toLocal());
    transactions.add(TransactionHistory(
        body: body,
        price: price.toString(),
        date: date,
        created_at: formattedDate));
    for (int i = 0; i < profile.transactions.length; i++) {
      transactions.add(profile.transactions[i]);
    }
    await supabase.from('profile').update({'history': transactions}).eq(
        'user_id', supabase.auth.currentSession!.user.id);
  }

  void sendMessage(String msg, String interlocutorId) async {
    await supabase.from('message').insert({
      'content': msg,
      'userTo': interlocutorId,
      'userFrom': supabase.auth.currentSession!.user.id,
      'isRead': true
    });
  }

  Future<void> googleSignIn() async {
    const webClientId =
        '626003232651-426cfh69nufeefediq08rbl41ekc9a39.apps.googleusercontent.com';

    final GoogleSignIn googleSignIn = GoogleSignIn(
      serverClientId: webClientId,
    );
    final googleUser = await googleSignIn.signIn();
    final googleAuth = await googleUser!.authentication;
    final accessToken = googleAuth.accessToken;
    final idToken = googleAuth.idToken;

    if (accessToken == null) {
      throw 'No Access Token found.';
    }
    if (idToken == null) {
      throw 'No ID Token found.';
    }

    await supabase.auth.signInWithIdToken(
      provider: OAuthProvider.google,
      idToken: idToken,
      accessToken: accessToken,
    );
  }

  Future<List<Profile>> getProfiles() async {
    final val = await supabase
        .from('profile')
        .select()
        .not('user_id', 'eq', supabase.auth.currentSession!.user.id);
    List<Profile> profiles = [];
    for (int i = 0; i < val.length; i++) {
      profiles.add(Profile.fromMap(val[i]));
    }
    return profiles;
  }

  Stream<List<Message>> getMessages(String id) {
    return supabase
        .from('message')
        .stream(primaryKey: ['id'])
        .inFilter('userFrom', [id, supabase.auth.currentSession!.user.id])
        .order('created_at', ascending: true)
        .map((event) => (event.map((e) => Message.fromMap(e))).toList());
  }

  Stream<List<Stage>> getLastPackage() {
    return supabase
        .from('package')
        .stream(primaryKey: ['id'])
        .eq('id_user', supabase.auth.currentSession!.user.id)
        .order('created_at')
        .map((event) =>
            (event.map((e) => Stage.fromMap(jsonDecode(e['stage'])))).toList());
  }
}
