import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/provide/cart.dart';
import 'package:provider/provider.dart';

class CartBottom extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
  
    return Container(
      padding: EdgeInsets.all(5),
      color: Colors.white,
      child: Row(
        children: <Widget>[
          selectAllBtn(context),
          allPriceArea(context),
          goButton(context)
        ],
      ),
    );
  }

  Widget selectAllBtn(context) {
    CartProvide cartProvideData = Provider.of<CartProvide>(context);
    return Container(
      child: Row(
        children: <Widget>[
          Checkbox(
            value: cartProvideData.isAllCheck,
            activeColor: Colors.pink,
            onChanged: (bool val) {
              cartProvideData.changeAllCheckBtnState(val);
            },
          ),
          Text('全选')
        ],
      ),
    );
  }

  Widget allPriceArea(context) {
    final double allPrice = Provider.of<CartProvide>(context).allPrice;
    return Container(
      width: ScreenUtil().setWidth(430),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                alignment: Alignment.centerRight,
                width: ScreenUtil().setWidth(200),
                child: Text('合计', style: TextStyle(
                  fontSize: ScreenUtil().setSp(36)
                )),
              ),
              Container(
                alignment: Alignment.centerLeft,
                width: ScreenUtil().setWidth(200),
                child: Text('￥$allPrice', style: TextStyle(
                  fontSize: ScreenUtil().setSp(36),
                  color: Colors.red
                )),
              )
            ],
          ),
          Container(
            width: ScreenUtil().setWidth(430),
            alignment: Alignment.centerRight,
            child: Text(
              '满10元免配送费，预购免配送费',
              style: TextStyle(
                color: Colors.black38,
                fontSize: ScreenUtil().setSp(22)
              ),
            ),
          )
        ],
      ),
    );
  }

  //结算按钮
  Widget goButton(context){
    int allGoodsCount =  Provider.of<CartProvide>(context).allGoodsCount;
    return Container(
      width: ScreenUtil().setWidth(160),
      padding: EdgeInsets.only(left: 10),
      child:InkWell(
        onTap: (){},
        child: Container(
          padding: EdgeInsets.all(10.0),
          alignment: Alignment.center,
          decoration: BoxDecoration(
             color: Colors.red,
             borderRadius: BorderRadius.circular(3.0)
          ),
          child: Text(
            '结算(${allGoodsCount})',
            style: TextStyle(
              color: Colors.white
            ),
          ),
        ),
      ) ,
    );
    
  
  }
}