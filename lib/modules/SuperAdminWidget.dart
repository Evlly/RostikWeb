import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rostik_admin_web/Auth.dart';
import 'package:rostik_admin_web/UserWidget.dart';
import 'package:rostik_admin_web/api.dart';
import 'package:rostik_admin_web/model/contract.dart';
import 'package:rostik_admin_web/model/module.dart';
import 'package:rostik_admin_web/model/service.dart';
import 'package:rostik_admin_web/model/user.dart';
import 'package:rostik_admin_web/modules/create_user.dart';

import '../model/config.dart';

class SuperAdminWidget extends StatefulWidget {
  const SuperAdminWidget({Key? key}) : super(key: key);

  @override
  _SuperAdminWidgetState createState() => _SuperAdminWidgetState();
}

class _SuperAdminWidgetState extends State<SuperAdminWidget> {
  List<User>? users;
  User? selectedUser;

  List<Config> configs = [];

  List<Module>? modules;

  int current = -1;

  bool progress = true;

  List nameModules =
      []; //["Механик", "Админ", "Клиент-менеджер", "Админ-панель"];
  String currentModule = ""; // = "Механик";

  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = [];
    for (String module in nameModules) {
      items.add(new DropdownMenuItem(value: module, child: new Text(module)));
    }
    return items;
  }

  void changedDropDownItem(String? selectedCategory) {
    setState(() {
      currentModule = selectedCategory!;
    });
  }

  void getConfigs() {
    API().getConfigOtherUser(selectedUser!.id).then((value) {
      setState(() {
        configs = value!;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    API().getUserList().then((value) {
      setState(() {
        users = value!.where((element) => element.role != 'Клиент').toList();
      });
    });
    API().getModules().then((value) {
      modules = value!;
      modules!.forEach((element) {
        nameModules.add(element.name);
      });
      currentModule = modules![0].name;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    if (users == null || modules == null) return Container();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 200,
          height: MediaQuery.of(context).size.height,
          child: ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedUser = users![index];
                    current = index;
                  });
                  getConfigs();
                },
                child: Card(
                    color: current == index ? Colors.blue : Colors.white38,
                    child: Column(
                      children: [
                        Text(users![index].last_name),
                        Text(users![index].first_name),
                        Text(users![index].middle_name)
                      ],
                    )),
              );
            },
            itemCount: users!.length,
          ),
        ),
        (selectedUser != null) ? UserWidget(user: selectedUser!) : Container(),
        (selectedUser != null)
            ? Column(children: [
                Row(
                  children: [
                    DropdownButton(
                        value: currentModule,
                        items: getDropDownMenuItems(),
                        onChanged: changedDropDownItem),
                    RawMaterialButton(
                      onPressed: () {
                        API()
                            .postConfig(selectedUser!.id, currentModule)
                            .then((value) {
                          if (value != null) {
                            getConfigs();
                          }
                        });
                      },
                      elevation: 2.0,
                      fillColor: Colors.white,
                      child: Icon(
                        Icons.add,
                        size: 25.0,
                        color: Colors.green,
                      ),
                      padding: EdgeInsets.all(5.0),
                      shape: CircleBorder(),
                    ),
                  ],
                ),
                Container(
                  width: 200,
                  height: MediaQuery.of(context).size.height,
                  child: ListView.builder(
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {},
                        child: Card(
                            child: Column(
                          children: [
                            Text(configs[index].module),
                            Switch(
                                value: configs[index].enable,
                                onChanged: (value) {
                                  setState(() {
                                    configs[index].enable = value;
                                  });
                                  API()
                                      .patchConfig(selectedUser!.id,
                                          configs[index].id, value)
                                      .then((value) {
                                    if (value == null) {
                                      setState(() {
                                        configs[index].enable =
                                            !configs[index].enable;
                                      });
                                    }
                                  });
                                }),
                            GestureDetector(
                              onTap: () {
                                API()
                                    .deleteConfig(configs[index].id)
                                    .then((value) {
                                  if (value) getConfigs();
                                });
                              },
                              child: Text(
                                "Удалить",
                                style: TextStyle(color: Colors.red),
                              ),
                            )
                          ],
                        )),
                      );
                    },
                    itemCount: configs.length,
                  ),
                )
              ])
            : Container(),
      ],
    );
  }
}
