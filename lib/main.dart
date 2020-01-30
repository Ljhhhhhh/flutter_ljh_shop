import 'package:flutter/material.dart';
import 'package:flutter_shop/provide/category_goods_list.dart';
import 'package:flutter_shop/provide/child_category.dart';
import 'package:flutter_shop/provide/counter.dart';
import 'package:flutter_shop/provide/currentIndex.dart';
import 'package:flutter_shop/provide/details_info.dart';
import 'package:flutter_shop/routers/application.dart';
import 'package:flutter_shop/routers/routes.dart';
import 'package:provider/provider.dart';
import './pages/index_page.dart';
import 'package:fluro/fluro.dart';

void main() {
  final counter = Counter();
  final childCategory = ChildCategory();
  final categoryGoodsListProvide = CategoryGoodsListProvide();
  final detailsInfoProvide = DetailsInfoProvide();
  final currentIndexProvide = CurrentIndexProvide();
  

  runApp(MultiProvider(
    providers: [
      Provider.value(value: 2134213),
      ChangeNotifierProvider.value(
        value: counter,
      ),
      ChangeNotifierProvider.value(
        value: childCategory,
      ),
      ChangeNotifierProvider.value(
        value: categoryGoodsListProvide,
      ),
      ChangeNotifierProvider.value(
        value: detailsInfoProvide,
      ),
      ChangeNotifierProvider.value(
        value: currentIndexProvide,
      ),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final router = Router();
    Routes.configureRoutes(router);
    Application.router = router;
  
    return Container(
      child: MaterialApp(
        title: '百姓生活+',
        onGenerateRoute: Application.router.generator,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primaryColor: Colors.pink),
        home: IndexPage(),
      ),
    );
  }
}
