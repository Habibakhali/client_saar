import 'dart:io';
import 'package:client_saar/constant/my_color.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'constant/component.dart';
import 'firebase/firebase.dart';
import 'firebase/item_model.dart';

class BottomSheetModel extends StatefulWidget {
  @override
  State<BottomSheetModel> createState() => _BottomSheetModelState();
  String arg;

  BottomSheetModel(this.arg);
}

class _BottomSheetModelState extends State<BottomSheetModel> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController controllerItem = TextEditingController();
  TextEditingController controllerPrice = TextEditingController();
  TextEditingController controllerWeight = TextEditingController();
  TextEditingController controllerStrength = TextEditingController();
  String imageUrl = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    imageUrl = '';
  }

  XFile? file;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('اضـف مـنتـج جديـد',
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
                    InkWell(
                      onTap: () async {
                        ImagePicker picker = ImagePicker();
                        file =
                            await picker.pickImage(source: ImageSource.gallery);

                        String uniqueName =
                            DateTime.now().microsecondsSinceEpoch.toString();

                        if (file != null) {
                          showLoading(context, 'تحميل...');
                          Reference reference = FirebaseStorage.instance.ref();
                          Reference referenceImage = reference.child('images');
                          Reference referenceToUploadImage =
                              referenceImage.child(uniqueName);
                          try {
                            await referenceToUploadImage
                                .putFile(File(file!.path));
                            imageUrl =
                                await referenceToUploadImage.getDownloadURL();
                            if (imageUrl != '') Navigator.pop(context);
                          } catch (error) {}
                          ;
                        }
                      },
                      child: Row(
                        children: [
                          Icon(Icons.camera_alt_outlined),
                          const SizedBox(
                            width: 10,
                          ),
                          Text('اخــتـر صــورة المنـتـج'),
                          Spacer(),
                          Icon(
                            Icons.done,
                            color: imageUrl != ''
                                ? MyColor.navyColor
                                : MyColor.whiteColor,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: controllerItem,
                      validator: (value) {
                        if (value?.trim() == '' || value == null) {
                          return "من فضلك ادخل سـعـر المنتج";
                        }
                        return null;
                      },
                      cursorColor: MyColor.navyColor,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: 'ادخــل اسم المنتج',
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide:
                              BorderSide(color: MyColor.navyColor, width: 2),
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
                      validator: (value) {
                        if (value?.trim() == '' || value == null) {
                          return "من فضلك ادخل سـعـر المنتج";
                        }
                        return null;
                      },
                      cursorColor: MyColor.navyColor,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'ادخل سعر المنتج',
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide:
                              BorderSide(color: MyColor.navyColor, width: 2),
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
                      validator: (value) {
                        if (value?.trim() == '' || value == null) {
                          return "من فضلك ادخل الـوزن";
                        }
                        return null;
                      },
                      cursorColor: MyColor.navyColor,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'ادخـل الـــوزن',
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide:
                              BorderSide(color: MyColor.navyColor, width: 2),
                        ),
                        border: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: MyColor.navyColor,
                              style: BorderStyle.solid,
                            ),
                            borderRadius: BorderRadius.circular(8)),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: controllerStrength,
                      validator: (value) {
                        if (value?.trim() == '' || value == null) {
                          return "من فضلك الــشدة";
                        }
                        return null;
                      },
                      cursorColor: MyColor.navyColor,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'ادخـل الـشـدة',
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide:
                              BorderSide(color: MyColor.navyColor, width: 2),
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
                    ElevatedButton(
                        onPressed: () {
                          print('============================??> $imageUrl');

                          if (imageUrl == "") {
                            showMessage(context, 'من فـضلك اخـتر الصـورة ⚠');
                          }
                          if (formKey.currentState!.validate() &&
                              imageUrl != '') {
                            showLoading(context, 'تحمــيل...');
                            ItemModel model = ItemModel(
                                url: imageUrl,
                                weight: controllerWeight.text,
                                price: controllerPrice.text,
                                strength: controllerStrength.text,
                                name: controllerItem.text);
                            addImageToFirebase(widget.arg, model).then((value) {
                              Navigator.pop(context);
                              Navigator.pop(context);
                              showMessage(context, 'تـم التحمـيل بنجاح 🎉');
                              imageUrl = '';
                            });
                          }
                        },
                        child: const Text(
                          "أضـــف",
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
