// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vs1/pages/Holder.dart';
import 'package:vs1/entity/board.dart';
import 'package:vs1/style/colors.dart';
import 'package:vs1/style/fontStyle.dart';

void main() {
  runApp(const ScreenUtilInit(
      designSize: Size(390, 844),
      child: MaterialApp(debugShowCheckedModeBanner: false, home: MyApp())));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  PageController controller = PageController(
    initialPage: 0,
  );
  List<board> listBoard = [
    board(
        title: 'Quick Delivery At Your Doorstep',
        label: 'Enjoy quick pick-up and delivery to your destination',
        picture: SvgPicture.asset('assets/image/first_board.svg')),
    board(
        title: 'Flexible Payment',
        label:
            'Different modes of payment either before and after delivery without stress',
        picture: SvgPicture.asset('assets/image/second_board.svg')),
    board(
        title: 'Real-time Tracking',
        label:
            'Track your packages/items from the comfort of your home till final destination',
        picture: SvgPicture.asset('assets/image/third_board.svg')),
  ];
  late int currentVal;

  @override
  void initState() {
    super.initState();
    currentVal = 0;
    controller.addListener(() {
      setState(() {
        currentVal = controller.page!.round();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 88.h,
          ),
          Expanded(
            child: PageView.builder(
                onPageChanged: (index) {
                  setState(() {
                    listBoard
                        .removeWhere((element) => element == listBoard.first);
                  });
                },
                controller: controller,
                itemCount: listBoard.length,
                itemBuilder: (BuildContext context, int index) {
                  return BoardItem(Board: listBoard[index]);
                }),
          ),
          SizedBox(
            height: 87.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: currentVal == listBoard.length - 1
                ? SizedBox(
                    width: 342.w,
                    height: 46.h,
                    child: ElevatedButton(
                      onPressed: () => Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const Holder())),
                      style: const ButtonStyle(
                          elevation: MaterialStatePropertyAll(0),
                          backgroundColor:
                              MaterialStatePropertyAll(colors.main),
                          shape: MaterialStatePropertyAll(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(4.69))))),
                      child: Text(
                        'Sign Up',
                        style: fontStyle.nextBoard,
                      ),
                    ))
                : Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                          width: 100.w,
                          height: 50.h,
                          child: ElevatedButton(
                            onPressed: () => controller.animateToPage(
                                listBoard.length - 1,
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeIn),
                            style: const ButtonStyle(
                                elevation: MaterialStatePropertyAll(0),
                                backgroundColor: MaterialStatePropertyAll(
                                    Colors.transparent),
                                shape: MaterialStatePropertyAll(
                                    RoundedRectangleBorder(
                                        side: BorderSide(color: colors.main),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(4.69))))),
                            child: Text(
                              'Skip',
                              style: fontStyle.skipBoard,
                            ),
                          )),
                      const Spacer(),
                      SizedBox(
                          width: 100.w,
                          height: 50.h,
                          child: ElevatedButton(
                            onPressed: () => controller.nextPage(
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeIn),
                            style: const ButtonStyle(
                                elevation: MaterialStatePropertyAll(0),
                                backgroundColor:
                                    MaterialStatePropertyAll(colors.main),
                                shape: MaterialStatePropertyAll(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(4.69))))),
                            child: Text(
                              'Next',
                              style: fontStyle.nextBoard,
                            ),
                          )),
                    ],
                  ),
          ),
          currentVal == listBoard.length - 1
              ? Center(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20.h,
                      ),
                      Text(
                        'Already have an account?Sign in',
                        style: fontStyle.skipBoard,
                      ),
                    ],
                  ),
                )
              : const SizedBox(),
          SizedBox(
            height: 99.h,
          )
        ],
      ),
    );
  }
}

class BoardItem extends StatelessWidget {
  final board Board;
  const BoardItem({
    Key? key,
    required this.Board,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Board.picture,
        SizedBox(
          height: 53.h,
        ),
        SizedBox(
          width: 287.w,
          child: Text(
            Board.title,
            textAlign: TextAlign.center,
            style: fontStyle.main,
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        SizedBox(
          width: 271.w,
          child: Text(
            Board.label,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
