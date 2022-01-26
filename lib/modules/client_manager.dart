import 'package:flutter/material.dart';
import 'package:rostik_admin_web/UserWidget.dart';
import 'package:rostik_admin_web/api.dart';
import 'package:rostik_admin_web/model/service.dart';
import 'package:rostik_admin_web/model/user.dart';

class ClientManagerScreen extends StatefulWidget {
  const ClientManagerScreen({Key? key}) : super(key: key);

  @override
  _ClientManagerScreenState createState() => _ClientManagerScreenState();
}

class _ClientManagerScreenState extends State<ClientManagerScreen> {
  List<User>? users;

  List<Service>? services;
  List<Service> selectedServices = [];
  String searchServiceType = 'Все';

  String? selectedUserId;
  String searchText = '';

  String? startDate;
  String? endDate;

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void initState() {
    API().getUserList().then((users) {
      if (mounted)
        setState(() {
          this.users = users!;
        });
    });
    API().getServices().then((services) {
      setState(() {
        this.services = services!;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (users == null || services == null) return Container();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Клиенты:', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(
          width: 200,
          child: TextField(
              decoration: InputDecoration(hintText: 'Введите фамилию'),
              onChanged: (newSearchText) {
                setState(() {
                  searchText = newSearchText;
                });
              }),
        ),
        Wrap(
          children: users!
              .where((element) {
                var search = true;
                if (searchText.isNotEmpty) {
                  search = element.last_name.contains(searchText);
                }
                return element.role == 'Клиент' && search;
              })
              .map((user) => GestureDetector(
                    onTap: () {
                      try {
                        selectUserWithId(user.id);
                      } catch (err) {}
                      // }
                    },
                    child: Container(
                      decoration: selectedUserId == user.id
                          ? BoxDecoration(border: Border.all())
                          : null,
                      child: UserWidget(user: user),
                    ),
                  ))
              .toList(),
        ),
        SizedBox(height: 50),
        Text('Услуги:', style: TextStyle(fontWeight: FontWeight.bold)),
        DropdownButton<String>(
          value: searchServiceType,
          items: getMenuItems(),
          onChanged: (newService) {
            setState(() {
              searchServiceType = newService!;
            });
          },
        ),
        Wrap(
          children: services!
              .where((element) {
                return !(searchServiceType != 'Все' &&
                    element.type != searchServiceType);
              })
              .map((e) => GestureDetector(
                    onTap: () {
                      if (selectedServices.contains(e)) {
                        selectedServices.remove(e);
                      } else {
                        selectedServices.add(e);
                      }
                      setState(() {});
                    },
                    child: Container(
                        margin: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(width: 0.5),
                          color: selectedServices.contains(e)
                              ? Colors.blue
                              : Colors.white,
                        ),
                        width: 150,
                        height: 100,
                        child: Column(
                          children: [
                            Text(e.type),
                            Text(e.name,
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Text(e.price + ' ₽'),
                          ],
                        )),
                  ))
              .toList(),
        ),
        SizedBox(
          width: 200,
          child: TextField(
              decoration: InputDecoration(hintText: 'Дата начала'),
              onChanged: (newSearchText) {
                setState(() {
                  startDate = newSearchText;
                });
              }),
        ),
        SizedBox(
          width: 200,
          child: TextField(
              decoration: InputDecoration(hintText: 'Дата окончания'),
              onChanged: (newSearchText) {
                setState(() {
                  endDate = newSearchText;
                });
              }),
        ),
        SizedBox(height: 50),
        MaterialButton(
          child: Text('Создать'),
          onPressed: postOnBackend,
        ),
      ],
    );
  }

  List<DropdownMenuItem<String>> getMenuItems() {
    var ssss = services!.map((e) => e.type).toSet().toList();
    ssss.add('Все');
    return ssss
        .map((e) => DropdownMenuItem(
              value: e,
              child: Text(e),
            ))
        .toList();
  }

  void selectUserWithId(String id) {
    selectedUserId = id;
    setState(() {});
  }

  void postOnBackend() {
    print('lskdjflksdjf');
  }
}
