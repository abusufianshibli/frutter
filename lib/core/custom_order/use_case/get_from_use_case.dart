
import 'dart:convert';

import 'package:frutter/core/custom_order/repository/custom_order_repository.dart';
import 'package:frutter/models/base_response.dart';
import 'package:frutter/models/custom_order/properties_value.dart';

class GetFromUseCase{
  GetFromUseCase({required CustomOrderRepo customOrderRepo}):_customOrderRepo=customOrderRepo;

  CustomOrderRepo _customOrderRepo;

  Future<List<Field>> call() async{
    List<Field>? _fieldData;
   final result = await _customOrderRepo.getFromValues();
     print("data:res:${result.sections!.first.name}");
     print(result.sections!.first.fields);
     _fieldData=result.sections!.first.fields;
   return _fieldData!;
  }
}