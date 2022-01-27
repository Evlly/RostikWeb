import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:rostik_admin_web/model/contract.dart';
import 'package:rostik_admin_web/model/service.dart';
import 'package:rostik_admin_web/model/user.dart';

class AdminWidget extends StatefulWidget {
  const AdminWidget({Key? key}) : super(key: key);

  @override
  _AdminWidgetState createState() => _AdminWidgetState();
}

class _AdminWidgetState extends State<AdminWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Container(
                width: (MediaQuery.of(context).size.width - 20) / 2,
                child: Wrap(children: [
                  Container(
                      margin: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(width: 0.5),
                        // color: selectedServices.contains(e.id)
                        //     ? Colors.blue
                        //     : Colors.white,
                      ),
                      width: 200,
                      height: 200,
                      child: Column(
                        children: [
                          Text('В ожидании'),
                          Text("22.12.2022 - 23.12.2022"),
                          Text("Клиент - Рылов"),
                          Text("Работник - Абрамов"),
                        ],
                      )),
                  Container(
                      margin: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(width: 0.5),
                        color: Colors.blue,
                        // color: selectedServices.contains(e.id)
                        //     ? Colors.blue
                        //     : Colors.white,
                      ),
                      width: 200,
                      height: 200,
                      child: Column(
                        children: [
                          Text('В ожидании'),
                          Text("22.12.2022 - 23.12.2022"),
                          Text("Клиент - Черипик"),
                          Text("Работник - Автомазов"),
                        ],
                      )),
                  Container(
                      margin: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(width: 0.5),
                        // color: selectedServices.contains(e.id)
                        //     ? Colors.blue
                        //     : Colors.white,
                      ),
                      width: 200,
                      height: 200,
                      child: Column(
                        children: [
                          Text('В работе'),
                          Text("22.12.2022 - 23.12.2022"),
                          Text("Клиент - Дуплов"),
                          Text("Работник - Храмушин"),
                        ],
                      )),
                ]),
              ),
              VerticalDivider(),
              Container(
                width: (MediaQuery.of(context).size.width - 60) / 2,
                child: Wrap(
                  children: [
                    Container(
                        margin: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(width: 0.5),
                          // color: selectedServices.contains(e.id)
                          //     ? Colors.blue
                          //     : Colors.white,
                        ),
                        width: 100,
                        height: 100,
                        child: Column(
                          children: [
                            Text('Механик'),
                            Text('Абрамов'),
                          ],
                        )),
                    Container(
                        margin: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(width: 0.5),
                          // color: selectedServices.contains(e.id)
                          //     ? Colors.blue
                          //     : Colors.white,
                        ),
                        width: 100,
                        height: 100,
                        child: Column(
                          children: [
                            Text('Механик'),
                            Text('Храмушин'),
                          ],
                        )),
                    Container(
                        margin: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(width: 0.5),
                          color: Colors.blue,
                          // color: selectedServices.contains(e.id)
                          //     ? Colors.blue
                          //     : Colors.white,
                        ),
                        width: 100,
                        height: 100,
                        child: Column(
                          children: [
                            Text('Механик'),
                            Text('Автомазов'),
                          ],
                        )),
                  ],
                ),
              ),
              // FractionallySizedBox(
              //   alignment: Alignment.topCenter,
              //   widthFactor: 0.5,
              //   child: Container(
              //     height: 100,
              //   ),
              // ),
              // FractionallySizedBox(
              //   alignment: Alignment.topCenter,
              //   widthFactor: 0.5,
              //   child: Container(
              //     height: 100,
              //   ),
              // ),
            ],
          ),
          MaterialButton(
            onPressed: () => null,
            child: Text('Отправить выбранный заказ'),
          )
        ],
      ),
    );
  }
}
