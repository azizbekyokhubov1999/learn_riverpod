
import 'package:flutter/material.dart';
import 'package:learn_riverpod/src/common/services/network_service.dart';
import 'package:learn_riverpod/src/data/models/product_model.dart';
import 'package:learn_riverpod/src/data/repository/app_repository.dart';
import 'package:learn_riverpod/src/feature/controllers/home_controller.dart';

class AppRepoImpl extends AppRepo{

  @override
  Future<List<Products>> getAllProduct() async{
    List<Products> listOfItems = [];
   String? result =  await NetworkService.GET(NetworkService.apiOfProducts);
   listOfItems = productsFromJson(result!);
   return listOfItems;
  }

  @override
  Future<void> deleteProduct(String productId) async{
    await NetworkService.DELETE("${NetworkService.apiOfProducts}/$productId");
  }

  @override
  Future<void> updateProduct(Products products) async{
   final updatedProduct = {
     'id': products.id,
     'name' : products.name,
     'description' : products.description,
     'price' : products.price,
   };
   await NetworkService.PUT("${NetworkService.apiOfProducts}/${products.id}", updatedProduct);
  }

  }