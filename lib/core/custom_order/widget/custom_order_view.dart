import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frutter/common/utils/theme/custom_themes.dart';
import 'package:frutter/common/utils/theme/text_theme.dart';
import 'package:frutter/common/widgets/custom_button.dart';
import 'package:frutter/common/widgets/custom_card.dart';
import 'package:frutter/common/widgets/custom_dropdown.dart';
import 'package:frutter/common/widgets/custom_text_form_filed.dart';
import 'package:frutter/core/custom_order/provider/custom_order_provider.dart';
import 'package:frutter/core/custom_order/widget/invoice_details.dart';
import 'package:provider/provider.dart';
import 'package:pdf/src/widgets/page.dart' as pdf;

import '../../../models/custom_order/invoice.dart';

class CustomOrderPageView extends StatefulWidget {
  const CustomOrderPageView({super.key});

  @override
  State<CustomOrderPageView> createState() => _CustomOrderPageViewState();
}

class _CustomOrderPageViewState extends State<CustomOrderPageView> {
  Future? _future;
  @override
  void initState() {
    // TODO: implement initState
    final customOrder =
        Provider.of<CustomOrderProvider>(context, listen: false);
    customOrder.clearListItem();
    _future = customOrder.getFromData();
    _future=customOrder.getValueMappingData();
    // processCsv();
    // loadAsset();
    _future=customOrder.readCSVAndConvertToJSON();
    super.initState();
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: Text("Warning"),
        content: SizedBox(
          height: 100,
          child: Column(
            children: [
              Text("Do you really want to lose the changes ?"),
              CustomSpacing.verticalSpace(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(width: 100,height:30,child: CustomButton(text: "Close",onPressed:(){Navigator.of(context).pop();}),),
                  CustomSpacing.horizontalSpace(space: 5),
                  SizedBox(width: 100,height:30,child: CustomButton(text: "Ok",onPressed:(){Navigator.pop(context, true);}),)

                ],
              )
            ],
          ),
        ),
      ),
    ));
  }
final _fromKey=GlobalKey<FormState>();

@override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final customOrder = Provider.of<CustomOrderProvider>(context);
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Custom Order Page"),
          centerTitle: true,
        ),
        body: FutureBuilder(
            future: _future,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SizedBox(
                    height: 200,
                    child: Center(child: CircularProgressIndicator()));
              } else {
                return CustomCard(
                  child: Center(
                      child: Form(
                        key: _fromKey,
                        child: ListView.builder(
                            itemCount: customOrder.listofField.length,
                            itemBuilder: (context, int index) {
                              var item = customOrder.listofField[index];
                              print(item.properties!.type);
                              bool isMatching=customOrder.checkSearchListItem(filedKey: item.key!);
                              if (item.properties!.type == "text") {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CustomTextFormField(
                                    hintText: item.properties!.hintText,
                                    type: CustomTextFormFieldType.outlined,
                                    labelText: item.properties!.label,
                                    value: item.properties!.defaultValue,
                                    maxLength: item.properties!.maxLength,
                                    keyboardType:item.properties!.label!.contains("Phone")?TextInputType.phone:TextInputType.text,
                                    validator: (value){
                                      if(value!.isEmpty){
                                        return "Please give requierd information";
                                      }
                                      else if(value.length==item.properties!.maxLength){
                                        return "You reach the maximum input";
                                      }
                                      return null;
                                    },
                                    activeOnUserInteraction: true,
                                    onChanged: (value){
                                      item.properties!.defaultValue=value;
                                    },
                                  ),
                                );
                              } else if (item.properties!.type == "dropDownList") {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CustomDropdown(
                                    // Initial Value
                                    value: customOrder.listItem,
                                    // Down Arrow Icon
                                    hint: item.properties!.hintText!,
                                    // Array list of items
                                    items: item.properties!.listItems!.map((value) {
                                      return DropdownMenuItem(
                                        value: value,
                                        child: Text(value.name!),
                                      );
                                    }).toList(),
                                    // After selecting the desired option,it will
                                    // change button value to selected value
                                    onChanged: (newValue) {
                                      setState(() {
                                        customOrder.setSelectedItem(listItem: newValue!);
                                        if(isMatching){
                                          customOrder.getProductDataByProductCode(productCode: newValue.value!, fieldKey: item.key!);
                                        }
                                      });
                                    },
                                  ),
                                );
                              } else if (item.properties!.type == "viewText") {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CustomTextFormField(
                                    readOnly: true,
                                    type: CustomTextFormFieldType.outlined,
                                    value: item.properties!.defaultValue.toString(),
                                    labelText: item.properties!.label,
                                  ),
                                );
                              } else if (item.properties!.type == "imageView") {
                                return CustomCard(margin:EdgeInsets.all(8), elevation: 5, child: Image.network(item.properties!.defaultValue));
                              }
                              else if (item.properties!.type == "numberText") {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CustomTextFormField(
                                    keyboardType: TextInputType.number,
                                    type: CustomTextFormFieldType.outlined,
                                    labelText:item.properties!.label,
                                    value:item.properties!.defaultValue.toString(),
                                  ),
                                );
                              }
                            }),
                      )),
                );
              }
            }),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomButton(text: "Order",onPressed: (){
            if(_fromKey.currentState!.validate()){
              if(customOrder.listItem!=null) {
                Navigator.push(context, MaterialPageRoute(builder: (context) =>
                    DetailPage(invoice: Invoice(
                        customer: "Mr X",
                        address: customOrder.listofField.first.properties!
                            .defaultValue,
                        phone: customOrder.listofField[1].properties!
                            .defaultValue,
                        items: [
                          LineItem(description: customOrder.listItem!.name!,
                              cost: 10)
                        ]
                    ))));
              }else{
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please select item")));
              }
            }

          },),
        ),
      ),
    );
  }

}
