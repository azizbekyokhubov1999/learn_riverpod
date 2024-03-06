import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

import '../../data/models/product_model.dart';

class NetworkService{

  //baseURL =https://65ace4a7adbd5aa31bdfb633.mockapi.io/products
  static const baseUrl = "65ace4a7adbd5aa31bdfb633.mockapi.io";

  // api = /product
  static const apiOfProducts = "/products";

// headers
  static Map<String, String>? headers = {
    'Content-Type' : 'application/json',
  };

// get method
  static Future<String?> GET(String api) async {
    final url = Uri.https(baseUrl, api);
    final response = await http.get(url, headers: headers);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.body;
    }
    return null;
  }

  // post method
  static Future<String?> POST(String api, Map<String, dynamic> body) async {
    Uri url = Uri.https(baseUrl, api);
    final response = await http.post(url, headers: headers, body: jsonEncode(body));
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.body;
    } else {
      // Handle any errors here
      log('Failed to add product: ${response.statusCode}');
      return null;
    }
  }


  static Future<String?> PUT(String api, Map<String, dynamic> body) async {
    final url = Uri.https(baseUrl, api);
    final response = await http.put(url, body: jsonEncode(body), headers: headers);
    if (response.statusCode == 200 || response.statusCode == 201) {
      log('Successfully updated');
      return response.body;
    } else {
      log('Failed to update product: ${response.statusCode}');
      return null;
    }
  }



  static Future<String?> DELETE(String api) async {
    final url = Uri.https(baseUrl, api);
    final response = await http.delete(url, headers: headers);
    if (response.statusCode == 200 || response.statusCode == 204) {
      log('Deleted successfully');
      return response.body;
    } else {
      log('Failed to delete product: ${response.statusCode}');
      return null;
    }
  }


  static  Future<List<Products>> readPosts() async {
    final url = Uri.https(baseUrl, apiOfProducts);
    final response = await get(url, headers: headers);
    if (response.statusCode == 200) {
      final List<dynamic> responseData = jsonDecode(response.body);
      List<Products> products = responseData.map((data) => Products.fromJson(data)).toList();
      return products;
    } else {
      throw Exception('Failed to load products');
    }
  }
}