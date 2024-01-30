import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:vs1/domain/session%202/forgot_model.dart';
import 'package:vs1/style/colors.dart';
import 'package:vs1/style/fontStyle.dart';

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
    return Container(
      color: Colors.white,
      child: SafeArea(
          child: Scaffold(
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
          onPressed: () => model.emailValid ? model.goToOtp(context) : null,
          style: ButtonStyle(
              elevation: const MaterialStatePropertyAll(0),
              backgroundColor: MaterialStatePropertyAll(
                  model.emailValid ? colors.main : colors.gray2),
              shape: const MaterialStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4.69))))),
          child: Text(
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
        showCursor: false,
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
