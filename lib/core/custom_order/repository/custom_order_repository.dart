import 'package:frutter/models/base_response.dart';
import 'package:frutter/models/custom_order/properties_value.dart';

abstract class CustomOrderRepo{
  Future <FromModel> getFromValues();
}