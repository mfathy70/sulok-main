import 'dart:convert';

import 'package:sulok/screens/splash/model/sliders.dart';

import '../../network/api_response_model.dart';
import '../../network/api_urls.dart';
import '../../network/base_api.dart';

class SplashRepo {
  Future<List<Sliders>> getSliders() async {
    final response =
        await BaseAPI.get(ApiUrl.getSliders, {}, apiResponseModel: false);
    List<dynamic> list = response;
    return slidersFromJson(json.encode(response));
  }
}
