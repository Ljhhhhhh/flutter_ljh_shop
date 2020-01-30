import 'package:dio/dio.dart';
import 'dart:async';
import '../config/service_url.dart';

Future request(url, {formData}) async {
  try {
    //print('开始获取数据...............');
    Response response;
    Dio dio = new Dio();
    dio.options.contentType = "application/x-www-form-urlencoded";
    if (formData == null) {
      response = await dio.post(servicePath[url]);
    } else {
      response = await dio.post(servicePath[url], data: formData);
    }
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('后端接口出现异常，请检测代码和服务器情况.........');
    }
  } catch (e) {
    return print('ERROR:======>${e}');
  }
}

Future getHomePageContent() async {
  try {
    print('开始获取首页数据');
    Response response;
    Dio dio = new Dio();
    dio.options.contentType = "application/x-www-form-urlencoded;charset=UTF-8";
    var formData = {'lon':'115.02932','lat':'35.76189'};
    response = await dio.post(servicePath['homePageContext'],data:formData);
    if(response.statusCode==200){
      return response.data;
    }else{
      throw Exception('后端接口出现异常，请检测代码和服务器情况.........');
    }
  } catch (e) {
    return print('ERROR:${e}');
  }
}

Future getHomePageBeloContent() async {
  try {
    print('开始获取火爆专区数据');
    Response response;
    Dio dio = new Dio();
    dio.options.contentType = "application/x-www-form-urlencoded;charset=UTF-8";
    int page = 1;
    response = await dio.post(servicePath['homePageBelowConten'],data:page);
    if(response.statusCode==200){
      return response.data;
    }else{
      throw Exception('后端接口出现异常，请检测代码和服务器情况.........');
    }
  } catch (e) {
    return print('ERROR:${e}');
  }
}