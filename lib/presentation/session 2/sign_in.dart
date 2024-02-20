import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:vs1/domain/session%202/sign_in_model.dart';
import 'package:vs1/presentation/style/colors.dart';
import 'package:vs1/presentation/style/fontStyle.dart';

class SignInWidget extends StatelessWidget {
  const SignInWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SignInModel(),
      child: const SubSignIn(),
    );
  }
}

class SubSignIn extends StatelessWidget {
  const SubSignIn({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 110.h,
              ),
              Text(
                'Welcome Back',
                style: fontStyle.title,
              ),
              SizedBox(
                height: 8.h,
              ),
              Text(
                'Fill in your email and password to continue',
                style: fontStyle.labelGreyBoard,
              ),
              SizedBox(
                height: 20.h,
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
                height: 24.h,
              ),
              Text(
                'Password',
                style: fontStyle.labelGreyBoard,
              ),
              SizedBox(
                height: 8.h,
              ),
              const PasswordField(),
              SizedBox(
                height: 17.h,
              ),
              const ForgotPassword(),
              SizedBox(
                height: 187.h,
              ),
              const LoginButton(),
              SizedBox(
                height: 20.h,
              ),
              const SignUpLabel(),
              SizedBox(
                height: 18.h,
              ),
              Center(
                child: Text(
                  'or log in using',
                  textAlign: TextAlign.center,
                  style: fontStyle.labelGreyBoard,
                ),
              ),
              SizedBox(
                height: 8.h,
              ),
              const GoogleAuth(),
              SizedBox(
                height: 95.h,
              ),
            ],
          ),
        ),
      ),
    ));
  }
}

class SignUpLabel extends StatelessWidget {
  const SignUpLabel({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.read<SignInModel>();
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Already have an account?',
            style: fontStyle.labelGreyBoard,
          ),
          SizedBox(
            width: 1.w,
          ),
          GestureDetector(
            onTap: () => model.goToSignUp(context),
            child: Text(
              'Sign Up',
              style: fontStyle.skipBoard,
            ),
          ),
        ],
      ),
    );
  }
}

class GoogleAuth extends StatelessWidget {
  const GoogleAuth({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<SignInModel>();
    return GestureDetector(
      onTap: () => model.googleLogIn(context),
      child: Center(
        child: SvgPicture.asset(
          'assets/image/google.svg',
          width: 16.w,
          height: 16.h,
        ),
      ),
    );
  }
}

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<SignInModel>();
    return Row(
      children: [
        SizedBox(
          width: 14.w,
          height: 14.h,
          child: Checkbox(
              side: const BorderSide(
                color: colors.gray2,
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(2)),
              activeColor: colors.main,
              checkColor: Colors.white,
              value: model.isSaved,
              onChanged: (val) => model.setCheck()),
        ),
        SizedBox(
          width: 4.w,
        ),
        Text(
          'Remember password',
          style: fontStyle.label,
        ),
        const Spacer(),
        GestureDetector(
            onTap: () => model.goToForgot(context),
            child: Text(
              'Forgot Password?',
              style: fontStyle.mainLabel,
            )),
      ],
    );
  }
}

class PasswordField extends StatelessWidget {
  const PasswordField({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<SignInModel>();
    return SizedBox(
      width: 342.w,
      height: 44.h,
      child: TextField(
        cursorColor: colors.main,
        style: fontStyle.field,
        onChanged: (value) {
          model.password = value;
          model.setPassword();
        },
        obscureText: model.isObscurePassword,
        decoration: InputDecoration(
          suffixIcon: GestureDetector(
            onTap: () => model.setObscurePassword(),
            child: Padding(
              padding: EdgeInsets.only(right: 10.w, top: 14.h, bottom: 14.h),
              child: SvgPicture.asset(
                model.isObscurePassword
                    ? 'assets/image/eye-slash.svg'
                    : 'assets/image/eye.svg',
              ),
            ),
          ),
          hintText: '**********',
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

class LoginButton extends StatelessWidget {
  const LoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<SignInModel>();
    return SizedBox(
        width: 342.w,
        height: 46.h,
        child: ElevatedButton(
          onPressed: () => model.emailValid && model.passwordValid
              ? model.signIn(model.email, model.password, context)
              : null,
          style: ButtonStyle(
              elevation: const MaterialStatePropertyAll(0),
              backgroundColor: MaterialStatePropertyAll(
                  model.emailValid && model.passwordValid
                      ? colors.main
                      : colors.gray2),
              shape: const MaterialStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4.69))))),
          child: Text(
            'Log In',
            style: fontStyle.nextBoard,
          ),
        ));
  }
}

class EmailField extends StatelessWidget {
  const EmailField({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<SignInModel>();
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
