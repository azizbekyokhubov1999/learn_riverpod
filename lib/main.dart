
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learn_riverpod/app.dart';

void main(){
  runApp(
      const ProviderScope(child: App()
      ));
  ///just for check
}