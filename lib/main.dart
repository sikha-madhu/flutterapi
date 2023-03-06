import 'dart:convert';
// ignore: unused_import
import 'package:http_server/http_server.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List mapRespons=[];
  List listoffacts=[];

  fetchdata() async {
    http.Response response;
    response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts/1/comments'));
    
    if (response.statusCode == 200) {
      setState(() {
        mapRespons =  json.decode(response.body);
        // listoffacts = mapRespons['facts'];
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('fetched data '),
      ),
      body: Center(
        // ignore: unnecessary_null_comparison
        child: mapRespons == null
            ? Container(
              child: Text("is empty"),
            )
            : SingleChildScrollView(
              child: Column(        
                children: [
                  Text(
                    mapRespons.toString(),
                    style: const TextStyle(fontSize: 24),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics:const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.all(10),
                        child: Column(
                          children: <Widget>[
                            Image.network(listoffacts[index]['image_url']
                            ),
                            Text(
                    listoffacts[index]['title'].toString(),
                    style: const TextStyle(fontSize: 24),
                  ),
                   Text(
                    listoffacts[index]['description'].toString(),
                    style: const TextStyle(fontSize: 24),
                  ),
                        ],),
                      );
                    },
                    // ignore: unnecessary_null_comparison
                    itemCount: listoffacts==null? 0 : listoffacts.length,
                  ),
                ],
              ),
      ),
      )
    );
  }
}
