import 'package:client_saar/constant/my_color.dart';
import 'package:flutter/material.dart';

import 'constant/component.dart';
import 'firebase/firebase.dart';
import 'firebase/item_model.dart';

class EditItem extends StatefulWidget {
  @override
  State<EditItem> createState() => _EditItemState();
  String category;
  String name;
  String price;
  String weight;
  String strength;
  String url;
  String id;

  EditItem(this.category, this.name, this.price, this.weight, this.strength,
      this.url, this.id);
}

class _EditItemState extends State<EditItem> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerPrice = TextEditingController();
  TextEditingController controllerWeight = TextEditingController();
  TextEditingController controllerStrength = TextEditingController();

  @override
  void initState() {
    super.initState();
    controllerName.text = widget.name;
    controllerPrice.text = widget.price;
    controllerWeight.text = widget.weight;
    controllerStrength.text = widget.strength;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('قـم بالتـعديـل',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: MyColor.navyColor,
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'IRANSans',
                  wordSpacing: 1.0,
                  height: 1.0,
                )),
            const SizedBox(
              height: 15,
            ),
            Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: controllerName,
                      validator: (value) {
                        if (value?.trim() == '' || value == null) {
                          return "من فضلك قم بالتعـديل";
                        }
                        return null;
                      },
                      cursorColor:  MyColor.navyColor,
                      decoration: InputDecoration(
                        labelText: 'عــدل الاســـم',
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(
                              color: MyColor.navyColor,
                              width: 2),
                        ),
                        border: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: MyColor.navyColor,
                              style: BorderStyle.solid,
                            ),
                            borderRadius: BorderRadius.circular(8)),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: controllerPrice,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value?.trim() == '' || value == null) {
                          return "من فضلك قم بالتعـديل";
                        }
                        return null;
                      },
                      cursorColor: MyColor.navyColor,
                      decoration: InputDecoration(
                        labelText: 'عــدل الـســعـر',
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(
                              color: MyColor.navyColor,
                              width: 2),
                        ),
                        border: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: MyColor.navyColor,
                              style: BorderStyle.solid,
                            ),
                            borderRadius: BorderRadius.circular(8)),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: controllerWeight,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value?.trim() == '' || value == null) {
                          return "من فضلك قم بالتعـديل";
                        }
                        return null;
                      },
                      cursorColor: MyColor.navyColor,
                      decoration: InputDecoration(
                        labelText: 'عــدل الـــوزن',
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(
                              color: MyColor.navyColor,
                              width: 2),
                        ),
                        border: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: MyColor.navyColor,
                              style: BorderStyle.solid,
                            ),
                            borderRadius: BorderRadius.circular(8)),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: controllerStrength,

                      validator: (value) {
                        if (value?.trim() == '' || value == null) {
                          return "عــدل الــشـدة";
                        }
                        return null;
                      },
                      cursorColor: MyColor.navyColor,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'عــدل الــشـدة',
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(
                              color: MyColor.navyColor,
                              width: 2),
                        ),
                        border: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: MyColor.navyColor,
                              style: BorderStyle.solid,
                            ),
                            borderRadius: BorderRadius.circular(8)),
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            widget.name = controllerName.text;
                            widget.price = controllerPrice.text;
                            widget.weight = controllerWeight.text;
                            widget.strength = controllerStrength.text;
                            showLoading(context, 'تحميل...',
                                isCancellable: true);
                            widget.weight = controllerWeight.text;
                            widget.price = controllerPrice.text;
                            widget.name = controllerName.text;
                            widget.strength = controllerStrength.text;
                            ItemModel i = ItemModel(url: widget.url,
                                weight: widget.weight,
                                price: widget.price,
                                strength: widget.strength,
                                name: widget.name);
                            print('=================${i.id}');
                            print('=================${widget.category}');
                            Update(widget.category, widget.id,i.name,i.price,i.weight,i.strength).then((
                                value) {
                              hideLoading(context);
                              showMessage(context, 'تم تعديل الصنف بنجاح');
                              Navigator.of(context).pop();
                              Navigator.of(context).pop();
                            });
                            print('item is added');
                          }
                        },
                        child: const Text(
                          "قم بالتعديل",
                          style: TextStyle(fontSize: 20),
                        ))
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
