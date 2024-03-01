import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:vs1/domain/board_model.dart';
import 'package:vs1/entity/board.dart';
import 'package:vs1/presentation/style/colors.dart';
import 'package:vs1/presentation/style/fontStyle.dart';

class OnBoard extends StatelessWidget {
  const OnBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => BoardModel(context),
      child: const SubOnBoard(),
    );
  }
}

class SubOnBoard extends StatefulWidget {
  const SubOnBoard({super.key});

  @override
  State<SubOnBoard> createState() => _OnBoardState();
}

class _OnBoardState extends State<SubOnBoard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this, // the SingleTickerProviderStateMixin
      duration: const Duration(seconds: 1),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final model = context.watch<BoardModel>();
    Animation<double> animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(_controller);
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 88.h,
          ),
          Expanded(
            child: AnimatedBuilder(
              builder: (BuildContext context, Widget? child) =>
                  Transform.translate(
                      offset: Offset(
                          animation.value * MediaQuery.of(context).size.width,
                          0.0),
                      child: child),
              animation: _controller,
              child: Center(
                child: BoardItem(
                  Board: model.item,
                ),
              ),
            ),
          ),
          // model.currentVal == model.listBoard.length - 1
          model.queueEmpty
              ? SizedBox(
                  height: 91.h,
                )
              : SizedBox(
                  height: 87.h,
                ),
          const GroupButton(),
          const SignInLabel(),
          // model.currentVal == model.listBoard.length - 1
          model.queueEmpty
              ? SizedBox(
                  height: 64.h,
                )
              : SizedBox(
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
        SvgPicture.asset(
          'assets/image/${Board.picture}.svg',
          width: Board.width,
          height: Board.height,
        ),
        SizedBox(
          height: 48.h,
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
          height: 5.h,
        ),
        SizedBox(
          width: 271.w,
          child: Text(
            Board.label,
            style: fontStyle.labelBoard,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}

class SignInLabel extends StatelessWidget {
  const SignInLabel({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<BoardModel>();
    // return model.currentVal == model.listBoard.length - 1
    return model.queueEmpty
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account?',
                      style: fontStyle.labelGreyBoard,
                    ),
                    SizedBox(
                      width: 1.w,
                    ),
                    Text(
                      'Sign in',
                      style: fontStyle.skipBoard,
                    ),
                  ],
                ),
              ],
            ),
          )
        : const SizedBox();
  }
}

class GroupButton extends StatelessWidget {
  const GroupButton({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<BoardModel>();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: // model.currentVal == model.listBoard.length - 1
          model.queueEmpty
              ? SizedBox(
                  width: 342.w,
                  height: 46.h,
                  child: ElevatedButton(
                    onPressed: () => model.signUp(context),
                    style: const ButtonStyle(
                        elevation: MaterialStatePropertyAll(0),
                        backgroundColor: MaterialStatePropertyAll(colors.main),
                        shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(4.69))))),
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
                          onPressed: () {
                            model.skip(context);
                          },
                          style: const ButtonStyle(
                              elevation: MaterialStatePropertyAll(0),
                              backgroundColor:
                                  MaterialStatePropertyAll(Colors.transparent),
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
                          onPressed: () => model.next(),
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
    );
  }
}

// class PageBoard extends StatelessWidget {
//   const PageBoard({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final model = context.watch<BoardModel>();
//     return Expanded(
//       child: PageView.builder(
//           controller: model.controller,
//           onPageChanged: (index) {
//             model.remove();
//           },
//           itemCount: model.listBoard.length,
//           itemBuilder: (BuildContext context, int index) {
//             return BoardItem(Board: model.listBoard[index]);
//           }),
//     );
//   }
// }

// class BoardItem extends StatelessWidget {
//   final board Board;
//   const BoardItem({
//     Key? key,
//     required this.Board,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         SvgPicture.asset(
//           'assets/image/${Board.picture}',
//           width: Board.width,
//           height: Board.height,
//         ),
//         SizedBox(
//           height: 48.h,
//         ),
//         SizedBox(
//           width: 287.w,
//           child: Text(
//             Board.title,
//             textAlign: TextAlign.center,
//             style: fontStyle.main,
//           ),
//         ),
//         SizedBox(
//           height: 5.h,
//         ),
//         SizedBox(
//           width: 271.w,
//           child: Text(
//             Board.label,
//             textAlign: TextAlign.center,
//           ),
//         ),
//       ],
//     );
//   }
// }
