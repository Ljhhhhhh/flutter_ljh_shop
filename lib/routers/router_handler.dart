import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop/pages/details_page.dart';

Handler detailsHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    String goodsId = params['id'].first;
    print('goodsId:${goodsId}');
    return DetailsPage(goodsId);
  }
);