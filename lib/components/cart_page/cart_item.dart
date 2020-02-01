 import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/components/cart_page/cart_count.dart';
import 'package:flutter_shop/model/cartInfo.dart';
import 'package:flutter_shop/provide/cart.dart';
import 'package:provider/provider.dart';

 class CartItem extends StatelessWidget {
   final CartInfoMode item;
   CartItem(this.item);

   @override
   Widget build(BuildContext context) {
     return Container(
       margin: EdgeInsets.fromLTRB(5, 2, 5, 2),
       padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
       decoration: BoxDecoration(
         color: Colors.white,
         border: Border(
           bottom: BorderSide(width: 1, color: Colors.black12)
         )
       ),
       child: Row(
         children: <Widget>[
           _cartCheckBt(context, item),
           _cartImage(),
           _cartGoodsName(),
           _cartPrice(context, item)
         ],
       ),
     );
   }

   Widget _cartCheckBt(context, item) {
     return Container(
       child: Checkbox(
         value: item.isCheck,
         activeColor: Colors.pink,
         onChanged: (bool val) {
           item.isCheck = val;
           Provider.of<CartProvide>(context).changeCheckState(item);
         },
       ),
     );
   }

   Widget _cartImage() {
     return Container(
       width: ScreenUtil().setWidth(150),
       padding: EdgeInsets.all(3),
       decoration: BoxDecoration(
         border: Border.all(width: 1, color: Colors.black12)
       ),
       child: Image.network(item.images),
     );
   }

   Widget _cartGoodsName() {
     return Container(
       width: ScreenUtil().setWidth(300),
       padding: EdgeInsets.all(10),
       alignment: Alignment.topLeft,
       child: Column(
         children: <Widget>[
           Text(item.goodsName),
           CartCount(item)
         ],
       ),
     );
   }

   Widget _cartPrice(context, item) {
     return Container(
       width: ScreenUtil().setWidth(150),
       alignment: Alignment.centerRight,
       child: Column(
         children: <Widget>[
           Text('￥${item.price}'),
           Container(
             child: InkWell(
               onTap: () {
                 Provider.of<CartProvide>(context).deleteOneGoods(item.goodsId);
               },
               child: Icon(
                 Icons.delete_forever,
                 color: Colors.black26,
                 size: 30,
               ),
             ),
           )
         ],
       ),
     );
   }
 }