import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:vs1/domain/forgot_model.dart';
import 'package:vs1/presentation/style/colors.dart';
import 'package:vs1/presentation/style/fontStyle.dart';

class Forgot extends StatelessWidget {
  const Forgot({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ForgotModel(),
      child: const SubForgot(),
    );
  }
}

class SubForgot extends StatelessWidget {
  const SubForgot({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<ForgotModel>();
    if (model.connective == 'none') {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                backgroundColor: Colors.white,
                title: const Text(
                  'No internet',
                  style: TextStyle(color: colors.secondaryDark),
                ),
                actions: [
                  ElevatedButton(
                      style: const ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.white)),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        'Back',
                        style: TextStyle(color: colors.secondaryDark),
                      )),
                ],
              );
            });
      });
    }
    if (model.Error != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                backgroundColor: Colors.white,
                title: Text(
                  '${model.Error}',
                  style: const TextStyle(color: colors.secondaryDark),
                ),
                actions: [
                  ElevatedButton(
                      style: const ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.white)),
                      onPressed: () {
                        model.Error = null;
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        'Back',
                        style: TextStyle(color: colors.secondaryDark),
                      )),
                ],
              );
            });
      });
    }
    return Container(
      color: Colors.white,
      child: SafeArea(
          child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 110.h,
              ),
              Text(
                'Forgot Password',
                style: fontStyle.title,
              ),
              SizedBox(
                height: 8.h,
              ),
              Text(
                'Enter your email address',
                style: fontStyle.labelGreyBoard,
              ),
              SizedBox(
                height: 56.h,
              ),
              Text(
                'Email Address',
                style: fontStyle.labelGreyBoard,
              ),
              SizedBox(
                height: 8.h,
              ),
              const EmailField(),
              SizedBox(
                height: 56.h,
              ),
              const SendOtpButton(),
              SizedBox(
                height: 20.h,
              ),
              const SignInLabel()
            ],
          ),
        ),
      )),
    );
  }
}

class SignInLabel extends StatelessWidget {
  const SignInLabel({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.read<ForgotModel>();
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Remember password? Back to',
            style: fontStyle.labelGreyBoard,
          ),
          SizedBox(
            width: 1.w,
          ),
          GestureDetector(
            onTap: () => model.goToLogIn(context),
            child: Text(
              'Sign in',
              style: fontStyle.skipBoard,
            ),
          ),
        ],
      ),
    );
  }
}

class SendOtpButton extends StatelessWidget {
  const SendOtpButton({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<ForgotModel>();
    return SizedBox(
        width: 342.w,
        height: 46.h,
        child: ElevatedButton(
          onPressed: () => model.emailValid
              ? {model.setLoad(), model.goToOtp(context)}
              : null,
          style: ButtonStyle(
              elevation: const MaterialStatePropertyAll(0),
              backgroundColor: MaterialStatePropertyAll(
                  model.emailValid ? colors.main : colors.gray2),
              shape: const MaterialStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4.69))))),
          child: model.isLoading
              ? SizedBox(
                  width: 20.w,
                  height: 20.h,
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  ),
                )
              : Text(
                  'Send OTP',
                  style: fontStyle.nextBoard,
                ),
        ));
  }
}

class EmailField extends StatelessWidget {
  const EmailField({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<ForgotModel>();
    return SizedBox(
      width: 342.w,
      height: 44.h,
      child: TextField(
        cursorColor: colors.main,
        style: fontStyle.field,
        keyboardType: TextInputType.emailAddress,
        onChanged: (value) {
          model.email = value;
          model.setEmail(model.email);
        },
        decoration: InputDecoration(
          hintText: '***********@mail.com',
          contentPadding:
              EdgeInsets.symmetric(horizontal: 10.w, vertical: 14.h),
          hintStyle: fontStyle.hint,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(
              color: colors.gray2,
            ),
          ),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(
              color: colors.gray2,
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(
              color: colors.gray2,
            ),
          ),
          errorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(
              color: colors.gray2,
            ),
          ),
        ),
      ),
    );
  }
}
