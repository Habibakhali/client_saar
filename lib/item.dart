import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constant/my_color.dart';
import 'edit_item.dart';

class Item extends StatefulWidget {
  String category;
  String id;
  String url;
  String name;
  String price;
  String weight;
  String strength;

  Item(this.category, this.id, this.url, this.name,this.price, this.weight,this.strength);
  bool isAdmin = false;
  @override
  State<Item> createState() => _ItemState();
}

class _ItemState extends State<Item> {
  void initState() {
    // TODO: implement initState
    super.initState();
    getPrefrence();
  }

  getPrefrence() async {
    var pref = await SharedPreferences.getInstance();
    print(pref.getString('password'));
    print('200321');
    if (pref.getString('password') == '200321') {
      widget.isAdmin = true;
      setState(() {
        print(widget.isAdmin);
      });
    } else
      widget.isAdmin = false;
  }

  @override
  Widget build(BuildContext context) {
    return widget.isAdmin?ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Slidable(
            startActionPane: ActionPane(
              extentRatio: 1/3,
              motion: const ScrollMotion(),
              children: [
                SlidableAction(
                  onPressed: (context) {
                    bottomSheetfn(context);
                  },
                  backgroundColor: Color(0xFF80AFE6),
                  foregroundColor: MyColor.whiteColor,
                  icon: Icons.edit,
                  label: 'تعديل',
                ),
              ],
            ),
            child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Colors.white,
                    ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            widget.name,
                            style: TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: MyColor.navyColor,
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            'الـســـعــر : ${widget.price} ريـال',
                            style: TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            'الـــــوزن : ${widget.weight} ${double.parse(widget.weight) < 10 && double.parse(widget.weight) > 0 ? "لــتـر" : double.parse(widget.weight) <= 0 ? "" : "مـلـى"}',
                            style: TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Text(
                            'الـشـدة : ${widget.strength}',
                            style: TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      child: CachedNetworkImage(
                        imageUrl: widget.url,
                        width: 145,
                        height: 190,
                        placeholder: (context, url) =>
                            Center(child: CircularProgressIndicator()),
                        errorWidget: (context, _, error) => Icon(Icons.error),
                      ),
                    ),
                  ],
                )))):Container(
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
    borderRadius: BorderRadius.all(Radius.circular(20)),
    color: Colors.white,
    ),
    child: Row(
    children: [
    Expanded(
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: [
    Text(
    widget.name,
    style: TextStyle(
    fontFamily: 'Cairo',
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.black,
    ),
    ),
    SizedBox(
    height: 15,
    ),
    Text(
    'الـســـعــر : ${widget.price} ريـال',
    style: TextStyle(
    fontFamily: 'Cairo',
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.black,
    ),
    ),
    SizedBox(
    height: 15,
    ),
    Text(
    'الـــــوزن : ${widget.weight} ${double.parse(widget.weight) < 10 && double.parse(widget.weight) > 0 ? "لــتـر" : double.parse(widget.weight) <= 0 ? "" : "مـلـى"}',
    style: TextStyle(
    fontFamily: 'Cairo',
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.black,
    ),
    ),
    SizedBox(
    height: 25,
    ),
    Text(
    'الـشـدة : ${widget.strength}',
    style: TextStyle(
    fontFamily: 'Cairo',
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.black,
    ),
    ),
    ],
    ),
    ),
    ClipRRect(
    borderRadius: BorderRadius.all(Radius.circular(20)),
    child: CachedNetworkImage(
    imageUrl: widget.url,
    width: 145,
    height: 190,
    placeholder: (context, url) =>
    Center(child: CircularProgressIndicator()),
    errorWidget: (context, _, error) => Icon(Icons.error),
    ),
    ),
    ],
    ));
  }
  bottomSheetfn(context){
    return showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor:const Color.fromRGBO(245, 239, 230, 1.0),
        context: context,
        shape:const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            )),
        builder: (context){
          return  Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: EditItem(widget.category,
                widget.name,
                widget.price,widget.weight,
                widget.strength,
                widget.url,
                widget.id),
          );});
  }
}
