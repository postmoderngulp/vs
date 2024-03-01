import 'dart:io';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:vs1/entity/card.dart';
import 'package:vs1/presentation/navigation/navigate.dart';
import 'package:vs1/repository/supabase_service.dart';

class HomeModel extends ChangeNotifier {
  List<String> routes = ['', NavigateRoute.send, '', NavigateRoute.chats];
  String name = '';
  int val = 0;
  bool alertError = false;
  bool connectiveAlert = false;
  String? connective;
  String? Error;
  Uint8List? image;
  List<Uint8List> bytes = [];

  HomeModel() {
    _setup();
  }

  void _setup() async {
    Connectivity().checkConnectivity().then((value) {
      connective = value.name;
      notifyListeners();
    });
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      connective = result.name;
      notifyListeners();
    });
    getImages();
    await downloadImage();
    SupaBaseService service = SupaBaseService();

    final profile = await service.getProfile();
    name = profile.name;
    notifyListeners();
  }

  void getCacheImages() async {
    int imageCount = 0;
    bool imageExist = true;
    while (imageExist) {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/my_image$imageCount.png');
      if (await file.exists()) {
        bytes.add(await file.readAsBytes());
        imageCount++;
      } else {
        imageExist = false;
      }
    }
    notifyListeners();
  }

  Future<void> uploadImage(ImageSource source) async {
    SupaBaseService service = SupaBaseService();
    final picker = ImagePicker();
    final imageFile = await picker.pickImage(
      source: source,
    );
    if (imageFile == null) {
      return;
    }
    try {
      final bytes = await imageFile.readAsBytes();
      if (image == null) {
        await service.upLoadImage(
            Supabase.instance.client.auth.currentSession!.user.id, bytes);
      } else {
        await service
            .upDateImage(
                Supabase.instance.client.auth.currentSession!.user.id, bytes)
            .then((value) async {
          await downloadImage();
        });
      }
    } catch (error) {
      getCacheImage();
      Error = error.toString();
      notifyListeners();
    }
  }

  Future<void> downloadImage() async {
    try {
      SupaBaseService service = SupaBaseService();
      await service
          .downloadImage(Supabase.instance.client.auth.currentSession!.user.id)
          .then((value) {
        image == value ? downloadImage() : {image = value, cacheImage(value)};
      });
      notifyListeners();
    } catch (e) {
      getCacheImage();
      print(e.toString());
      if (e.toString() !=
          'StorageException(message: Object not found, statusCode: 404, error: not_found)') {
        Error = e.toString();
      }

      notifyListeners();
    }
  }

  void cacheImage(Uint8List imageData) async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/my_image.png');
    await file.writeAsBytes(imageData);
  }

  void getCacheImage() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/my_image.png');
    if (await file.exists()) {
      image = await file.readAsBytes();
      notifyListeners();
    }
  }

  void getImages() async {
    try {
      SupaBaseService service = SupaBaseService();
      final val = await service.downloadImages();
      for (int i = 0; i < val.length; i++) {
        if (val[i].id != null) {
          bytes.add(await getImage(val[i].name));
        }
      }
      cacheAdd();
      notifyListeners();
    } catch (e) {
      Error = e.toString();
      getCacheImages();
      notifyListeners();
    }
  }

  void cacheAdd() async {
    final directory = await getApplicationDocumentsDirectory();
    for (int i = 0; i < bytes.length; i++) {
      final file = File('${directory.path}/my_image$i.png');
      await file.writeAsBytes(bytes[i]);
    }
  }

  Future<Uint8List> getImage(String? name) async {
    SupaBaseService service = SupaBaseService();
    final image = await service.getImage(name!);
    return image;
  }

  List<card> cards = [
    card(
        picture: 'customer',
        title: 'Customer care',
        label:
            'Our customer care service line is available from 8 -9pm week days and 9 - 5 weekends - tap to call us today'),
    card(
        picture: 'send_package',
        title: 'Send a package',
        label:
            'Request for a driver to pick up or deliver your package for you'),
    card(
        picture: 'fund_wallet',
        title: 'Fund your wallet',
        label:
            'To fund your wallet is as easy as ABC, make use of our fast technology and top-up your wallet today'),
    card(
        picture: 'chats',
        title: 'Chats',
        label: 'Search for available rider within your area'),
  ];

  void setVal(int index) {
    val = index;
    notifyListeners();
  }

  void goToScreen(BuildContext context, String route) {
    if (route.isEmpty) return;
    Navigator.of(context).pushNamed(route);
  }
}
