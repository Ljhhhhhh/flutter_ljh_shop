import 'package:flutter/material.dart';
import 'package:flutter_shop/service/service_methods.dart';
import '../model/details.dart';
import 'dart:convert';

class DetailsInfoProvide with ChangeNotifier {
  DetailsModel _goodsInfo = null;
  DetailsModel get goodsInfo => _goodsInfo;
  bool _isLeft = true;
  bool get isLeft => _isLeft;
  bool _isRight = false;
  bool get isRight => _isRight;

  //从后台获取商品信息

  getGoodsInfo(String id) async {
    var formData = {
      'goodId': id,
    };

    await request('getGoodDetailById', formData: formData).then((val) {
      var responseData = json.decode(val.toString());
      _goodsInfo = DetailsModel.fromJson(responseData);
      notifyListeners();
    });
  }

  //改变tabBar的状态
  changeLeftAndRight(String changeState) {
    if (changeState == 'left') {
      _isLeft = true;
      _isRight = false;
    } else {
      _isLeft = false;
      _isRight = true;
    }
    notifyListeners();
  }
}
