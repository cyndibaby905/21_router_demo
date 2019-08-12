import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: 'Navigation',
      //路由表
      routes:{
        "second_page":(context)=>SecondPage(),
        "third_page":(context)=>ThirdPage()
      },
      //路由异常页面
      onUnknownRoute: (RouteSettings setting) => MaterialPageRoute(builder: (context) => UnknownPage()),
      home:  FirstPage(),
    );
  }
}


class FirstPage extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() => _FirstPageState();
}


class _FirstPageState extends State<FirstPage> {
  String _msg='';
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('First Screen'),
      ),
      body: Column(children: <Widget>[
        RaisedButton(
            child: Text('基本路由'),
            onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder: (context) => SecondPage()))
        ),
        RaisedButton(
            child: Text('命名路由'),
            onPressed: ()=> Navigator.pushNamed(context,"second_page")
        ),
        RaisedButton(
            child: Text('命名路由（参数&回调）'),
            onPressed: ()=> Navigator.pushNamed(context, "third_page",arguments: "Hey").then((msg) {
              setState(() {
                _msg = msg;
              });
            }),
        ),
        Text('Message from Second screen: $_msg'),
        RaisedButton(
            child: Text('命名路由异常处理'),
            onPressed: ()=> Navigator.pushNamed(context,"unknown_page")
        )
      ],),
    );
  }
}


class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Second Screen'),
      ),
      body: RaisedButton(
          child: Text('Back to first screen'),
          onPressed: ()=> Navigator.pop(context)
      ),
    );
  }
}




class UnknownPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Unknown Screen'),
      ),
      body: RaisedButton(
          child: Text('Back'),
          onPressed: ()=> Navigator.pop(context)
      ),
    );
  }
}




class ThirdPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    String msg = ModalRoute.of(context).settings.arguments as String;

    return  Scaffold(
      appBar: AppBar(
        title: Text('Third Screen'),
      ),
      body: Column(
        children: <Widget>[
          Text('Message from first screen: $msg'),
          RaisedButton(
              child: Text('back'),
              onPressed: ()=> Navigator.pop(context,"Hi")
          )
        ],
      ),
    );
  }
}