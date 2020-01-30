import 'package:flutter/material.dart';
import 'package:flutter_shop/model/category.dart';

class ChildCategory with ChangeNotifier {
  List<BxMallSubDto> _childCategoryList = [];
  List<BxMallSubDto> get childCategoryList => _childCategoryList;
  int _childIndex = 0;
  int get childIndex => _childIndex;
  String _categoryId = '4';
  String get categoryId => _categoryId;
  String _subId = '';
  String get subId => _subId;
  int _page = 1;
  int get page => _page;
  String _noMoreText = '';
  String get noMoreText => _noMoreText;

  getChildCategory(List<BxMallSubDto> list, String id) {
    _page = 1;
    _noMoreText = '';
    _childIndex = 0;
    _categoryId = id;
    BxMallSubDto all = BxMallSubDto();
    all.mallSubId = '00';
    all.mallCategoryId = '00';
    all.comments= null;
    all.mallSubName = '全部';
    _childCategoryList = [all];

    _childCategoryList.addAll(list);
    notifyListeners();
  }

  changeChildIndex(index, String id) {
    _page = 1;
    _noMoreText = '';
    _childIndex = index;
    _subId = id;
    notifyListeners();
  }

  addPage() {
    _page++;
    // notifyListeners();
  }

  changeNoMore(String text) {
    _noMoreText = text;
    notifyListeners();
  }
}