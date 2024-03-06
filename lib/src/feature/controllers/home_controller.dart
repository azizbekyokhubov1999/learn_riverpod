import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learn_riverpod/src/data/repository/app_repository_implementation.dart';

import '../../data/models/product_model.dart';

var homeCont = ChangeNotifierProvider.autoDispose<HomeController>((ref) => HomeController());

class HomeController extends ChangeNotifier{

   TextEditingController updateNameController = TextEditingController();
  TextEditingController updateDescController = TextEditingController();
  TextEditingController updatePriceController = TextEditingController();

  bool isLoading = false;
  List<Products> items = [];

  AppRepoImpl appRepoImpl = AppRepoImpl();

  Future<void> getAllPosts() async{
    isLoading = false;
    items = await appRepoImpl.getAllProduct();
    isLoading = true;
    notifyListeners();
  }

  Future<void> updatePost(Products products) async {
    await appRepoImpl.updateProduct(products);
    await getAllPosts();
  }

  Future<void> deletePost(String productId)async{
    await appRepoImpl.deleteProduct(productId);
    await getAllPosts();
  }

  HomeController(){
    getAllPosts();
  }



}