
import 'dart:convert';

import 'package:frutter/core/custom_order/repository/custom_order_repository.dart';
import 'package:frutter/models/base_response.dart';
import 'package:frutter/models/custom_order/properties_value.dart';

class GetSearchMapUseCase{
  GetSearchMapUseCase({required CustomOrderRepo customOrderRepo}):_customOrderRepo=customOrderRepo;

  CustomOrderRepo _customOrderRepo;

  Future<List<ValueMapping>> call() async{
    List<ValueMapping>? _valueMapping;
    final result = await _customOrderRepo.getFromValues();
    print("data:res:${result.sections!.first.name}");
    print(result.sections!.first.fields);
    _valueMapping=result.valueMapping;
    return _valueMapping!;
  }
}