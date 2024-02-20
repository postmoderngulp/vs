import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:vs1/domain/session%204/payment_model.dart';
import 'package:vs1/presentation/style/colors.dart';
import 'package:vs1/presentation/style/fontStyle.dart';

class PaymentMethod extends StatelessWidget {
  const PaymentMethod({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PaymentModel(),
      child: const SubPayment(),
    );
  }
}

class SubPayment extends StatelessWidget {
  const SubPayment({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<PaymentModel>();
    return Container(
      child: SafeArea(
          child: Scaffold(
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(84.h),
                child: AppBar(
                  automaticallyImplyLeading: false,
                  bottom: PreferredSize(
                    preferredSize: const Size.fromHeight(0),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 15.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 22.w,
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 2.h),
                              child: GestureDetector(
                                  onTap: () => Navigator.of(context).pop(),
                                  child: SvgPicture.asset(
                                      'assets/image/back_button.svg')),
                            ),
                            const Spacer(),
                            Text(
                              'Add Payment method',
                              style: fontStyle.appBarTitle,
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              width: 34.w,
                            ),
                            const Spacer(),
                          ],
                        ),
                      ),
                    ),
                  ),
                  shadowColor: Theme.of(context).shadowColor,
                  elevation: 3,
                  centerTitle: true,
                ),
              ),
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 67.h,
                  ),
                  const Payment(),
                  SizedBox(
                    height: model.currentVal == 2 ? 182.h : 338.h,
                  ),
                  const ProceedButton()
                ],
              ))),
    );
  }
}

class Payment extends StatelessWidget {
  const Payment({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.w),
      child: Column(
        children: [
          const WalletPay(),
          SizedBox(
            height: 12.h,
          ),
          const CardPay(),
        ],
      ),
    );
  }
}

class WalletPay extends StatelessWidget {
  const WalletPay({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<PaymentModel>();
    return Container(
      width: 341.w,
      height: 84.h,
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? colors.secondaryDark
            : Colors.white,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor,
            spreadRadius: 0,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
          BoxShadow(
              color: Theme.of(context).shadowColor,
              offset: const Offset(0, 2),
              blurRadius: 5,
              spreadRadius: 0),
        ],
      ),
      child: Center(
        child: Theme(
          data: ThemeData(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent),
          child: RadioListTile(
            title: Text(
              'Pay with wallet',
              style: Theme.of(context).brightness == Brightness.dark
                  ? fontStyle.labelBoardWhite
                  : fontStyle.labelBoard,
            ),
            subtitle: Text(
              'complete the payment using your e wallet',
              style: fontStyle.termsLabel,
            ),
            activeColor: colors.main,
            fillColor: const MaterialStatePropertyAll(colors.main),
            value: 1,
            groupValue: model.currentVal,
            onChanged: (value) => model.setVal(value!),
          ),
        ),
      ),
    );
  }
}

class CardPay extends StatelessWidget {
  const CardPay({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<PaymentModel>();
    return model.currentVal == 2
        ? Container(
            width: 341.w,
            height: 240.h,
            decoration: BoxDecoration(
              color: Theme.of(context).brightness == Brightness.dark
                  ? colors.secondaryDark
                  : Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).shadowColor,
                  spreadRadius: 0,
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
                BoxShadow(
                    color: Theme.of(context).shadowColor,
                    offset: const Offset(0, 2),
                    blurRadius: 5,
                    spreadRadius: 0),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 14.w,
                ),
                RadioListTile(
                  activeColor: colors.main,
                  fillColor: const MaterialStatePropertyAll(colors.main),
                  title: Text(
                    'Credit / debit card',
                    style: Theme.of(context).brightness == Brightness.dark
                        ? fontStyle.labelBoardWhite
                        : fontStyle.labelBoard,
                  ),
                  subtitle: Text(
                    'complete the payment using your debit card',
                    style: fontStyle.termsLabel,
                  ),
                  value: 2,
                  groupValue: model.currentVal,
                  onChanged: (value) => model.setVal(value!),
                ),
                const FirstCard(),
                SizedBox(
                  height: 8.h,
                ),
                const SecondCard(),
              ],
            ),
          )
        : Container(
            width: 341.w,
            height: 84.h,
            decoration: BoxDecoration(
              color: Theme.of(context).brightness == Brightness.dark
                  ? colors.secondaryDark
                  : Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).shadowColor,
                  spreadRadius: 0,
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
                BoxShadow(
                    color: Theme.of(context).shadowColor,
                    offset: const Offset(0, 2),
                    blurRadius: 5,
                    spreadRadius: 10),
              ],
            ),
            child: Center(
              child: RadioListTile(
                activeColor: colors.main,
                fillColor: const MaterialStatePropertyAll(colors.main),
                title: Text(
                  'Credit / debit card',
                  style: Theme.of(context).brightness == Brightness.dark
                      ? fontStyle.labelBoardWhite
                      : fontStyle.labelBoard,
                ),
                subtitle: Text(
                  'complete the payment using your debit card',
                  style: fontStyle.termsLabel,
                ),
                value: 2,
                groupValue: model.currentVal,
                onChanged: (value) => model.setVal(value!),
              ),
            ),
          );
  }
}

