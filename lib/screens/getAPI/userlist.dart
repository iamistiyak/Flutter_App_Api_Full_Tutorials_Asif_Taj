import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../models/userModel.dart';

class UserList extends StatefulWidget {
  const UserList({Key? key}) : super(key: key);

  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {

  List<UserModel> userList = [] ;

  Future<List<UserModel>> getUserApi ()async{
    final response =await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    // var data = jsonDecode(response.body.toString());
    var jsonString = response.body;
    var jsonMap = json.decode(jsonString);
    print(jsonString.runtimeType);
    print(jsonMap.runtimeType);
    if(response.statusCode == 200){
      for(Map i in jsonMap){
        print(i['name']);
        userList.add(UserModel.fromJson(i));
      }
      return userList;
    }else {
      return userList;
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
            child: FutureBuilder <List<UserModel>> (
              future: getUserApi () ,
              builder: (context , snapshot){

                if(!snapshot.hasData){
                  return CircularProgressIndicator();
                }else{
                  return ListView.builder(
                      itemCount: userList.length,
                      itemBuilder: (context , index){
                        return Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                ReusbaleRow(title: 'Name', value: snapshot.data![index].name.toString()),
                                ReusbaleRow(title: 'username', value: snapshot.data![index].username.toString()),
                                ReusbaleRow(title: 'email', value: snapshot.data![index].email.toString()),
                                ReusbaleRow(title: 'city', value: snapshot.data![index].address!.city.toString()),
                                ReusbaleRow(title: 'Address',
                                    value: snapshot.data![index].address!.geo!.lat.toString()

                                )
                              ],
                            ),
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