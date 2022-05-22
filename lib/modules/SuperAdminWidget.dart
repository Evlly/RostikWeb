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
import 'package:usb_device/usb_device.dart';

import '../model/config.dart';

class SuperAdminWidget extends StatefulWidget {
  const SuperAdminWidget({Key? key}) : super(key: key);

  @override
  _SuperAdminWidgetState createState() => _SuperAdminWidgetState();
}

class _SuperAdminWidgetState extends State<SuperAdminWidget> {
  List<User>? users;
  User? selectedUser;
  final UsbDevice usbDevice = UsbDevice();

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

  void checkUsb() async {
    var pairedDevices = await usbDevice.pairedDevices; // get paired devices
    var pairedDevice = await usbDevice.requestDevices([DeviceFilter(vendorId : 0x00, productId: 0x00)]); // par a device
    List<USBConfiguration> availableConfigurations = await usbDevice.getAvailableConfigurations(pairedDevice); // get device's configurations
    USBDeviceInfo deviceInfo = await usbDevice.getPairedDeviceInfo(pairedDevice); // get device's info
    await usbDevice.open(pairedDevice); // start session
    await usbDevice.close(pairedDevice); // close session
  }

  @override
  void initState() {
    super.initState();
    //checkUsb();
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
        Card(
        child:
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
          children:[
            Text("Сотрудники", style: TextStyle(color: Colors.blue, fontSize: 28),),
        Container(
          padding: EdgeInsets.only(top: 10, left: 50),
          width: 500,
          height: 500,
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
                child: Text(users![index].last_name+" "+users![index].first_name.characters.first+". " +users![index].middle_name.characters.first+".",
                style: TextStyle(fontSize: 24, color: current==index?Colors.blue:Colors.black),
                ),
              );
            },
            itemCount: users!.length,
          ),
        ),
          Padding(padding: EdgeInsets.only(bottom: 20),
              child:
          Text("Для назначения прав персоналу, нажмите на сотрудника"))
          ]

            )
        ),
        Container(
            padding: EdgeInsets.only( left: 50),
          width: 500,
    height: 570,
    child:
        Card(
          child:
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text((selectedUser?.last_name??"") + " "+(selectedUser?.first_name??"")+" "+(selectedUser?.middle_name??"") , style: TextStyle(fontSize: 22),),
                  Text(selectedUser?.role??"", style: TextStyle(fontSize: 18),),
                  Text(selectedUser?.email??"", style: TextStyle(fontSize: 18),),
                  Text(selectedUser?.phone??"", style: TextStyle(fontSize: 18),),
                  Text("\nДоступные модули: ", style: TextStyle(fontSize: 24, color: Colors.blue),),
                  Container(
                    padding: EdgeInsets.only(left: 50, top: 20),
                    width: 200,
                    height: 300,
                    child:
                  ListView.builder(
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {},
                        child: Card(
                          color: configs[index].enable? Colors.greenAccent : Colors.black12 ,
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
                  )),
                  Text("Добавить модуль: ", style: TextStyle(fontSize: 18, color: Colors.blue),),
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
              )
            ],
          )
        )
        )

      ],
    );
  }
}
/*
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


 */