import 'dart:convert';

import 'package:frutter/data/demo/json_data.dart';
import 'package:frutter/models/base_response.dart';
import 'package:frutter/models/custom_order/properties_value.dart';

import '../../common/network/api_client.dart';
import '../../common/service/shared_pref.dart';
import '../../core/custom_order/repository/custom_order_repository.dart';

class CustomOrderRepoImpl implements CustomOrderRepo{
  CustomOrderRepoImpl({
    required RestClient client,
    required SharePref sharePref,
  }) : _client = client,
        _sharePref = sharePref;

  final RestClient _client;
  final SharePref _sharePref;

  @override
  Future<FromModel> getFromValues()async {
   return await FromModel.fromJson(jsonDecode(fromData));
  }
}