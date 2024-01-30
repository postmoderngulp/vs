import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:vs1/domain/session%202/sign_up_model.dart';
import 'package:vs1/style/colors.dart';
import 'package:vs1/style/fontStyle.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SignUpModel(),
      child: const SubSignUp(),
    );
  }
}

class SubSignUp extends StatelessWidget {
  const SubSignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 36.h,
                  ),
                  Text(
                    'Create an account',
                    style: fontStyle.title,
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Text(
                    'Complete the sign up process to get started',
                    style: fontStyle.labelGreyBoardMedium,
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Text(
                    'Full name',
                    style: fontStyle.labelGreyBoardMedium,
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  const NameField(),
                  SizedBox(
                    height: 24.h,
                  ),
                  Text(
                    'Phone Number',
                    style: fontStyle.labelGreyBoardMedium,
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  const PhoneField(),
                  SizedBox(
                    height: 24.h,
                  ),
                  Text(
                    'Email Address',
                    style: fontStyle.labelGreyBoardMedium,
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
                    style: fontStyle.labelGreyBoardMedium,
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  const PasswordField(),
                  SizedBox(
                    height: 24.h,
                  ),
                  Text(
                    'Confirm Password',
                    style: fontStyle.labelGreyBoardMedium,
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  const ConfirmPasswordField(),
                  SizedBox(
                    height: 37.h,
                  ),
                  const Terms(),
                  SizedBox(
                    height: 64.h,
                  ),
                  const SignUpButton(),
                  SizedBox(
                    height: 20.h,
                  ),
                  const SignIn(),
                  SizedBox(
                    height: 18.h,
                  ),
                  Center(
                    child: Text(
                      'or sign in using',
                      textAlign: TextAlign.center,
                      style: fontStyle.labelGreyBoard,
                    ),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  const GoogleAuth(),
                  SizedBox(
                    height: 28.h,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class GoogleAuth extends StatelessWidget {
  const GoogleAuth({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
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

class SignIn extends StatelessWidget {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.read<SignUpModel>();
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

class Terms extends StatelessWidget {
  const Terms({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<SignUpModel>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 14.w,
          height: 14.h,
          child: Checkbox(
              side: const BorderSide(
                color: colors.main,
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(2)),
              activeColor: colors.main,
              checkColor: Colors.white,
              value: model.isChecked,
              onChanged: (val) {
                model.setCheck();
              }),
        ),
        SizedBox(
          width: 11.w,
        ),
        Expanded(
          child: GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const PDFView(
                        filePath:
                            '/storage/emulated/0/Download/f6-tekhnicheskoe-opisanie (1) (1).pdf',
                      )),
            ),
            child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    style: fontStyle.termsLabel,
                    text: 'By ticking this box, you agree to our ',
                    children: [
                      TextSpan(
                        text: 'Terms and conditions and private policy',
                        style: fontStyle.termsLabelWarning,
                      )
                    ])),
          ),
        ),
      ],
    );
  }
}

class SignUpButton extends StatelessWidget {
  const SignUpButton({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<SignUpModel>();
    return SizedBox(
        width: 342.w,
        height: 46.h,
        child: ElevatedButton(
          onPressed: () => model.emailValid &&
                  model.nameValid &&
                  model.numberValid &&
                  model.passwordValid &&
                  model.repeatValid &&
                  model.isChecked
              ? model.goToLogIn(context)
              : null,
          style: ButtonStyle(
              elevation: const MaterialStatePropertyAll(0),
              backgroundColor: MaterialStatePropertyAll(model.emailValid &&
                      model.nameValid &&
                      model.numberValid &&
                      model.passwordValid &&
                      model.repeatValid &&
                      model.isChecked
                  ? colors.main
                  : colors.gray2),
              shape: const MaterialStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4.69))))),
          child: Text(
            'Sign Up',
            style: fontStyle.nextBoard,
          ),
        ));
  }
}

class NameField extends StatelessWidget {
  const NameField({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<SignUpModel>();
    return SizedBox(
      width: 342.w,
      height: 44.h,
      child: TextField(
        showCursor: false,
        style: fontStyle.field,
        keyboardType: TextInputType.text,
        onChanged: (value) {
          model.name = value;
          model.setName();
        },
        decoration: InputDecoration(
          hintText: 'Ivanov Ivan',
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

class PhoneField extends StatelessWidget {
  const PhoneField({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<SignUpModel>();
    return SizedBox(
      width: 342.w,
      height: 44.h,
      child: TextField(
        showCursor: false,
        style: fontStyle.field,
        keyboardType: TextInputType.number,
        onChanged: (value) {
          model.number = value;
          model.setNumber();
        },
        decoration: InputDecoration(
          hintText: '+7(999)999-99-99',
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

class EmailField extends StatelessWidget {
  const EmailField({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<SignUpModel>();
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

class PasswordField extends StatelessWidget {
  const PasswordField({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<SignUpModel>();
    return SizedBox(
      width: 342.w,
      height: 44.h,
      child: TextField(
        showCursor: false,
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

class ConfirmPasswordField extends StatelessWidget {
  const ConfirmPasswordField({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<SignUpModel>();
    return SizedBox(
      width: 342.w,
      height: 44.h,
      child: TextField(
        showCursor: false,
        style: fontStyle.field,
        obscureText: model.isObscureConfirm,
        onChanged: (value) {
          model.repeatPassword = value;
          model.setRepeatPassword();
        },
        decoration: InputDecoration(
          suffixIcon: GestureDetector(
            onTap: () => model.setObscureConfirm(),
            child: Padding(
              padding: EdgeInsets.only(right: 10.w, top: 14.h, bottom: 14.h),
              child: SvgPicture.asset(
                model.isObscureConfirm
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
