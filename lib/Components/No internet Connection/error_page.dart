import 'package:flutter/material.dart';
import 'package:nearby_hotel_detction_booking_app/Costants/constants.dart';

class ErrorPage extends StatefulWidget {
  final Widget backwidget;
  const ErrorPage({Key? key, required this.backwidget}) : super(key: key);

  @override
  _ErrorPageState createState() => _ErrorPageState();
}

class _ErrorPageState extends State<ErrorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        // fit: StackFit.expand,
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 2,
            width: MediaQuery.of(context).size.width,
            child: Image.asset(
              "assets/images/error_image.png",
              fit: BoxFit.cover,
            ),
          ),
          Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Text(
              "OH NO!!! Something went wrong",
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 30,
            ),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: bgcolor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)),
              ),
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => widget.backwidget));
              },
              child: Text(
                " Please Try Again ",
                style: TextStyle(
                    color: bgcolor2, fontSize: 18, fontWeight: FontWeight.w500),
              ),
            ),
          ])
        ],
      ),
    );
  }
}

class ErrorPage2 extends StatefulWidget {
  final Widget backwidget;
  const ErrorPage2(
      {Key? key, required this.messagetext, required this.backwidget})
      : super(key: key);
  final String messagetext;
  @override
  _ErrorPage2State createState() => _ErrorPage2State();
}

class _ErrorPage2State extends State<ErrorPage2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            "assets/images/error_image.jpg",
            fit: BoxFit.cover,
          ),
          Positioned(
            child: Container(
              height: 80,
              width: 100,
              color: Colors.white,
            ),
            bottom: MediaQuery.of(context).size.height * 0.25,
            left: MediaQuery.of(context).size.width * 0.1,
            right: MediaQuery.of(context).size.width * 0.1,
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.25,
            left: MediaQuery.of(context).size.width * 0.1,
            right: MediaQuery.of(context).size.width * 0.1,
            child: Text(
              widget.messagetext,
              style: TextStyle(color: Colors.grey[600]),
            ),
          ),
          Positioned(
              bottom: MediaQuery.of(context).size.height * 0.15,
              left: MediaQuery.of(context).size.width * 0.3,
              right: MediaQuery.of(context).size.width * 0.3,
              child: TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              widget.backwidget));
                },
                child: Text(
                  'Retry',
                  style: TextStyle(color: Colors.grey[900], fontSize: 20),
                ),
              ))
        ],
      ),
    );
  }
}
