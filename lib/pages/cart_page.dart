import 'package:flutter/material.dart';
import 'package:flutter_shop/components/cart_page/cart_bottom.dart';
import 'package:flutter_shop/components/cart_page/cart_item.dart';
import 'package:flutter_shop/provide/cart.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('购物车')),
        body: FutureBuilder(
          future: _getCartInfo(context),
          builder: (context, snapshot) {
            List cartList = Provider.of<CartProvide>(context).cartList;
            if (snapshot.hasData) {
              return Stack(
                children: <Widget>[
                  ListView.builder(
                    itemCount: cartList.length,
                    itemBuilder: (context, index) {
                      return CartItem(cartList[index]);
                    },
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    child: CartBottom()
                  )
                ],
              );
            } else {
              return Text('加载中……');
            }
          },
        ));
  }

  Future<String> _getCartInfo(BuildContext context) async {
    await Provider.of<CartProvide>(context).getCartInfo();
    return 'end';
  }
}
