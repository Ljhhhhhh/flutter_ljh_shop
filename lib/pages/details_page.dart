import 'package:flutter/material.dart';
import 'package:flutter_shop/components/details_page/details_bottom.dart';
import 'package:flutter_shop/components/details_page/details_explain.dart';
import 'package:flutter_shop/components/details_page/details_tabbar.dart';
import 'package:flutter_shop/components/details_page/details_top_area.dart';
import 'package:flutter_shop/components/details_page/details_web.dart';
import 'package:flutter_shop/model/details.dart';
import 'package:flutter_shop/provide/details_info.dart';
import 'package:provider/provider.dart';

class DetailsPage extends StatelessWidget {
  final String goodsId;
  DetailsPage(this.goodsId);

  @override
  Widget build(BuildContext context) {
    
    // Provider.of<DetailsInfoProvide>(context).getGoodsInfo(this.goodsId);
    // final DetailsModel result = Provider.of<DetailsInfoProvide>(context).goodsInfo;
    // final DetailsGoodsData detail = result.data;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            print('返回上一页');
            Navigator.pop(context);
          },
        ),
        title: Text('商品详细页'),
      ),
      body: FutureBuilder(
        future: _getBackInfo(context),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Stack(
              children: <Widget>[
                ListView(
                  children: <Widget>[
                    DetailsTopArea(),
                    DetailsExplain(),
                    DetailsTabbar(),
                    DetailsWeb()
                  ],
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: Row(
                    children: <Widget>[
                      DetailsBottom()
                    ],
                  ),
                )
              ],
            );
          } else {
            return Center(child: Text('加载中……'));
          }
        },
      ),
    );
  }

  Future _getBackInfo(BuildContext context) async {
    await Provider.of<DetailsInfoProvide>(context).getGoodsInfo(this.goodsId);
    return '完成加载';
  }
}
