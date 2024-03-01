import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:vs1/domain/new_password_model.dart';
import 'package:vs1/presentation/style/colors.dart';
import 'package:vs1/presentation/style/fontStyle.dart';

class NewPassword extends StatelessWidget {
  const NewPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NewPasswordModel(),
      child: const SubNewPassword(),
    );
  }
}

class SubNewPassword extends StatelessWidget {
  const SubNewPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<NewPasswordModel>();
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
                  'New Password',
                  style: fontStyle.title,
                ),
                SizedBox(
                  height: 8.h,
                ),
                Text(
                  'Enter new password',
                  style: fontStyle.labelGreyBoardMedium,
                ),
                SizedBox(
                  height: 70.h,
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
                  height: 71.h,
                ),
                const LoginButton(),
                SizedBox(
                  height: 71.h,
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}

class PasswordField extends StatelessWidget {
  const PasswordField({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<NewPasswordModel>();
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

class ConfirmPasswordField extends StatelessWidget {
  const ConfirmPasswordField({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<NewPasswordModel>();
    return SizedBox(
      width: 342.w,
      height: 44.h,
      child: TextField(
        cursorColor: colors.main,
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

class LoginButton extends StatelessWidget {
  const LoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<NewPasswordModel>();
    return SizedBox(
        width: 342.w,
        height: 46.h,
        child: ElevatedButton(
          onPressed: () => model.passwordValid && model.repeatValid
              ? {model.setLoad(), model.newPassword(model.password, context)}
              : null,
          style: ButtonStyle(
              elevation: const MaterialStatePropertyAll(0),
              backgroundColor: MaterialStatePropertyAll(
                  model.repeatValid && model.passwordValid
                      ? colors.main
                      : colors.gray2),
              shape: const MaterialStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4.69))))),
          child: model.isLoad
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
                  'Log In',
                  style: fontStyle.nextBoard,
                ),
        ));
  }
}
