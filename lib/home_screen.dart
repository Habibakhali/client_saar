import 'dart:async';

import 'package:client_saar/constant/component.dart';
import 'package:client_saar/zord.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'category_model.dart';


class HomeScreen extends StatefulWidget {
  static const String routeNAme='homeScreen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();

}

class _HomeScreenState extends State<HomeScreen> {
  List<String>listName=['زورد','ســـار','Belux','ريــفــا'];
  @override
 void initState() {
    // TODO: implement initState
    super.initState();
    getPreference();
  }
 void getPreference()async{
    final pref =await SharedPreferences.getInstance();
    if(pref.getString('password')==null || pref.getString('password')==''){
    WidgetsBinding.instance.addPostFrameCallback((_) =>
        showOtp(context));}
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('أعــمــاق التـميــز'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: listName.length,
              itemBuilder: (context, index) {
                return InkWell(
                    onTap: (){
                      Navigator.pushNamed(context,Zord.routeName,arguments: listName[index]);
                    },
                    child: CategoryModel(listName[index]));
              },
            ),
          ),
        ],
      ),
    );
  }
}
