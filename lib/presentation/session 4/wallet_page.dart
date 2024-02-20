// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:vs1/domain/session%204/wallet_model.dart';
import 'package:vs1/presentation/style/colors.dart';
import 'package:vs1/presentation/style/fontStyle.dart';

class WalletPage extends StatelessWidget {
  const WalletPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => WalletModel(),
      child: const SubWalletPage(),
    );
  }
}

class SubWalletPage extends StatelessWidget {
  const SubWalletPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SafeArea(
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(84.h),
            child: PreferredSize(
              preferredSize: Size.fromHeight(84.h),
              child: AppBar(
                automaticallyImplyLeading: false,
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(0),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 15.h),
                      child: Text(
                        'Wallet',
                        style: fontStyle.appBarTitle,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                shadowColor: Theme.of(context).shadowColor,
                elevation: 3,
                centerTitle: true,
                backgroundColor: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 48.5.h,
                ),
                const MiniProfile(),
                SizedBox(
                  height: 35.5.h,
                ),
                const TopUp(),
                SizedBox(
                  height: 41.h,
                ),
                const Transaction(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Transaction extends StatelessWidget {
  const Transaction({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Transaction History',
            style: Theme.of(context).brightness == Brightness.dark
                ? fontStyle.littleTitleWhite
                : fontStyle.littleTitle,
          ),
          SizedBox(
            height: 24.h,
          ),
          const TransactionList()
        ],
      ),
    );
  }
}

class TransactionList extends StatelessWidget {
  const TransactionList({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<WalletModel>();
    return ListView.builder(
      shrinkWrap: true,
      itemCount: model.history.length,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (BuildContext context, int index) => Padding(
        padding: EdgeInsets.only(bottom: 12.h),
        child: TransactionItem(
          index: index,
        ),
      ),
    );
  }
}

class TransactionItem extends StatelessWidget {
  int index;
  TransactionItem({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<WalletModel>();
    return Container(
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
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  double.parse(model.history[index].price) < 0
                      ? '-${model.history[index].price.toString().replaceAll(RegExp(r'-'), 'N')}'
                      : 'N${model.history[index].price}',
                  style: double.parse(model.history[index].price) > 0
                      ? fontStyle.plus
                      : fontStyle.minus,
                ),
                SizedBox(
                  height: 4.h,
                ),
                Text(
                  model.history[index].body,
                  style: fontStyle.labelTransaction,
                ),
              ],
            ),
          ),
          const Spacer(),
          Text(
            model.history[index].date,
            style: fontStyle.termsLabel,
          ),
          SizedBox(
            width: 12.w,
          )
        ],
      ),
    );
  }
}

class TopUp extends StatelessWidget {
  const TopUp({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<WalletModel>();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Container(
        width: 341.43.w,
        height: 120.h,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            SizedBox(height: 10.h),
            Text(
              'Top Up',
              style: Theme.of(context).brightness == Brightness.dark
                  ? fontStyle.titleLabelWhite
                  : fontStyle.titleBanner,
            ),
            SizedBox(height: 12.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Container(
                      width: 49.43.w,
                      height: 48.h,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: colors.main,
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(14.w),
                        child: SvgPicture.asset(
                          Theme.of(context).brightness == Brightness.dark
                              ? 'assets/image/bank_dark.svg'
                              : 'assets/image/bank.svg',
                          width: 21.43.w,
                          height: 20.h,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    Text(
                      'Bank',
                      style: Theme.of(context).brightness == Brightness.dark
                          ? fontStyle.countMsg
                          : fontStyle.labelBlack,
                    )
                  ],
                ),
                SizedBox(
                  width: 50.w,
                ),
                Column(
                  children: [
                    Container(
                      width: 49.43.w,
                      height: 48.h,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: colors.main,
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(14.w),
                        child: SvgPicture.asset(
                          Theme.of(context).brightness == Brightness.dark
                              ? 'assets/image/transfer_dark.svg'
                              : 'assets/image/transfer.svg',
                          width: 21.43.w,
                          height: 20.h,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    Text(
                      'Transfer',
                      style: Theme.of(context).brightness == Brightness.dark
                          ? fontStyle.countMsg
                          : fontStyle.labelBlack,
                    )
                  ],
                ),
                SizedBox(
                  width: 50.w,
                ),
                Column(
                  children: [
                    GestureDetector(
                      onTap: () => model.goToPayment(context),
                      child: Container(
                        width: 49.43.w,
                        height: 48.h,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: colors.main,
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(14.w),
                          child: SvgPicture.asset(
                            Theme.of(context).brightness == Brightness.dark
                                ? 'assets/image/card_dark.svg'
                                : 'assets/image/Card.svg',
                            width: 21.43.w,
                            height: 20.h,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    Text(
                      'Card',
                      style: Theme.of(context).brightness == Brightness.dark
                          ? fontStyle.countMsg
                          : fontStyle.labelBlack,
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class MiniProfile extends StatelessWidget {
  const MiniProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<WalletModel>();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Avatar(),
          SizedBox(
            width: 5.w,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.profile != null ? '${model.profile?.name}' : '',
                  style: Theme.of(context).brightness == Brightness.dark
                      ? fontStyle.activeTrackId
                      : fontStyle.titleLabel,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Current balance:',
                      style: Theme.of(context).brightness == Brightness.dark
                          ? fontStyle.countMsg
                          : fontStyle.labelBlack,
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    Text(
                      model.isObscureBalance
                          ? '******'
                          : 'N${model.profile != null ? model.profile!.balance : ''}',
                      style: fontStyle.mainLabel,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Spacer(),
          Padding(
            padding: EdgeInsets.only(top: 20.h),
            child: GestureDetector(
              onTap: () => model.setObscureBalance(),
              child: SvgPicture.asset(model.isObscureBalance
                  ? Theme.of(context).brightness == Brightness.dark
                      ? 'assets/image/eye_slash_dark.svg'
                      : 'assets/image/eye-slash.svg'
                  : Theme.of(context).brightness == Brightness.dark
                      ? 'assets/image/eye_dark.svg'
                      : 'assets/image/eye.svg'),
            ),
          ),
          SizedBox(
            width: 10.w,
          )
        ],
      ),
    );
  }
}

class Avatar extends StatelessWidget {
  const Avatar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60.w,
      height: 60.h,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
            image: AssetImage('assets/image/avatar.png'), fit: BoxFit.cover),
      ),
    );
  }
}
