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
  Contract? order;
  String userId = "";
  List<Contract> orders = [];
  int currentItem=-1;
  User? client;
  bool checkedValue = false;
  void getContracts() {
    API().getContracts().then((value) {
      setState(() {
        orders = value!;
        orders = orders
            .where((element) => element.staff?.id == WebStorage.instance.userId)
            .toList();
      });
    });
  }

  void getUser(){
    API().getUser(userId).then((value) {
      setState(() {
        client = value;
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

  Color getColor(String status){
    switch(status){
      case "В обработке":
          return Colors.amberAccent;
          break;
      case "В работе":
        return Colors.lightGreenAccent;
        break;
    }
    return Colors.black45;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Card(
            shape: BeveledRectangleBorder(
              borderRadius: BorderRadius.circular(6.0),
            ),
        child:
        Container(
          padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
          width: 500,
          height: MediaQuery.of(context).size.height,
          child: ListView.builder(
              itemCount: orders.length,
              itemBuilder: (BuildContext context, int index) {
                String currentStatus = orders[index].status;
                return GestureDetector(
                    onTap: () {
                      setState(() {
                        getUser();
                        currentItem = index;
                        order = orders[index];
                        ss = orders[index].services;
                        userId = orders[index].client.id;
                      });
                    },
                      child: Container(
                        color: index==currentItem ? Colors.blue: Colors.transparent,
                        padding: EdgeInsets.only(bottom: 12),
                        child:
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children:[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Клиент " + (orders[index].client.first_name ?? "")),
                            Text("Начало заказа " + orders[index].start_date),
                          ],
                        ),
                          Text(orders[index].status, style: TextStyle( color: getColor(orders[index].status),),)
                          ]),
                      ),
                    );
              }),
        )),
        Card(
          color: getColor(order?.status??""),
            shape: BeveledRectangleBorder(
              borderRadius: BorderRadius.circular(6.0),
            ),
        child:
        Container(
            padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
            height: MediaQuery.of(context).size.height,
            width: 500,
            child:
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Клиент: "+(client?.first_name??""), style: TextStyle(fontSize: 28),),
              Text("Телефон: "+(client?.phone??"")),
              Text("Автомобиль: "+(client?.car??"")),
              Text(""),
              Text("                      Услуги по заказу: ", style: TextStyle(fontSize: 24, color: Colors.blue),),
              Text(""),
            Container(
              height: 300,
              width: 500,
              child:
            ListView.builder(
                itemCount: ss.length,
                itemBuilder: (BuildContext context, int index) {
                  return  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        ss[index].name,
                        style: TextStyle(fontSize: 18),
                      ),
                      Checkbox(value: checkedValue, onChanged:(bl){
                        setState(() {
                          checkedValue = bl!;
                        });
                      })
                    ],
                  );
                })),
              Text("Сроки работы: "+(order?.start_date??"")+" - "+(order?.end_date??""), style: TextStyle(fontSize: 22)),
              Row(
                children: [
                  Text("Статус ", style: TextStyle(fontSize: 22)),
                  DropdownButton(
                    value: order?.status,
                    items: getDropDownMenuItems(),
                    onChanged: (String? selected) {
                      String currentStatus = order?.status??"";
                      setState(() {
                        currentStatus = selected!;
                        API()
                            .patchContract(
                            order?.id??"", currentStatus)
                            .then((value) {
                          setState(() {
                            order?.status = value!;
                          });
                        });
                      });
                    }
                  )
                ],
              )
            ]))),
        // TODO
        // UserWidget(user: user)
      ],
    );
  }
}
