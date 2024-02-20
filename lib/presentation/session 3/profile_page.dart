// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:vs1/domain/session%203/profile_page_model.dart';
import 'package:vs1/presentation/style/colors.dart';
import 'package:vs1/presentation/style/fontStyle.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProfileModel(context),
      child: const SubProfilePage(),
    );
  }
}

class SubProfilePage extends StatelessWidget {
  const SubProfilePage({super.key});

  get child => null;

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
                      'Profile',
                      style: fontStyle.appBarTitle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              shadowColor: Theme.of(context).shadowColor,
              elevation: 3,
              centerTitle: true,
            ),
          ),
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 27.h,
              ),
              const MiniProfile(),
              SizedBox(
                height: 26.5.h,
              ),
              const DarkMode(),
              SizedBox(
                height: 19.h,
              ),
              const Services()
            ],
          ),
        ),
      )),
    );
  }
}

class DarkMode extends StatelessWidget {
  const DarkMode({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<ProfileModel>();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Enable dark Mode',
            style: Theme.of(context).brightness == Brightness.dark
                ? fontStyle.activeTrackId
                : fontStyle.titleLabel,
          ),
          const Spacer(),
          SizedBox(
            width: 40.625.w,
            height: 20.31.h,
            child: Transform.scale(
              scale: 0.85,
              child: CupertinoSwitch(
                  value: model.saveVal,
                  activeColor: colors.main,
                  onChanged: (value) {
                    model.setVal(context);
                  }),
            ),
          ),
        ],
      ),
    );
  }
}

class MiniProfile extends StatelessWidget {
  const MiniProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<ProfileModel>();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
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
                  model.profile != null ? model.profile!.name : '',
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

class Services extends StatelessWidget {
  const Services({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<ProfileModel>();
    return ListView.builder(
      itemCount: model.services.length,
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (BuildContext context, int index) => Padding(
        padding: EdgeInsets.only(left: 25.w, right: 25.w, bottom: 12.h),
        child: ServiceItem(
          index: index,
        ),
      ),
    );
  }
}

class ServiceItem extends StatelessWidget {
  int index;
  ServiceItem({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<ProfileModel>();
    return GestureDetector(
      onTap: () => model.services[index].path.isNotEmpty
          ? model.GoToService(model.services[index].path, context)
          : index == model.services.length - 1
              ? model.logOut(context)
              : null,
      child: Container(
        width: 342.w,
        height: model.services[index].title == 'Log Out' ? 50.h : 62.h,
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.dark
              ? colors.secondaryDark
              : Colors.white,
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).shadowColor,
              spreadRadius: 1,
              blurRadius: 15,
              offset: const Offset(5, 5),
            ),
            BoxShadow(
                color: Theme.of(context).shadowColor,
                offset: const Offset(5, 5),
                blurRadius: 15,
                spreadRadius: 1),
          ],
        ),
        child: Row(
            crossAxisAlignment: model.services[index].title == 'Log Out'
                ? CrossAxisAlignment.center
                : CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 12.w,
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: model.services[index].title == 'Log Out' ? 0.h : 18.h),
                child: SvgPicture.asset(
                  model.services[index].picture,
                  colorFilter: ColorFilter.mode(
                      model.services[index].title == 'Log Out'
                          ? colors.error
                          : Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : Colors.black,
                      BlendMode.srcIn),
                ),
              ),
              SizedBox(
                width: 9.w,
              ),
              model.services[index].title == 'Log Out'
                  ? Padding(
                      padding: EdgeInsets.symmetric(vertical: 13.h),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            model.services[index].title,
                            style:
                                Theme.of(context).brightness == Brightness.dark
                                    ? fontStyle.activeTrackId
                                    : fontStyle.titleLabel,
                          ),
                        ],
                      ),
                    )
                  : Padding(
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            model.services[index].title,
                            style:
                                Theme.of(context).brightness == Brightness.dark
                                    ? fontStyle.activeTrackId
                                    : fontStyle.titleLabel,
                          ),
                          Text(
                            model.services[index].label,
                            style: fontStyle.serviceLabel,
                          ),
                        ],
                      ),
                    ),
              const Spacer(),
              Center(
                child: GestureDetector(
                    onTap: () {},
                    child: SvgPicture.asset(
                        Theme.of(context).brightness == Brightness.dark
                            ? 'assets/image/arrow_down_dark.svg'
                            : 'assets/image/arrow_down.svg')),
              ),
              SizedBox(
                width: 12.w,
              )
            ]),
      ),
    );
  }
}
