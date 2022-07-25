import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nearby_hotel_detction_booking_app/Costants/constants.dart';
//import 'package:nearby_hotel_detction_booking_app/Screens/auth/Screens/Languages/localeString.dart';
import 'package:nearby_hotel_detction_booking_app/Screens/auth/Screens/Login/login_screen.dart';
import 'package:nearby_hotel_detction_booking_app/Screens/auth/Screens/Signup/signup_screen.dart';
//import 'package:nearby_hotel_detction_booking_app/Screens/auth/Screens/Welcome/components/background.dart';
import 'package:nearby_hotel_detction_booking_app/Screens/auth/components/rounded_button.dart';

class Body extends StatelessWidget {
  final List locale = [
    {'name': 'ENGLISH', 'locale': Locale('en', 'US')},
    {'name': 'አማርኛ', 'locale': Locale('amh', 'Amh')},
    {'name': 'Afaan Oromo', 'locale': Locale('af', 'Af')},
    {'name': 'ትግርኛ', 'locale': Locale('tig', 'Tig')},
    {'name': 'Somali', 'locale': Locale('som', 'Som')},
  ];
  updateLanguage(Locale locale) {
    Get.back();
    Get.updateLocale(locale);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // This size provide us total height and width of our screen
    return Scaffold(
      // translation: LocalString(),
      // locale: Locale('En','Amh'),
      appBar: AppBar(
        backgroundColor: bgcolor2,
        bottomOpacity: 0.0,
        // toolbarOpacity: 0.0,
        title: Container(
          color: bgcolor2,
          child: IconButton(
            icon: Icon(
              Icons.language,
              size: 40,
              color: bgcolor,
            ),
            // tooltip: 'Show Snackbar',
            onPressed: () {
              buildLanguageDialog(context);
              // ScaffoldMessenger.of(context).showSnackBar(
              //     const SnackBar(content: Text('Comming Soon ...')));
            },
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: size.height * 0.05),
            Image.asset(
              "assets/icons/logo.png",
              height: size.height * 0.45,
            ),
            SizedBox(height: size.height * 0.05),
            RoundedButton4(
              widthsize: size.width * 0.8,
              text: 'LOGIN'.tr,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginScreen();
                    },
                  ),
                );
              },
              color: bgcolor,
            ),
            RoundedButton4(
              widthsize: size.width * 0.8,
              text: 'Register'.tr,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SignUpScreen();
                    },
                  ),
                );
              },
              color: bgcolor,
            ),
          ],
        ),
      ),
    );
  }

  void buildLanguageDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (builder) {
          return AlertDialog(
            title: Text('Choose Your Language'),
            content: Container(
              width: double.maxFinite,
              child: ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        child: Text(locale[index]['name']),
                        onTap: () {
                          print(locale[index]['name']);
                          updateLanguage(locale[index]['locale']);
                        },
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Divider(
                      color: Colors.blue,
                    );
                  },
                  itemCount: locale.length),
            ),
          );
        });
  }
}
