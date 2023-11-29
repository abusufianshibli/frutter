import 'dart:convert';

import 'package:csv/csv.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:frutter/core/custom_order/use_case/get_from_use_case.dart';
import 'package:frutter/core/custom_order/use_case/get_search_map_use_case.dart';

import '../../../di/di_service.dart';
import '../../../models/custom_order/product_model.dart';
import '../../../models/custom_order/properties_value.dart';

class CustomOrderProvider extends ChangeNotifier{

  final _getFrom = di.get<GetFromUseCase>();
  final _getValueMapping = di.get<GetSearchMapUseCase>();
  List<Field> _listofField=[];
  List<ProductModel> _productList=[];
  List<ValueMapping> _valueMapping=[];

  ListItem? _listItem;

  ListItem? get listItem=>_listItem;

  void setSelectedItem( {required ListItem listItem}){
    _listItem=listItem;
    notifyListeners();
  }

  void clearListItem(){
    _listItem=null;
  }


  List<Field> get listofField=>_listofField;

  List<ProductModel> get productList=>_productList;

  List<ValueMapping> get valueMapping=>_valueMapping;

  Future getFromData()async{
    final result= await _getFrom.call();
    _listofField=result;
  }

  Future getValueMappingData()async{
    final result= await _getValueMapping.call();
    _valueMapping=result;
  }
  Future<dynamic> readCSVAndConvertToJSON() async {
    // Read the CSV file from the assets folder
    String csvString = await rootBundle.loadString("assets/fruit_prices.csv");

    // Convert the CSV string to a List of Lists
    List<List<dynamic>> csvTable = CsvToListConverter().convert(csvString);

    // Get the headers (assuming the first row in the CSV contains headers)
    List<String> headers = List<String>.from(csvTable[0]);

    // Create a List to store the JSON objects
    List<Map<String, dynamic>> jsonData = [];

    // Iterate over the rows (skipping the first row since it contains headers)
    for (int i = 1; i < csvTable.length; i++) {
      // Create a Map to store the current row's data
      Map<String, dynamic> row = {};

      // Iterate over the columns and populate the Map
      for (int j = 0; j < headers.length; j++) {
        row[headers[j]] = csvTable[i][j];
      }

      // Add the row to the List
      jsonData.add(row);

    }
    _productList= jsonData.map((e) => ProductModel.fromJson(e)).toList();
    print(jsonEncode(productList));
    return jsonData;
  }

  void getProductDataByProductCode( {required int productCode,required String fieldKey}){
    print("Prodict code:$productCode, Field Key:$fieldKey");
    if(_productList.isNotEmpty&& _listofField.isNotEmpty && _valueMapping.isNotEmpty){
      if(_productList.any((element) => element.productCode==productCode)){
      ProductModel productModel=  _productList.firstWhere((element) => element.productCode==productCode);
      if(_valueMapping.any((valueElement) => valueElement.searchList!.any((searchElement) => searchElement.fieldKey==fieldKey))){
        ValueMapping valueMapping=_valueMapping.firstWhere((element) => element.searchList!.any((searchElement) => searchElement.fieldKey==fieldKey));
       if(valueMapping.displayList!.isNotEmpty){
         for(int i =0;i<valueMapping.displayList!.length;i++){
           DisplayListElement displayListElement=valueMapping.displayList![i];
           if(_listofField.any((element) => element.key==displayListElement.fieldKey)){
             Map<String, dynamic> datas = productModel.toJson();
             if(datas.containsKey(displayListElement.dataColumn)){
               Field field=_listofField.firstWhere((element) => element.key==displayListElement.fieldKey);
               // int index = _listofField.indexOf(field);
               field.properties!.defaultValue=datas[displayListElement.dataColumn];
               field.properties!.price=productModel.retailPrice!;
               // _listofField[index]=field;
             }
           }
         }
       }
      }
      }
    }
    notifyListeners();
  }

bool checkSearchListItem({required String filedKey}){
    for(ValueMapping valueMapping in _valueMapping){
      if(   valueMapping.searchList!.any((element) => element.fieldKey==filedKey)){
        return true;
      }
    }
    return false;
}
}