import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rostik_admin_web/Auth.dart';
import 'package:rostik_admin_web/UserWidget.dart';
import 'package:rostik_admin_web/api.dart';
import 'package:rostik_admin_web/model/contract.dart';
import 'package:rostik_admin_web/model/service.dart';
import 'package:rostik_admin_web/model/user.dart';
import 'package:rostik_admin_web/modules/create_user.dart';
import 'package:rostik_admin_web/web_storage.dart';

class MechWidget extends StatefulWidget {
  const MechWidget({Key? key}) : super(key: key);

  @override
  _MechWidgetState createState() => _MechWidgetState();
}

class _MechWidgetState extends State<MechWidget> {
  String strs = "";
  int i = 0;
  List<Service> ss = [];
  String userId = "";
  List<Contract> orders = [];

  void getContracts() {
    API().getContracts().then((value) {
      setState(() {
        orders = value!;
        orders = orders
            .where((element) => element.staff.id == WebStorage.instance.userId)
            .toList();
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getContracts();
  }

  List statuses = ["В обработке", "В работе", "Завершен"];

  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = [];
    for (String status in statuses) {
      items.add(new DropdownMenuItem(value: status, child: new Text(status)));
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 200,
          height: MediaQuery.of(context).size.height,
          child: ListView.builder(
              itemCount: orders.length,
              itemBuilder: (BuildContext context, int index) {
                String currentStatus = orders[index].status;
                return GestureDetector(
                    onTap: () {
                      setState(() {
                        ss = orders[index].services;
                        userId = orders[index].client.id;
                      });
                    },
                    child: Card(
                      color: orders[index].status == "В работе"
                          ? Colors.blue
                          : orders[index].status == "В обработке"
                              ? Colors.green
                              : Colors.black12,
                      child: Container(
                        child: Column(
                          children: [
                            Text("Клиент " + orders[index].client.first_name),
                            Text("Начинаем " + orders[index].start_date),
                            Text("Заканчиваем " + orders[index].end_date),
                            Row(children: [
                              Text("Статус "),
                              DropdownButton(
                                  value: currentStatus,
                                  items: getDropDownMenuItems(),
                                  onChanged: (String? selected) {
                                    setState(() {
                                      currentStatus = selected!;
                                      API()
                                          .patchContract(
                                              orders[index].id, currentStatus)
                                          .then((value) {
                                        setState(() {
                                          orders[index].status = value!;
                                        });
                                      });
                                    });
                                  })
                            ])
                          ],
                        ),
                      ),
                    ));
              }),
        ),
        Container(
            height: MediaQuery.of(context).size.height,
            width: 200,
            child: ListView.builder(
                itemCount: ss.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                      child: Column(
                    children: [
                      Text(
                        ss[index].name,
                        style: TextStyle(fontSize: 18),
                      )
                    ],
                  ));
                })),
        // TODO
        // UserWidget(user: user)
      ],
    );
  }
}
