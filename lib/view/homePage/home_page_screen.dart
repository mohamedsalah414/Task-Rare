import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:taskriverpod/model/items_model.dart';

import '../../viewModel/Service/DateBase.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _titleEditingController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _titleEditingController.dispose();
  }
@override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Consumer(
        builder: (context,ref,child) {
          final item = ref.watch(dataBase);
        return Scaffold(
          body:  Center(
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FutureBuilder(
                        future: DB.instance.getItems(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            if (snapshot.data!.isEmpty) {
                              return Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      ConstrainedBox(
                                        constraints: const BoxConstraints(maxWidth: 500),
                                        child: LottieBuilder.asset(
                                          'assets/json/not-found.json',
                                        ),
                                      ),
                                      Text(
                                        'You have not items yet',
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context).textTheme.headline2,
                                      )
                                    ],
                                  ),
                                ),
                              );
                            } else {
                              return ListView.builder(
                                shrinkWrap: true,
                                itemCount: snapshot.data!.length,
                                itemBuilder: (context, index) {
                                  ItemsModel itemsModel =
                                      ItemsModel.fromMap(snapshot.data![index]);
                                  return Dismissible(
                                    key: UniqueKey(),
                                    direction: DismissDirection.endToStart,
                                    background: Container(
                                      padding: const EdgeInsets.all(15),
                                      color: Colors.red,
                                      child: const Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            'Delete',
                                            textAlign: TextAlign.end,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 25),
                                          )),
                                    ),
                                    confirmDismiss: (DismissDirection direction) async {
                                      return await showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          title: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: const [
                                              Icon(
                                                Icons.warning,
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                'Alert',
                                              ),
                                            ],
                                          ),
                                          content: const Text(
                                            'Are you sure to delete this item?',
                                            textAlign: TextAlign.center,
                                          ),
                                          actions: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                ElevatedButton(
                                                  onPressed: () =>
                                                      Navigator.of(context).pop(false),
                                                  child: const Text('No'),
                                                ),
                                                ElevatedButton(
                                                  onPressed: () {
                                                   item.deleteItem(itemsModel.id);
                                                    Navigator.of(context).pop(true);
                                                  },
                                                  child: const Text('Yes'),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                    onDismissed: (direction) async {
                                      Fluttertoast.showToast(
                                        msg: 'Item Removed',
                                        backgroundColor: Colors.grey,
                                      );
                                    },
                                    child: Card(
                                      child: Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: ListTile(
                                          title: Text(itemsModel.title),
                                          trailing: IconButton(
                                              onPressed: () {
                                                showDialog(context: context, builder: (context) {
                                                  return AlertDialog(
                                                    content: TextFormField(
                                                      controller: _titleEditingController,
                                                      decoration: InputDecoration(
                                                        border: OutlineInputBorder(
                                                            borderRadius: BorderRadius.circular(15)),
                                                        focusedBorder: OutlineInputBorder(
                                                            borderRadius: BorderRadius.circular(15)),
                                                        enabledBorder: OutlineInputBorder(
                                                            borderRadius: BorderRadius.circular(15)),
                                                        label: const Text('Item'),
                                                        filled: true,
                                                        fillColor: Colors.white,
                                                      ),
                                                    ),
                                                    actions: [
                                                      ElevatedButton(
                                                          onPressed: () {
                                                            var itemEdit =
                                                            ItemsModel(title: _titleEditingController.text);
                                                           item.updateItem(itemsModel.id,itemEdit,).then((value) => Navigator.of(context).pop());
                                                          },
                                                          child: const Text('Edit item'))
                                                    ],
                                                  );
                                                },);
                                              },
                                              icon: const Icon(Icons.edit)),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            }
                          }
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        })),
              ),

          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: TextFormField(
                      controller: _titleController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)),
                        label: const Text('Item'),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                    actions: [
                      ElevatedButton(
                          onPressed: () {
                            var itemExist =
                                ItemsModel(title: _titleController.text);
                            item.insertItem(itemExist).then((value) => Navigator.of(context).pop());
                          },
                          child: const Text('Add item'))
                    ],
                  );
                },
              );
            },
            child: const Icon(Icons.add),
          ),
        );
      }
    );
  }
}
