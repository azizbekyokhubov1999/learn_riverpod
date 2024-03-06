import 'package:flutter/cupertino.dart';
import 'package:learn_riverpod/src/data/models/product_model.dart';

abstract class AppRepo{

// home controller functions
  Future<void>getAllProduct();

  Future<void> updateProduct(Products products);

  Future<void> deleteProduct(String productId);


}