
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/services/network_service.dart';
import '../../data/models/product_model.dart';

var productFormCont = ChangeNotifierProvider.autoDispose<ProductFormController>((ref) => ProductFormController());

class ProductFormController extends ChangeNotifier{

  TextEditingController nameController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  List<Products> items = [];
  bool isLoading = false;

  Future<void> create() async {
    Products product = Products(
      name: nameController.text.trim(),
      description: descController.text.trim(),
      price: priceController.text.trim(),
    );
    final response = await NetworkService.POST(NetworkService.apiOfProducts, product.toJson());
    if (response != null) {
      nameController.clear();
      descController.clear();
      priceController.clear();
      log("Successfully posted");
    } else {
      log("Failed to add product");
    }
  }

  Future<void> readPosts() async{
    items = await NetworkService.readPosts();
    notifyListeners();
  }

  ProductFormController(){
    readPosts().then((value) {
      isLoading = true;
      notifyListeners();
    });
  }
}