// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vs1/presentation/profile_page.dart';
import 'package:vs1/presentation/track_page.dart';
import 'package:vs1/presentation/wallet_page.dart';
import 'package:vs1/presentation/home_page.dart';
import 'package:vs1/presentation/style/fontStyle.dart';

class Home extends StatefulWidget {
  int index;
  Home({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late int selectedIndex;
  List<Widget> pages = const [
    HomePage(),
    WalletPage(),
    TrackPage(),
    ProfilePage(),
  ];

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.index;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[selectedIndex],
      bottomNavigationBar: SizedBox(
        height: 60.h,
        child: Theme(
            data: ThemeData(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent),
            child: Row(
              children: [
                SizedBox(
                  width: 16.w,
                ),
                GestureDetector(
                  onTap: () => setState(() {
                    selectedIndex = 0;
                  }),
                  child: Column(
                    children: [
                      selectedIndex == 0
                          ? SvgPicture.asset('assets/image/topMark.svg')
                          : SizedBox(
                              width: 35.w,
                              height: 2.h,
                            ),
                      SizedBox(
                        height: selectedIndex == 0 ? 6.h : 8.h,
                      ),
                      SvgPicture.asset(selectedIndex == 0
                          ? 'assets/image/home_active.svg'
                          : Theme.of(context).brightness == Brightness.dark
                              ? 'assets/image/home_dark.svg'
                              : 'assets/image/home.svg'),
                      SizedBox(
                        height: 3.h,
                      ),
                      Text(
                        'Home',
                        style: selectedIndex == 0
                            ? fontStyle.bottomLabelActive
                            : Theme.of(context).brightness == Brightness.dark
                                ? fontStyle.countMsg
                                : fontStyle.termsLabel,
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () => setState(() {
                    selectedIndex = 1;
                  }),
                  child: Column(
                    children: [
                      selectedIndex == 1
                          ? SvgPicture.asset('assets/image/topMark.svg')
                          : SizedBox(
                              width: 35.w,
                              height: 2.h,
                            ),
                      SizedBox(
                        height: selectedIndex == 1 ? 6.h : 8.h,
                      ),
                      SvgPicture.asset(selectedIndex == 1
                          ? 'assets/image/wallet_active.svg'
                          : Theme.of(context).brightness == Brightness.dark
                              ? 'assets/image/wallet_dark.svg'
                              : 'assets/image/wallet.svg'),
                      SizedBox(
                        height: 3.h,
                      ),
                      Text(
                        'Wallet',
                        style: selectedIndex == 1
                            ? fontStyle.bottomLabelActive
                            : Theme.of(context).brightness == Brightness.dark
                                ? fontStyle.countMsg
                                : fontStyle.termsLabel,
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () => setState(() {
                    selectedIndex = 2;
                  }),
                  child: Column(
                    children: [
                      selectedIndex == 2
                          ? SvgPicture.asset('assets/image/topMark.svg')
                          : SizedBox(
                              width: 35.w,
                              height: 2.h,
                            ),
                      SizedBox(
                        height: selectedIndex == 2 ? 6.h : 8.h,
                      ),
                      SvgPicture.asset(selectedIndex == 2
                          ? 'assets/image/track_active.svg'
                          : Theme.of(context).brightness == Brightness.dark
                              ? 'assets/image/track_dark.svg'
                              : 'assets/image/track.svg'),
                      SizedBox(
                        height: 3.h,
                      ),
                      Text(
                        'Track',
                        style: selectedIndex == 2
                            ? fontStyle.bottomLabelActive
                            : Theme.of(context).brightness == Brightness.dark
                                ? fontStyle.countMsg
                                : fontStyle.termsLabel,
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () => setState(() {
                    selectedIndex = 3;
                  }),
                  child: Column(
                    children: [
                      selectedIndex == 3
                          ? SvgPicture.asset('assets/image/topMark.svg')
                          : SizedBox(
                              width: 35.w,
                              height: 2.h,
                            ),
                      SizedBox(
                        height: selectedIndex == 3 ? 6.h : 8.h,
                      ),
                      SvgPicture.asset(selectedIndex == 3
                          ? 'assets/image/profile_active.svg'
                          : Theme.of(context).brightness == Brightness.dark
                              ? 'assets/image/profile_dark.svg'
                              : 'assets/image/profile.svg'),
                      SizedBox(
                        height: 3.h,
                      ),
                      Text(
                        'Profile',
                        style: selectedIndex == 3
                            ? fontStyle.bottomLabelActive
                            : Theme.of(context).brightness == Brightness.dark
                                ? fontStyle.countMsg
                                : fontStyle.termsLabel,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 17.w,
                ),
              ],
            )),
      ),
    );
  }
}


// BottomNavigationBar(
//             backgroundColor: Theme.of(context).colorScheme.primary,
//             type: BottomNavigationBarType.fixed,
//             currentIndex: selectedIndex,
//             iconSize: 24.w,
//             selectedItemColor: colors.main,
//             unselectedItemColor: Theme.of(context).brightness == Brightness.dark
//                 ? Colors.white
//                 : colors.gray2,
//             selectedLabelStyle: fontStyle.bottomLabelActive,
//             unselectedLabelStyle:
//                 Theme.of(context).brightness == Brightness.dark
//                     ? fontStyle.countMsg
//                     : fontStyle.termsLabel,
//             selectedFontSize: 12.sp,
//             unselectedFontSize: 12.sp,
//             items: [
//               BottomNavigationBarItem(
//                 icon: SvgPicture.asset(
//                   selectedIndex == 0
//                       ? 'assets/image/home_active.svg'
//                       : Theme.of(context).brightness == Brightness.dark
//                           ? 'assets/image/home_dark.svg'
//                           : 'assets/image/home.svg',
//                 ),
//                 label: 'Home',
//               ),
//               BottomNavigationBarItem(
//                   icon: SvgPicture.asset(selectedIndex == 1
//                       ? 'assets/image/wallet_active.svg'
//                       : Theme.of(context).brightness == Brightness.dark
//                           ? 'assets/image/wallet_dark.svg'
//                           : 'assets/image/wallet.svg'),
//                   label: 'Wallet'),
//               BottomNavigationBarItem(
//                   icon: SvgPicture.asset(
//                     selectedIndex == 2
//                         ? 'assets/image/track_active.svg'
//                         : Theme.of(context).brightness == Brightness.dark
//                             ? 'assets/image/track_dark.svg'
//                             : 'assets/image/track.svg',
//                   ),
//                   label: 'Track'),
//               BottomNavigationBarItem(
//                   icon: SvgPicture.asset(
//                     selectedIndex == 3
//                         ? 'assets/image/profile_active.svg'
//                         : Theme.of(context).brightness == Brightness.dark
//                             ? 'assets/image/profile_dark.svg'
//                             : 'assets/image/profile.svg',
//                   ),
//                   label: 'Profile'),
//             ],
//             onTap: (index) => setState(() {
//               selectedIndex = index;
//             }),
//           ),