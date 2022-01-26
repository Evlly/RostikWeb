import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rostik_admin_web/model/user.dart';

class CreateUserWidget extends StatefulWidget {
  final bool client;
  const CreateUserWidget({Key? key, required this.client}) : super(key: key);

  @override
  _CreateUserWidgetState createState() => _CreateUserWidgetState();
}

class _CreateUserWidgetState extends State<CreateUserWidget> {
  String _firstName = '';
  String _secondName = '';
  String _thirdName = '';
  String _category = '';
  String _auto = '';
  String _login = '';
  String _password = '';

  List _categories = ["Администратор", "Механик", "Клиент-менеджер"];
  String _currentCategory = "Администратор";

  @override
  void initState() {
    _currentCategory = getDropDownMenuItems()[0].value!;
    super.initState();
  }

  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = [];
    for (String category in _categories) {
      items.add(
          new DropdownMenuItem(value: category, child: new Text(category)));
    }
    return items;
  }

  void changedDropDownItem(String? selectedCategory) {
    setState(() {
      _currentCategory = selectedCategory!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 400,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                widget.client ? "Добавление клиента" : "Добавление сотрудника",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              const Padding(padding: EdgeInsets.only(bottom: 16)),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Фамилия',
                  border: OutlineInputBorder(),
                ),
                onChanged: (newString) {
                  _login = newString;
                },
              ),
              const Padding(padding: EdgeInsets.only(bottom: 16)),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Имя',
                  border: OutlineInputBorder(),
                ),
                onChanged: (newString) {
                  _login = newString;
                },
              ),
              const Padding(padding: EdgeInsets.only(bottom: 16)),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Отчество',
                  border: OutlineInputBorder(),
                ),
                onChanged: (newString) {
                  _login = newString;
                },
              ),
              const Padding(padding: EdgeInsets.only(bottom: 16)),
              widget.client
                  ? TextField(
                      decoration: const InputDecoration(
                        labelText: 'Автомобиль',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (newString) {
                        _login = newString;
                      },
                    )
                  : DropdownButton(
                      value: _currentCategory,
                      items: getDropDownMenuItems(),
                      onChanged: changedDropDownItem),
              const Padding(padding: EdgeInsets.only(bottom: 16)),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Логин',
                  border: OutlineInputBorder(),
                ),
                onChanged: (newString) {
                  _login = newString;
                },
              ),
              const Padding(padding: EdgeInsets.only(bottom: 16)),
              TextField(
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Пароль',
                  border: OutlineInputBorder(),
                ),
                onChanged: (newString) {
                  _password = newString;
                },
              ),
              const Padding(padding: EdgeInsets.only(bottom: 16)),
              MaterialButton(
                child: Container(
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Создать',
                        style: TextStyle(fontSize: 18, color: Colors.white)),
                  ),
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
                onPressed: () => null,
              ),
            ],
          ),
        ),
      ),
    );
  }

/*void _auth(BuildContext context) async {
    final user = await HandlerNetworkManager.postAndSwallowAndParse(
      '/auth/signin',
          (json) => User.fromJson(json),
      context,
      jsonMap: {
        "email": _email,
        "password": _password,
      },
    );

    if (user == null) return;
    context.read<UserProvider>().setUser(user);
  }*/
}
