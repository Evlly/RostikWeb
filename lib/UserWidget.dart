import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rostik_admin_web/api.dart';
import 'package:rostik_admin_web/model/user.dart';

class UserWidget extends StatelessWidget {
  final User user;
  final bool needRole;
  final bool needBalance;

  const UserWidget(
      {Key? key,
      required this.user,
      this.needRole = false,
      this.needBalance = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(minWidth: 200),
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(user.first_name),
            Text(user.middle_name),
            Text(user.last_name),
            Text("Автомобиль ${user.car}"),
            Text(user.phone ?? ""),
            if (needRole) Text(user.role ?? "")
          ],
        ),
      ),
    );
  }
}
