import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/provide/details_info.dart';
import 'package:provider/provider.dart';

class DetailsTabbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bool isLeft = Provider.of<DetailsInfoProvide>(context).isLeft;
    final bool isRight = Provider.of<DetailsInfoProvide>(context).isRight;

    return Container(
      margin: EdgeInsets.only(top: 15),
      child: Row(
        children: <Widget>[
          _myTabBarLeft(context, isLeft),
          _myTabBarRight(context, isRight)
        ],
      )
    );
  }

  Widget _myTabBarLeft(BuildContext context, bool isLeft) {
    return InkWell(
      onTap: () {
        Provider.of<DetailsInfoProvide>(context).changeLeftAndRight('left');
      },
      child: Container(
        padding: EdgeInsets.all(10),
        alignment: Alignment.center,
        width: ScreenUtil().setWidth(375),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(bottom: BorderSide(width: 1, color: isLeft ? Colors.pink : Colors.black12))
        ),
        child: Text('详情', style: TextStyle(
          color: isLeft ? Colors.pink : Colors.black12
        )),
      ),
    );
  }

  Widget _myTabBarRight(BuildContext context, bool isRight) {
    return InkWell(
      onTap: () {
        Provider.of<DetailsInfoProvide>(context).changeLeftAndRight('right');
      },
      child: Container(
        padding: EdgeInsets.all(10),
        alignment: Alignment.center,
        width: ScreenUtil().setWidth(375),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(bottom: BorderSide(width: 1, color: isRight ? Colors.pink : Colors.black12))
        ),
        child: Text('评论', style: TextStyle(
          color: isRight ? Colors.pink : Colors.black12
        )),
      ),
    );
  }
}