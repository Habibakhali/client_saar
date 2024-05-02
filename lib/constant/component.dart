import 'package:client_saar/constant/my_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

void showLoading(BuildContext context, String message,
    {bool isCancellable = false}) {
  showDialog(
      context: context,
      barrierDismissible: isCancellable,
      builder: (context) {
        return WillPopScope( // تضمين WillPopScope لمنع الإغلاق عند الضغط على زر الرجوع
            onWillPop: () async {
          return false; // منع الإغلاق إذا كان isCancellable يساوي false
        },
        child: AlertDialog(
          title: Row(
            children: [const CircularProgressIndicator(),
              SizedBox(
                width: 5,
              ),Text(message),
            ],
          ),)
        );
      });
}
Widget myTextField( tf1,context,void fn(value)){
  return Container(
    margin: EdgeInsets.only(left: 1,right: 1),
    child: TextFormField(
      controller: tf1,
      onChanged: fn,
      style: Theme.of(context).textTheme.headline6,
      autofocus: true,
      showCursor: false,
      keyboardType: TextInputType.number,
      maxLength: 1,
      textAlign: TextAlign.center,
      inputFormatters: [
        LengthLimitingTextInputFormatter(1),
        FilteringTextInputFormatter.digitsOnly,
      ],
      decoration: InputDecoration(
        counter: Offstage(),
        enabledBorder: OutlineInputBorder(
          borderSide:
          BorderSide(width: 2, color: Colors.black12),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide:
          BorderSide(width: 2, color:MyColor.navyColor),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    ),
  );
}
void showOtp(context){
  TextEditingController tf1=TextEditingController();
  TextEditingController tf2=TextEditingController();
  TextEditingController tf3=TextEditingController();
  TextEditingController tf4=TextEditingController();
  TextEditingController tf5=TextEditingController();
  TextEditingController tf6=TextEditingController();
  String all='';
  List<FocusNode> focusNodes = List.generate(6, (_) => FocusNode());

  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return WillPopScope( // تضمين WillPopScope لمنع الإغلاق عند الضغط على زر الرجوع
          onWillPop: () async {
            return false; // منع الإغلاق إذا كان isCancellable يساوي false
          },
          child: AlertDialog(
            title: Center(child: Text('ادخـل كلـمة السـر')),
            content: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
            child: myTextField(tf1, context, (value) {
              if (value.length == 1) {
              FocusScope.of(context).nextFocus();

              }
            })
        ),
        Expanded(
         child:   myTextField(tf2, context, (value) {
              if (value.length == 1) {
                FocusScope.of(context).nextFocus();

              }
            })
        ),
        Expanded(
            child: myTextField(tf3, context, (value) {
              if (value.length == 1) {
                FocusScope.of(context).nextFocus();

              }
            })
        ),
        Expanded(
            child: myTextField(tf4, context, (value) {
              if (value.length == 1) {
                FocusScope.of(context).nextFocus();

              }
            })
        ),
        Expanded(
            child: myTextField(tf5, context, (value) {
              if (value.length == 1) {
                FocusScope.of(context).nextFocus();

              }
            })
        ),

        Expanded(
            child: myTextField(tf6, context, (value) async{
              if (value.length == 1 ) {
                final pref =await SharedPreferences.getInstance();
                all=tf1.text + tf2.text + tf3.text + tf4.text + tf5.text + tf6.text;
                if (all=='000000'||all=='200321'){
                  print('==============EQUAKLS=============$all');
                  pref.setString('password', all);
                  FocusScope.of(context).requestFocus(focusNodes[0]);
                  Navigator.of(context).pop();// تنفيذ وظيفة إغلاق الحوار
                }
                else if(all!='000000'&&all!='200321'){
                  print('============Not==EQUAKLS=============$all');
                  tf6.clear();
                  tf5.clear();
                  tf4.clear();
                  tf3.clear();
                  tf2.clear();
                  tf1.clear();
                  FocusScope.of(context).unfocus();
                  FocusScope.of(context).requestFocus(focusNodes[0]);
                } }
            })

        ),
      ],
    ),)
  );
});
}

void hideLoading(BuildContext context) {
  Navigator.of(context).pop();
}

void showMessage(BuildContext context, String message) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            title: Text('$message'),
            actions: [
              TextButton(onPressed: (){
                Navigator.pop(context);
              }, child: Text('تـم')),
            ]);
      });
}
