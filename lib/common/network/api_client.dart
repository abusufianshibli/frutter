
import 'package:dio/dio.dart';
import 'package:frutter/models/base_response.dart';
import 'package:frutter/models/custom_order/properties_value.dart';

import 'package:retrofit/retrofit.dart';

part 'api_client.g.dart';


@RestApi()
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @POST("api/login")
  Future<dynamic> login(@Body() Map<String, dynamic> map);
  @GET("https://formcreate.free.beeceptor.com/form")
  Future<BaseResponse<FromModel>> getFromData();
}
