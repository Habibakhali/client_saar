
import 'package:client_saar/firebase/firebase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'bottom_sheet_model.dart';
import 'constant/my_color.dart';
import 'firebase/item_model.dart';
import 'item.dart';


class Zord extends StatefulWidget {
static const String routeName='Zord';
late var arg;
bool isAdmin=false;
  @override
  State<Zord> createState() => _ZordState();
}

class _ZordState extends State<Zord> {

String imageUrl='';

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPrefrence();
  }
  getPrefrence()async{
  var pref =await SharedPreferences.getInstance();
  print(pref.getString('password'));
  print('200321');
  if(pref.getString('password')=='200321'){
    widget.isAdmin= true;
  setState(() {
    print(widget.isAdmin);
  });}
  else
    widget.isAdmin= false;
  }
  @override
  Widget build(BuildContext context) {
     widget.arg= ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.arg),
        actions: [
          widget.isAdmin?IconButton(
            icon: const Icon(Icons.add_circle_outline),
            onPressed: () {
                  bottomSheet(context);
            }
          ):Text(''),
        ],
      ),
      body: StreamBuilder<QuerySnapshot<ItemModel>>(
        stream: getImageToFirebase(widget.arg),
        builder: (context,snapshot) {
          if(snapshot.connectionState==ConnectionState.waiting){
            return const Center(
              child: CircularProgressIndicator(),
            );}
            if(snapshot.hasError){
              return Center(
                child: Text(snapshot.error.toString()),
              );
            }
            var item=snapshot.data?.docs.map((item) => item.data()).toList()??[];
            return item.isEmpty?Center(
              child: Text('لا يوجد أي صنــف',style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: MyColor.navyColor
              ),),
            ):ListView.builder(
              itemCount: item.length,
              itemBuilder: (context,index) {
                return Container(
                    margin: EdgeInsets.all(10),
                    child: Item(widget.arg,
                        item[index].id,
                        item[index].url,
                        item[index].name,
                        item[index].price,item[index].weight,item[index].strength));
              },
            );
        },
      )
    );
  }
bottomSheet(context){
  return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      shape:const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          )),
      builder: (context){
        return  Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: BottomSheetModel(widget.arg),
        );});
}
}