class FirstCard extends StatelessWidget {
  const FirstCard({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<PaymentModel>();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      child: Container(
          width: 325.w,
          height: 68.h,
          decoration: BoxDecoration(
            color: Theme.of(context).brightness == Brightness.dark
                ? colors.secondaryDark
                : Colors.white,
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).shadowColor,
                spreadRadius: 0,
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
              BoxShadow(
                  color: Theme.of(context).shadowColor,
                  offset: const Offset(0, 2),
                  blurRadius: 5,
                  spreadRadius: 0),
            ],
          ),
          child: Row(
            children: [
              SizedBox(
                width: 290.w,
                child: RadioListTile(
                  activeColor: colors.main,
                  fillColor: const MaterialStatePropertyAll(colors.main),
                  title: Text(
                    '**** **** 3323',
                    style: Theme.of(context).brightness == Brightness.dark
                        ? fontStyle.labelBoardWhite
                        : fontStyle.labelBoard,
                  ),
                  value: 1,
                  groupValue: model.currentCardVal,
                  onChanged: (value) => model.setCardVal(value!),
                ),
              ),
              const Spacer(),
              SvgPicture.asset('assets/image/basket.svg'),
              SizedBox(
                width: 10.29.w,
              ),
            ],
          )),
    );
  }
}

class SecondCard extends StatelessWidget {
  const SecondCard({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<PaymentModel>();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      child: Container(
        width: 325.w,
        height: 68.h,
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.dark
              ? colors.secondaryDark
              : Colors.white,
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).shadowColor,
              spreadRadius: 0,
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
            BoxShadow(
                color: Theme.of(context).shadowColor,
                offset: const Offset(0, 2),
                blurRadius: 5,
                spreadRadius: 0),
          ],
        ),
        child: Theme(
          data: ThemeData(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent),
          child: Row(
            children: [
              SizedBox(
                width: 290.w,
                child: RadioListTile(
                  activeColor: colors.main,
                  fillColor: const MaterialStatePropertyAll(colors.main),
                  title: Text(
                    '**** **** 1547',
                    style: Theme.of(context).brightness == Brightness.dark
                        ? fontStyle.labelBoardWhite
                        : fontStyle.labelBoard,
                  ),
                  value: 2,
                  groupValue: model.currentCardVal,
                  onChanged: (value) => model.setCardVal(value!),
                ),
              ),
              const Spacer(),
              SvgPicture.asset('assets/image/basket.svg'),
              SizedBox(
                width: 10.29.w,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProceedButton extends StatelessWidget {
  const ProceedButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Center(
        child: SizedBox(
            width: 342.w,
            height: 46.h,
            child: ElevatedButton(
              onPressed: () {},
              style: const ButtonStyle(
                  elevation: MaterialStatePropertyAll(0),
                  backgroundColor: MaterialStatePropertyAll(colors.main),
                  shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8))))),
              child: Text(
                'Proceed to pay',
                style: fontStyle.titleLabelWhite,
              ),
            )),
      ),
    );
  }
}
