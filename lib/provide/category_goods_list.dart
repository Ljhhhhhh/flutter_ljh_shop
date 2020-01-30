import 'package:flutter/material.dart';
import 'package:flutter_shop/model/categoryGoodsList.dart';

class CategoryGoodsListProvide with ChangeNotifier {
  List<CategoryListData> _goodsList = [];
  List<CategoryListData> get goodsList => _goodsList;

  getGoodsList(List<CategoryListData> list) {
    _goodsList = list;
    notifyListeners();
  }

  //上拉加载列表
  addGoodsList(List<CategoryListData> list){
    goodsList.addAll(list);
      notifyListeners();
  }
}