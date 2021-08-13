import 'package:flutter/material.dart';
import 'package:rpgnamegenerator/rpgnamegenerator.dart';

class Username {
  String userName = "";
  int status = 0;
  Username({required userName, required status});
}

typedef UsernameChecked = Function(BuildContext context, String username);

class UsernameListItem extends StatelessWidget {
  UsernameListItem(
      {required this.userName,
      required this.usernameApproved,
      required this.usernameRejected,
      Key? key})
      : super(key: key);

  String userName;
  UsernameChecked usernameApproved;
  UsernameChecked usernameRejected;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(userName),
      onTap: () {
        usernameApproved(context, userName);
      },
      onLongPress: () {
        print('Username rejected');
        usernameRejected(context, userName);
      },
    );
  }
}

class UsernameList extends StatefulWidget {
  const UsernameList({required this.list, Key? key}) : super(key: key);

  final List<Username> list;

  @override
  _UsernameListState createState() => _UsernameListState();
}

class _UsernameListState extends State<UsernameList> {
  int status = 0;
  final key = GlobalKey();

  final List<String> approved = [];
  final List<String> rejected = [];
  // final list = <Username>{};

  void _userNameApproved(BuildContext context, String username) {
    setState(() {
      widget.list.remove(username);
      approved.add(username);
    });
  }

  void _userNameRejected(BuildContext context, String username) {
    setState(() {
      widget.list.remove(username);
      rejected.add(username);
    });
  }

  @override
  Widget build(BuildContext context) {
    final String name;
    final int status;
    final VoidCallback changeStatus;

    return Scaffold(
        appBar: AppBar(
          title: Text('Swiper'),
        ),
        body: Center(
          child: ListView.builder(itemBuilder: (BuildContext _context, int i) {
            return UsernameListItem(
              userName: RpgNameGenerator.getName('human', 'male'),
              usernameApproved: _userNameApproved,
              usernameRejected: _userNameRejected,
            );
          }),
        ),
        drawer: Drawer(
            child: NavigationItems(
                approved: this.approved, rejected: this.rejected)));
  }
}

class NavigationItems extends StatelessWidget {
  final List<String> approved;
  final List<String> rejected;

  NavigationItems({required this.approved, required this.rejected, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final userList = context.dependOnInheritedWidgetOfExactType<Username>();
    final List<String> approved;
    final List<String> rejected;

    return ListView(
      children: [
        ListTile(title: Text('Home'), leading: Icon(Icons.home)),
        ListTile(
            title: Text('Approved'),
            leading: Icon(Icons.check),
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute<void>(builder: (BuildContext context) {
                print('no error');

                final tiles = this.approved.map((String username) {
                  return ListTile(title: Text(username));
                });

                return Scaffold(
                    appBar: AppBar(title: Text('Approved Usernames')),
                    body: ListView(children: tiles.toList()));
                // return
              }));

              //   MaterialPageRoute<void>(builder: (BuildContext context) {
              // return Widget();
              // }));
            }),
        ListTile(
          title: Text('Rejected'),
          leading: Icon(Icons.close),
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute<void>(builder: (BuildContext context) {
              final tiles = this.rejected.map((String username) {
                return ListTile(title: Text(username));
              });

              return Scaffold(
                  appBar: AppBar(title: Text('Rejected Usernames')),
                  body: ListView(
                    children: tiles.toList(),
                  ));
            }));
          },
        ),
      ],
    );
  }
}

void main() {
  runApp(MaterialApp(
      title: 'Swiper',
      theme: ThemeData(primaryColor: Colors.grey),
      home: UsernameList(list: [])));
}
