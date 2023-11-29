
import 'package:frutter/models/custom_order/invoice.dart';
import 'package:hive/hive.dart';

class FrutterCache {
  late Box<dynamic> chapterBox;
  late Box<dynamic> detailsBox;

  Future<void> init() async {
    chapterBox = await Hive.openBox('chapterListCache');
    detailsBox = await Hive.openBox('chapterDetailsCache');
  }

  // ------------------------------
  // Chapter Box Crud Operations
  // ------------------------------
  //
  //
  //
  // Add Items


  //
  //
  // Clear Chapter List Box
  Future<void> clearChapterBox() async {
    await chapterBox.clear();
  }

  Future <void> addInvoice ({required String name,required String address, required String phone, required LineItem lineItem})async{
    await clearChapterBox();

  }

  // ------------------------------
  // Details Box Crud Operations
  // ------------------------------
  //
  //
  // Add Item Detail


  //
  //
  // Fetch Chapter Detail

  //
  //
  // Fetch Chapter Sections Paginated

  //
  //
  // Check if chapter details available


  //
  //
  // Save Section Audio File In Local Storage

}