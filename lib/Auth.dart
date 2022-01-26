import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rostik_admin_web/Container.dart';
import 'package:rostik_admin_web/api.dart';
import 'package:rostik_admin_web/web_storage.dart';

class AuthWidget extends StatefulWidget {
  const AuthWidget({Key? key}) : super(key: key);

  @override
  _AuthWidgetState createState() => _AuthWidgetState();
}


class _AuthWidgetState extends State<AuthWidget> {
  String _email = '';
  String _password = '';

  @override
  void initState(){
    super.initState();
    WebStorage.instance.userId = "";
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
              Text("Вход в систему",
              style: TextStyle(
                fontSize: 18,

              ),),
              const Padding(padding: EdgeInsets.only(bottom: 16)),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Логин',
                  border: OutlineInputBorder(),
                ),
                onChanged: (newString) {
                  _email = newString;
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
                    child: Text('Войти', style: TextStyle(fontSize: 18, color: Colors.white)),
                  ),
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
                onPressed: () => {
                  API().postUserLogin(_email, _password).then((value){
                    if (value != {})
                      Navigator.push(context, PageRouteBuilder(
                        opaque: false,
                        pageBuilder: (_, __, ___) => ContainerWidget(),
                      ));
                  })
                },
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