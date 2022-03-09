import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserListWithoutModel extends StatefulWidget {
  const UserListWithoutModel({Key? key}) : super(key: key);

  @override
  _UserListWithoutModelState createState() => _UserListWithoutModelState();
}

class _UserListWithoutModelState extends State<UserListWithoutModel> {

  var data ;
  var jsonMap;
  Future<void> getUserApi ()async{
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));

    if(response.statusCode == 200){
      // data = jsonDecode(response.body.toString());
      var jsonString = response.body;
      jsonMap  = json.decode(jsonString);

    }else {

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Api Course'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getUserApi (),
              builder: (context , snapshot){

                if(snapshot.connectionState == ConnectionState.waiting){
                  return Text('Loading');
                }else {
                  return ListView.builder(
                      itemCount: jsonMap.length,
                      itemBuilder: (context, index){
                        return Card(
                          child: Column(
                            children: [
                              ReusbaleRow(title: 'name', value: jsonMap[index]['name'].toString(),),
                              ReusbaleRow(title: 'Username', value: jsonMap[index]['username'].toString(),),
                              ReusbaleRow(title: 'address', value: jsonMap[index]['address']['street'].toString(),),
                              ReusbaleRow(title: 'Lat', value: jsonMap[index]['address']['geo']['lat'].toString(),),
                              ReusbaleRow(title: 'Lat', value: jsonMap[index]['address']['geo']['lng'].toString(),),
                            ],
                          ),
                        );
                      });
                }

              },
            ),
          )
        ],
      ),
    );
  }
}

class ReusbaleRow extends StatelessWidget {
  String title , value ;
  ReusbaleRow({Key? key , required this.title , required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(value ),

        ],
      ),
    );
  }
}