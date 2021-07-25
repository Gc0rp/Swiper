import 'package:flutter/material.dart';
import 'package:rpgnamegenerator/rpgnamegenerator.dart';

class Username {
  String name = "";
  int status = 0;
  Username({required userName, required status});
}

class UsernameTile extends StatelessWidget {
  final String name;
  final int status;

  fina

  const UsernameTile({Key? key, required this.name, required this.status})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(name),
      onTap: () => {},
    );
  }
}

class UsernameList extends StatefulWidget {
  const UsernameList({Key? key}) : super(key: key);

  @override
  _UsernameListState createState() => _UsernameListState();
}

class _UsernameListState extends State<UsernameList> {
  Widget listBuilder() {
    final username = RpgNameGenerator.getName('human', 'male');
    return UsernameTile(name: username, status: 0);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context, index) {
          return listBuilder();
        },
        separatorBuilder: (context, builder) {
          return Divider();
        },
        itemCount: 100);
  }
}

void main() {
  runApp(MaterialApp(
      title: 'Swiper',
      theme: ThemeData(primaryColor: Colors.grey),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Swiper'),
        ),
        body: Center(child: UsernameList()),
        drawer: Drawer(
          child: ListView(
            children: [
              ListTile(title: Text('Home'), leading: Icon(Icons.home)),
              ListTile(
                title: Text('Approved'),
                leading: Icon(Icons.check),
              ),
              ListTile(title: Text('Rejected'), leading: Icon(Icons.close)),
            ],
          ),
        ),
      )));
}
