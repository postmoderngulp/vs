// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:vs1/domain/session%205/home_model.dart';
import 'package:vs1/presentation/navigation/navigate.dart';
import 'package:vs1/presentation/style/colors.dart';
import 'package:vs1/presentation/style/fontStyle.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeModel(),
      child: const SubHomePage(),
    );
  }
}

class SubHomePage extends StatelessWidget {
  const SubHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 24.h,
              ),
              const SearchField(),
              SizedBox(
                height: 24.h,
              ),
              const ProfileInfo(),
              SizedBox(
                height: 39.h,
              ),
              const Specials(),
              SizedBox(
                height: 7.h,
              ),
              const Adds(),
              SizedBox(
                height: 29.h,
              ),
              Text(
                'What would you like to do',
                style: fontStyle.titleServices,
              ),
              SizedBox(
                height: 9.h,
              ),
              const Cards(),
            ],
          ),
        ),
      ),
    ));
  }
}

class Adds extends StatelessWidget {
  const Adds({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [TechAdd(), Spacer(), BoxedAdd()],
    );
  }
}

class TechAdd extends StatelessWidget {
  const TechAdd({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 166.w,
      height: 64.h,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: colors.secondary),
          image: const DecorationImage(
              image: AssetImage('assets/image/first_add.png'),
              fit: BoxFit.cover)),
    );
  }
}

class BoxedAdd extends StatelessWidget {
  const BoxedAdd({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 166.w,
      height: 64.h,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: colors.secondary),
          image: const DecorationImage(
              image: AssetImage(
                'assets/image/second_add.png',
              ),
              fit: BoxFit.cover)),
    );
  }
}

class Specials extends StatelessWidget {
  const Specials({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Special for you',
          style: fontStyle.specialSecondary,
        ),
        const Spacer(),
        SvgPicture.asset('assets/image/arrow_start.svg'),
      ],
    );
  }
}

class SearchField extends StatelessWidget {
  const SearchField({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 341.w,
        height: 34.h,
        child: TextField(
          cursorColor: colors.main,
          decoration: InputDecoration(
            filled: true,
            contentPadding:
                EdgeInsets.symmetric(horizontal: 12.w, vertical: 20.h),
            hintText: 'Search services',
            hintStyle: Theme.of(context).brightness == Brightness.dark
                ? fontStyle.countMsg
                : fontStyle.termsLabel,
            suffixIcon: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 11.h),
              child: SvgPicture.asset('assets/image/search.svg'),
            ),
            border: Theme.of(context).inputDecorationTheme.enabledBorder,
            errorBorder: Theme.of(context).inputDecorationTheme.enabledBorder,
            enabledBorder: Theme.of(context).inputDecorationTheme.enabledBorder,
            focusedBorder: Theme.of(context).inputDecorationTheme.enabledBorder,
            disabledBorder:
                Theme.of(context).inputDecorationTheme.enabledBorder,
          ),
        ));
  }
}

class Cards extends StatelessWidget {
  const Cards({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<HomeModel>();
    return Wrap(
      children: List.generate(
          model.cards.length,
          (index) => CardsItem(
                index: index,
              )),
    );
  }
}

class CardsItem extends StatelessWidget {
  int index;
  CardsItem({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<HomeModel>();
    return GestureDetector(
      onTap: () => model.goToScreen(context, model.routes[index]),
      child: Padding(
        padding: EdgeInsets.only(
            bottom: 23.h, right: index == 0 || index == 2 ? 23.w : 0.w),
        child: Container(
          width: 159.w,
          height: 159.h,
          decoration: BoxDecoration(
            color: Theme.of(context).brightness == Brightness.dark
                ? colors.secondaryDark
                : colors.gray6,
            borderRadius: BorderRadius.circular(8),
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
                height: 32.5.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 14.w),
                child: SvgPicture.asset(
                  'assets/image/${model.cards[index].picture}.svg',
                  colorFilter:
                      const ColorFilter.mode(colors.main, BlendMode.srcIn),
                ),
              ),
              SizedBox(
                height: 12.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 8.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model.cards[index].title,
                      style: fontStyle.trackId,
                    ),
                    SizedBox(
                      height: 6.h,
                    ),
                    SizedBox(
                        width: 127.w,
                        child: Text(
                          model.cards[index].label,
                          style: Theme.of(context).textTheme.labelSmall,
                        )),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileInfo extends StatelessWidget {
  const ProfileInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<HomeModel>();
    return Container(
      width: 341.w,
      height: 91.h,
      decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.dark
              ? colors.secondaryDark
              : colors.main,
          borderRadius: BorderRadius.circular(8)),
      child: Stack(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(3),
                    child: Theme.of(context).brightness == Brightness.dark
                        ? SvgPicture.asset('assets/image/ellipse_left_dark.svg')
                        : SvgPicture.asset('assets/image/ellipse_left.svg'),
                  )),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(3),
                child: Theme.of(context).brightness == Brightness.dark
                    ? SvgPicture.asset('assets/image/ellipse_right_dark.svg')
                    : SvgPicture.asset('assets/image/ellipse_right.svg'),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 10.w,
              ),
              Container(
                width: 60.14.w,
                height: 60.14.h,
                decoration: BoxDecoration(
                    image: const DecorationImage(
                        image: AssetImage('assets/image/avatar.png'),
                        fit: BoxFit.cover),
                    border: Border.all(color: colors.gray1),
                    shape: BoxShape.circle),
              ),
              SizedBox(
                width: 6.w,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.name,
                    style: fontStyle.titleProfile,
                  ),
                  Text(
                    'We trust you are having a great time',
                    style: fontStyle.hintSend,
                  ),
                ],
              ),
              const Spacer(),
              GestureDetector(
                  onTap: () => Navigator.of(context)
                      .pushNamed(NavigateRoute.notification),
                  child: SvgPicture.asset('assets/image/bell.svg')),
              SizedBox(
                width: 10.w,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
