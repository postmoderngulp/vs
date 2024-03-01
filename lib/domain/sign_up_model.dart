import 'dart:io';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:vs1/presentation/navigation/navigate.dart';
import 'package:path/path.dart' as path;
import 'package:vs1/repository/supabase_service.dart';

class SignUpModel extends ChangeNotifier {
  String name = '';
  String number = '';
  String email = '';
  String? connective;
  String? Error;
  String password = '';
  String repeatPassword = '';
  String pdfPath = '';

  bool nameValid = false;
  bool numberValid = false;
  bool? emailValid;
  bool isLoading = false;
  bool passwordValid = false;
  bool repeatValid = false;
  bool isChecked = false;
  bool isObscurePassword = true;
  bool isObscureConfirm = true;

  SignUpModel() {
    _setup();
  }

  Future<void> _setup() async {
    Connectivity().checkConnectivity().then((value) {
      connective = value.name;
      notifyListeners();
    });
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      connective = result.name;
      notifyListeners();
    });
    ByteData byteData = await rootBundle.load('assets/pdf.pdf');
    String fileName = 'pdf.pdf';

    // Get the application documents directory
    Directory appDocDir = await getApplicationDocumentsDirectory();

    // Create a new file in the documents directory
    File file = File(path.join(appDocDir.path, fileName));

    // Write the byte data to the file
    await file.writeAsBytes(byteData.buffer.asUint8List());

    // Get the path to the file
    pdfPath = file.path;
    notifyListeners();
  }

  void googleLogIn(BuildContext context) async {
    SupaBaseService service = SupaBaseService();
    await service.googleSignIn();
    Navigator.of(context)
        .pushNamedAndRemoveUntil(NavigateRoute.home, (route) => false);
  }

  void setName() {
    nameValid = name.length >= 4 ? true : false;
    notifyListeners();
  }

  void setLoad() {
    isLoading = true;
    notifyListeners();
  }

  void signUp(String name, String email, String password, String number,
      BuildContext context) async {
    try {
      SupaBaseService service = SupaBaseService();
      await service.signUp(name, email, password, number);
      isLoading = false;
      goToLogIn(context);
    } catch (error) {
      isLoading = false;
      Error = error.toString();
      notifyListeners();
      print(error);
    }
  }

  void setNumber() {
    numberValid = number.length == 11 ? true : false;
    notifyListeners();
  }

  void setEmail(String email) {
    emailValid = emailValid =
        RegExp(r'^[a-z0-9]+@[a-z0-9]+\.[a-z]{2,}$').hasMatch(email);
    notifyListeners();
  }

  void setPassword() {
    passwordValid = password.length >= 6 ? true : false;
    notifyListeners();
  }

  void setRepeatPassword() {
    repeatValid = repeatPassword == password ? true : false;
    notifyListeners();
  }

  void setCheck() {
    isChecked = !isChecked;
    notifyListeners();
  }

  void setObscurePassword() {
    isObscurePassword = !isObscurePassword;
    notifyListeners();
  }

  void setObscureConfirm() {
    isObscureConfirm = !isObscureConfirm;
    notifyListeners();
  }

  void goToLogIn(BuildContext context) {
    Navigator.of(context).pushNamed(NavigateRoute.signIn);
  }
}
