import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_shop/model/category.dart';
import 'package:flutter_shop/model/categoryGoodsList.dart';
import 'package:flutter_shop/provide/category_goods_list.dart';
import 'package:flutter_shop/provide/child_category.dart';
import 'package:flutter_shop/service/service_methods.dart';
import 'dart:convert';
import 'package:provider/provider.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    // void initState() {
    //   super.initState();
    //   _getCategory();
    // }
    // _getCategory();
    return Scaffold(
      appBar: AppBar(
        title: Text('商品分类'),
      ),
      body: Container(
          child: Row(
        children: <Widget>[
          LeftCategoryNav(),
          Column(
            children: <Widget>[RightCategoryNav(), CategoryGoodsList()],
          )
        ],
      )),
    );
  }
}

class LeftCategoryNav extends StatefulWidget {
  _LeftCategoryNavState createState() => _LeftCategoryNavState();
}

class _LeftCategoryNavState extends State<LeftCategoryNav> {
  List list = [];
  var listIndex = 0;
  @override
  void initState() {
    super.initState();
    _getCategory();
    _getGoodsList();
  }

  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(180),
      decoration: BoxDecoration(
          border: Border(right: BorderSide(width: 1, color: Colors.black12))),
      child: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          return _leftInkWell(index);
        },
      ),
    );
  }

  Widget _leftInkWell(int index) {
    bool isClick = false;
    isClick = (index == listIndex) ? true : false;
    return Consumer<ChildCategory>(
      builder: (context, ChildCategory categoryList, child) => InkWell(
        onTap: () {
          setState(() {
            listIndex = index;
          });
          var childList = list[index].bxMallSubDto;
          var categoryId = list[index].mallCategoryId;
          categoryList.getChildCategory(childList, categoryId);
          _getGoodsList(categoryId: categoryId);
        },
        child: Container(
          height: ScreenUtil().setHeight(100),
          padding: EdgeInsets.only(left: 10, top: 20),
          decoration: BoxDecoration(
              color: isClick ? Colors.black12 : Colors.white,
              border:
                  Border(bottom: BorderSide(width: 1, color: Colors.black12))),
          child: Text(list[index].mallCategoryName,
              style: TextStyle(fontSize: ScreenUtil().setSp(28))),
        ),
      ),
    );
  }

  void _getCategory() async {
    await request('getCategory').then((val) {
      var data = json.decode(val.toString());
      CategoryModel category = CategoryModel.fromJson(data);
      setState(() {
        list = category.data;
      });
      final cate = list[0];
      Provider.of<ChildCategory>(context).getChildCategory(cate.bxMallSubDto, cate.mallCategoryId);
      // Provider.of<ChildCategory>(context).getChildCategory(list[listIndex].bxMallSubDto);
      // list.data.forEach((item) => print(item.mallCategoryName));
    });
  }

  void _getGoodsList({String categoryId}) async {
    print('categoryId:${categoryId}');
    var data = {
      'categoryId': categoryId == null ? '4' : categoryId, 
      'categorySubId': '', 
      'page': 1
    };
    await request('getMallGoods', formData: data).then((val) {
      var data = json.decode(val.toString());
      CategoryGoodsListModel goodsList = CategoryGoodsListModel.fromJson(data);
      Provider.of<CategoryGoodsListProvide>(context).getGoodsList(goodsList.data);
    });
  }
}

class RightCategoryNav extends StatefulWidget {
  RightCategoryNav({Key key}) : super(key: key);

  @override
  _RightCategoryNavState createState() => _RightCategoryNavState();
}

class _RightCategoryNavState extends State<RightCategoryNav> {
  @override
  Widget build(BuildContext context) {
    final list = Provider.of<ChildCategory>(context);
    return Container(
      height: ScreenUtil().setHeight(80),
      width: ScreenUtil().setWidth(570),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(bottom: BorderSide(width: 1, color: Colors.black12))),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: list.childCategoryList.length,
        itemBuilder: (context, index) {
          return _rightInkWell(list.childCategoryList[index], index);
        },
      ),
    );
  }

  Widget _rightInkWell(BxMallSubDto item, int index) {
    bool isClick = false;
    isClick = (index == Provider.of<ChildCategory>(context).childIndex) ? true : false;
    return Consumer(
      builder: (context, ChildCategory categoryList, child) => InkWell(
        onTap: () {
          categoryList.changeChildIndex(index, item.mallSubId);
          _getGoodsList(item.mallSubId);
        },
        child: Container(
          padding: EdgeInsets.fromLTRB(5, 10, 5, 20),
          child: Text(item.mallSubName,
              style: TextStyle(
                fontSize: ScreenUtil().setSp(28),
                color: isClick ? Colors.pink : Colors.black
              )
          ),
        ),
    )
    );
  }

  void _getGoodsList(String categorySubId) async {
    var data = {
      'categoryId': Provider.of<ChildCategory>(context).categoryId, 
      'categorySubId': categorySubId, 
      'page': 1
    };
    await request('getMallGoods', formData: data).then((val) {
      var data = json.decode(val.toString());
      CategoryGoodsListModel goodsList = CategoryGoodsListModel.fromJson(data);
      if (goodsList.data == null) {
        Provider.of<CategoryGoodsListProvide>(context).getGoodsList([]);
      } else {
        Provider.of<CategoryGoodsListProvide>(context).getGoodsList(goodsList.data);
      }
    });
  }
}

