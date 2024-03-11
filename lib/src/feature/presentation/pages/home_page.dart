import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learn_riverpod/src/feature/controllers/home_controller.dart';
import 'package:learn_riverpod/src/feature/presentation/pages/product_form_page.dart';

import '../../../data/models/product_model.dart';


class HomePage extends ConsumerStatefulWidget{
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}
class _HomePageState extends ConsumerState<HomePage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(
        builder: (context, ref, _) {
          ref.watch(homeCont);
          return Container(
            margin: const EdgeInsets.only(left: 20, right: 20, top: 30),
            child: Column(
              children: [
                Expanded(
                  child: ref.read(homeCont.notifier).isLoading? ListView.builder(
                        itemCount: ref.read(homeCont.notifier).items.length,
                        itemBuilder: (_, index) {
                          return Container(
                            margin: const EdgeInsets.only(bottom: 20),
                            child: Material(
                              elevation: 5,
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                padding: const EdgeInsets.all(20),
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  color: Colors.deepPurple,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text("Name: ${ref.read(homeCont.notifier).items[index].name}",
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const Spacer(),
                                        GestureDetector(
                                          onTap: () {
                                            ref.read(homeCont.notifier).updateNameController.text = ref.read(homeCont.notifier).items[index].name;
                                            ref.read(homeCont.notifier).updateDescController.text = ref.read(homeCont.notifier).items[index].description;
                                            ref.read(homeCont.notifier).updatePriceController.text = ref.read(homeCont.notifier).items[index].price;
                                            editUserInfo(context, ref.read(homeCont.notifier).items[index].id);
                                          },
                                          child: const Icon(Icons.edit,
                                            color: Colors.yellow,
                                          ),
                                        ),
                                        const SizedBox(width: 5),
                                        GestureDetector(
                                          onTap: () async {
                                            await ref.read(homeCont).deletePost(ref.read(homeCont.notifier).items[index].id.toString());
                                          },
                                          child: const Icon(Icons.delete,
                                            color: Colors.yellow,
                                          ),
                                        ),
                                        const SizedBox(width: 5),
                                        // GestureDetector(
                                        //   onTap: () async {
                                        //     FirebaseCrashlytics.instance.crash();
                                        //   },
                                        //   child: const Icon(Icons.error,
                                        //     color: Colors.yellow,
                                        //   ),
                                        // ),

                                      ],
                                    ),
                                    Text("Description:  ${ref.read(homeCont.notifier).items[index].description}",
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text("Price: ${ref.read(homeCont.notifier).items[index].price}",
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ) : const Center(
                        child: CircularProgressIndicator(),
                      )
                ),
              ],
            ),
          );
        }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => ProductForm()));
        },
        backgroundColor: const Color.fromRGBO(161, 66, 245, 1),
        child: const Icon(Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

Future<void> editUserInfo(BuildContext context, String? id) async{
  await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      content: Container(
        child: Column(
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(Icons.cancel),
                ),
                const SizedBox(width: 20),
                const Text(
                  'Update Product Info',
                  style: TextStyle(
                    color: Color.fromRGBO(99, 7, 181, 1),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'Name:',
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Roboto',
                  ),
                ),
                const SizedBox(height: 5),
                Container(
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(158, 118, 194, 1),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 6,
                        offset: Offset(0, 2),
                      )
                    ],
                  ),
                  height: 40,
                  child: TextField(
                    controller: ref.read(homeCont.notifier).updateNameController,
                    keyboardType: TextInputType.text,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only( left: 14),
                      hintText: 'name',
                      hintStyle: TextStyle(
                        color: Color.fromRGBO(99, 7, 181, 1),
                      ),
                    ),
                  ),
                )
              ],
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'Description',
                  style: TextStyle(
                      color: Colors.black87,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Roboto'
                  ),
                ),
                const SizedBox(height: 5),
                Container(
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                      color: const Color.fromRGBO(158, 118, 194, 1),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.grey,
                            blurRadius: 6,
                            offset: Offset(0, 2)
                        )
                      ]
                  ),
                  height: 40,
                  child: TextField(
                    controller: ref.read(homeCont.notifier).updateDescController,
                    keyboardType: TextInputType.text,
                    style: const TextStyle(
                        color: Colors.white
                    ),
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(top: 5, left: 14),
                        hintText: 'description',
                        hintStyle: TextStyle(
                            color: Color.fromRGBO(99, 7, 181, 1)
                        )
                    ),
                  ),

                )
              ],
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'Price: ',
                  style: TextStyle(
                      color: Colors.black87,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Roboto'
                  ),
                ),
                const SizedBox(height: 5),
                Container(
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                      color: const Color.fromRGBO(158, 118, 194, 1),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.grey,
                            blurRadius: 6,
                            offset: Offset(0, 2)
                        )
                      ]
                  ),
                  height: 40,
                  child: TextField(
                    controller: ref.read(homeCont.notifier).updatePriceController,
                    keyboardType: TextInputType.text,
                    style: const TextStyle(
                        color: Colors.white
                    ),
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(top: 5, left: 14),
                        hintText: 'price',
                        hintStyle: TextStyle(
                            color: Color.fromRGBO(99, 7, 181, 1)
                        )
                    ),
                  ),
                )
              ],
            ),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 25),
              child: MaterialButton(
                onPressed: () async {
                  Products products = Products(
                      id: id,
                      name:  ref.read(homeCont.notifier).updateNameController.text.trim(),
                      description: ref.read(homeCont.notifier).updateDescController.text.trim(),
                      price: ref.read(homeCont.notifier).updatePriceController.text.trim()
                  );
                  await ref.read(homeCont).updatePost(products).then((value) {
                    Navigator.pop(context);
                  });
                },
                padding: const EdgeInsets.all(10),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)
                ),
                color: const Color.fromRGBO(99, 7, 181, 1),
                child: const Text('Update',
                  style: TextStyle(color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
}






