import 'package:flutter/material.dart';

import 'constant/my_color.dart';

class CategoryModel extends StatelessWidget {
String name;
  CategoryModel(this.name);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: MyColor.whiteColor
      ),
      child: Row(
        children: [
          Container(
            width: 3,
            height: 50,
            margin: EdgeInsets.all( 10),
            color: MyColor.redColor,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name,style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: MyColor.blueColor
              ),),
               Text('',style: TextStyle(fontSize: 1),)
            ],
          ),
        ],
      ),
    );
  }
}