class CategoryGoodsList extends StatefulWidget {
  CategoryGoodsList({Key key}) : super(key: key);

  @override
  _CategoryGoodsListState createState() => _CategoryGoodsListState();
}

class _CategoryGoodsListState extends State<CategoryGoodsList> {
  var scrollController = new ScrollController();

  @override
  void initState() {
    super.initState();
    // _getGoodsList();
  }

  void _getMoreList() async {
    Provider.of<ChildCategory>(context).addPage(); 
    var data = {
      'categoryId': Provider.of<ChildCategory>(context).categoryId, 
      'categorySubId': Provider.of<ChildCategory>(context).subId, 
      'page': Provider.of<ChildCategory>(context).page
    };
    await request('getMallGoods', formData: data).then((val) {
      var data = json.decode(val.toString());
      CategoryGoodsListModel goodsList = CategoryGoodsListModel.fromJson(data);
      if (goodsList.data == null) {
        // Provider.of<CategoryGoodsListProvide>(context).addGoodsList([]);
        Fluttertoast.showToast(
          msg: "已经到底了",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
        );
        Provider.of<ChildCategory>(context).changeNoMore('没有更多了');
      } else {
        Provider.of<CategoryGoodsListProvide>(context).addGoodsList(goodsList.data);
      }
    });
  }

  Widget build(BuildContext context) {
    CategoryGoodsListProvide list = Provider.of<CategoryGoodsListProvide>(context);
    try{
      if(Provider.of<ChildCategory>(context).page==1){
        if (list.goodsList.length > 0){
          // scrollController.jumpTo(0.0);
        }
      }
    }catch(e){
      print('进入页面第一次初始化：${e}');
    }
    if (list.goodsList.length > 0) {
      return Expanded(
        child: Container(
            width: ScreenUtil().setWidth(570),
            child: EasyRefresh(
              footer: ClassicalFooter(
                bgColor: Colors.white,
                textColor: Colors.pink,
                noMoreText: Provider.of<ChildCategory>(context).noMoreText,
                infoText: '加载中',
                loadReadyText: '上拉加载'
              ),
              child: ListView.builder(
                controller: scrollController,
                itemCount: list.goodsList.length,
                itemBuilder: (context, index) {
                  return _listWidget(list.goodsList, index);
                },
              ),
              onLoad: () async {
                _getMoreList();
              },
              // onRefresh: () async {
                  
              // },
            )),
      );
    } else {
      return Center(child: Text('暂无商品'));
    }
  }

  // void _getGoodsList() async {
  //   var data = {'category': '4', 'CategorySubId': '', 'page': 1};
  //   await request('getMallGoods', formData: data).then((val) {
  //     var data = json.decode(val.toString());
  //     CategoryGoodsListModel goodsList = CategoryGoodsListModel.fromJson(data);
  //     print('商品信息————————————${goodsList.data}');
  //     setState(() {
  //       list = goodsList.data;
  //     });
  //   });
  // }

  Widget _listWidget(List newList, int index) {
    return InkWell(
        onTap: () {
          // Application.router.navigateTo(context,"/detail?id=${newList[index].goodsId}");
        },
        child: Container(
          padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                  bottom: BorderSide(width: 1.0, color: Colors.black12))),
          child: Row(
            children: <Widget>[
              _goodsImage(newList, index),
              Column(
                children: <Widget>[
                  _goodsName(newList, index),
                  _goodsPrice(newList, index)
                ],
              )
            ],
          ),
        ));
  }

  Widget _goodsImage(List newList, int index) {
    return Container(
      width: ScreenUtil().setWidth(200),
      child: Image.network(newList[index].image),
    );
  }

  //商品名称方法
  Widget _goodsName(List newList, int index) {
    return Container(
      padding: EdgeInsets.all(5.0),
      width: ScreenUtil().setWidth(370),
      child: Text(
        newList[index].goodsName,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: ScreenUtil().setSp(28)),
      ),
    );
  }

  //商品价格方法
  Widget _goodsPrice(List newList, int index) {
    return Container(
        margin: EdgeInsets.only(top: 20.0),
        width: ScreenUtil().setWidth(370),
        child: Row(children: <Widget>[
          Text(
            '价格:￥${newList[index].presentPrice}',
            style:
                TextStyle(color: Colors.pink, fontSize: ScreenUtil().setSp(30)),
          ),
          Text(
            '￥${newList[index].oriPrice}',
            style: TextStyle(
                color: Colors.black26, decoration: TextDecoration.lineThrough),
          )
        ]));
  }
}
