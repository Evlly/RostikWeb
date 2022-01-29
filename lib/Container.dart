import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rostik_admin_web/Auth.dart';
import 'package:rostik_admin_web/modules/SuperAdminWidget.dart';
import 'package:rostik_admin_web/api.dart';
import 'package:rostik_admin_web/model/user.dart';
import 'package:rostik_admin_web/modules/MechWidget.dart';
import 'package:rostik_admin_web/modules/client_manager.dart';
import 'package:rostik_admin_web/modules/create_user.dart';
import 'package:rostik_admin_web/web_storage.dart';

class ContainerWidget extends StatefulWidget {
  const ContainerWidget({Key? key}) : super(key: key);

  @override
  _ContainerWidgetState createState() => _ContainerWidgetState();
}

class _ContainerWidgetState extends State<ContainerWidget> {
  Map<String, Widget> modules = {
    "Админ-панель": SuperAdminWidget(),
      "Механик": MechWidget(),
    "Клиент-менеджер": ClientManagerScreen(),
    //"": SuperAdminWidget(),
    //"": SuperAdminWidget(),
  };

  String title = "Автосервис Ростик: ";

  String strs = "";

  List widgets = [];

  @override
  void initState() {
    super.initState();
    API().getUserMe().then((value) {
      if (value != null) {
        title += "${value.role} ${value.last_name} ${value.first_name}";
        setState(() {});
        //Получение списка конфигов из АПИ и добавление ихи в список
        API().getConfigOtherUser(WebStorage.instance.userId).then((value) {
          value?.forEach((element) {
            if (element.enable) widgets.add(modules[element.module]);
          });
          setState(() {});
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Padding(
          padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
          child: Center(
              child: ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return Column(
                children: [
                  Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Text(
                        modules.keys.firstWhere(
                            (element) => modules[element] == widgets[index]),
                        style: TextStyle(fontSize: 20, color: Colors.blue),
                      )),
                  widgets[index],
                  Divider(
                    color: Colors.black,
                  )
                ],
              );
            },
            itemCount: widgets.length,
          ))),
    );
  }
}
