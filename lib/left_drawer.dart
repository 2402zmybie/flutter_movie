import 'package:flutter/material.dart';

class LeftDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text('Hr'),
            accountEmail: Text('Hr@gmail.com'),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage('https://images.gitee.com/uploads/91/465191_vsdeveloper.png?1530762316'),
            ),
            decoration: BoxDecoration(
                image: DecorationImage(image: NetworkImage('http://www.liulongbin.top:3005/images/bg1.jpg'),fit: BoxFit.cover)
            ),
          ),
          ListTile(
            title: Text('用户反馈'),
            trailing: Icon(Icons.feedback),
          ),
          ListTile(
            title: Text('系统设置'),
            trailing: Icon(Icons.settings),
          ),
          ListTile(
            title: Text('我要发布'),
            trailing: Icon(Icons.send),
          ),
          Divider(),
          ListTile(
            title: Text('注销'),
            trailing: Icon(Icons.exit_to_app),
          )
        ],
      ),
    );
  }
}
