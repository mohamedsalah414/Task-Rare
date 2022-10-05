import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../viewModel/Service/DateBase.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FutureBuilder(
                future: DB.instance.getItems(),
                builder: (context, snapshot) {
                  if (snapshot.data!.isEmpty) {
                    return Center(
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'You have not favorited or bookmarked any Qurans Ayah',
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                      ),
                    );
                  }
                  if (snapshot.hasData) {
                    if (snapshot.data!.isEmpty) {
                      return SizedBox();
                    } else {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return Dismissible(
                            key: UniqueKey(),
                            direction: DismissDirection.endToStart,
                            background: Container(
                              padding: EdgeInsets.all(15),
                              color: Colors.red,
                              child: Align(
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
                                    'Are you sure to delete this bookmark ?',
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
                                          //return false when click on "NO"
                                          child: const Text('No'),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            Navigator.of(context).pop(true);
                                          },
                                          //return true when click on "Yes"
                                          child: const Text('Yes'),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                            onDismissed: (direction) async {
                              // Remove the item from the data source.
                              // print('employee Id is $employeeId');
                              // await EmployeeHelper.removeEmployee(context, employeeId);
                              // DB.instance
                              //     .deleteBookmarkAyaRaw(bookmarkAyahModel.text);
                              setState(() {
                                // employees = EmployeeHelper.getemployees(beautycenterId);
                              });

                              // Then show a snackbar.
                              Fluttertoast.showToast(
                                msg: 'Removed from bookmarks ',
                                backgroundColor: Colors.grey,
                              );
                            },
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: ListTile(
                                  title: Text(index.toString()),
                                  trailing: Icon(Icons.edit),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }
                  }
                  return Center(
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
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
                    label: Text('Item'),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
                actions: [
                  ElevatedButton(onPressed: () {}, child: Text('Add item'))
                ],
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
