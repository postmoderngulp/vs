import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:vs1/domain/session%202/otp_verify_model.dart';
import 'package:vs1/presentation/style/colors.dart';
import 'package:vs1/presentation/style/fontStyle.dart';

class OtpVerify extends StatelessWidget {
  const OtpVerify({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => OtpVerifyModel(),
      child: const SubOtpVerify(),
    );
  }
}

class SubOtpVerify extends StatelessWidget {
  const SubOtpVerify({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 115.h,
              ),
              Text(
                'OTP Verification',
                style: fontStyle.title,
              ),
              SizedBox(
                height: 8.h,
              ),
              Text(
                'Enter the 6 digit numbers sent to your email',
                style: fontStyle.labelGreyBoard,
              ),
              SizedBox(
                height: 70.h,
              ),
              const OtpFields(),
              SizedBox(
                height: 12.h,
              ),
              const reSend(),
              SizedBox(
                height: 82.h,
              ),
              const SetNewPasswordButton()
            ],
          ),
        ),
      ),
    ));
  }
}

class SetNewPasswordButton extends StatelessWidget {
  const SetNewPasswordButton({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<OtpVerifyModel>();
    return SizedBox(
        width: 342.w,
        height: 46.h,
        child: ElevatedButton(
          onPressed: () =>
              model.codeValid ? model.goToNewPassword(context) : null,
          style: ButtonStyle(
              elevation: const MaterialStatePropertyAll(0),
              backgroundColor: MaterialStatePropertyAll(
                  model.codeValid ? colors.main : colors.gray2),
              shape: const MaterialStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4.69))))),
          child: Text(
            'Set New Password',
            style: fontStyle.nextBoard,
          ),
        ));
  }
}

class reSend extends StatelessWidget {
  const reSend({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<OtpVerifyModel>();
    return Center(
      child: model.time == 0
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'If you didn’t receive code,',
                  textAlign: TextAlign.center,
                  style: fontStyle.timeLabel,
                ),
                GestureDetector(
                  onTap: () => model.resend(),
                  child: Text(
                    ' resend',
                    textAlign: TextAlign.center,
                    style: fontStyle.timeLabelResend,
                  ),
                ),
              ],
            )
          : Text(
              'If you didn’t receive code,  resend after ${(model.time == 60) ? '1:00' : '00:${model.time < 10 ? '0${model.time}' : model.time}'}',
              textAlign: TextAlign.center,
              style: fontStyle.timeLabel,
            ),
    );
  }
}

class OtpFields extends StatelessWidget {
  const OtpFields({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Wrap(
          children: List.generate(
              6,
              (index) => Padding(
                    padding: index == 5
                        ? EdgeInsets.only(right: 0.w)
                        : EdgeInsets.only(right: 30.w),
                    child: ItemOtp(
                      index: index,
                    ),
                  )),
        ),
        const Field(),
      ],
    );
  }
}

class ItemOtp extends StatelessWidget {
  int index;
  ItemOtp({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<OtpVerifyModel>();
    return Container(
      width: 32.w,
      height: 32.h,
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(
            color: model.otpList[index].isNotEmpty
                ? model.codeValid
                    ? colors.error
                    : colors.main
                : colors.gray2),
      ),
      child: Center(
        child: Text(
          model.otpList[index].isNotEmpty ? model.otpList[index] : '',
          style: fontStyle.otpLabel,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class Field extends StatelessWidget {
  const Field({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<OtpVerifyModel>();
    return TextField(
      showCursor: false,
      onChanged: (value) {
        model.setCode(value);
      },
      autofocus: true,
      keyboardType: TextInputType.number,
      style: const TextStyle(color: Colors.transparent),
      decoration: const InputDecoration(
        filled: true,
        fillColor: Colors.transparent,
        border: InputBorder.none,
        hintText: '',
      ),
    );
  }
}
