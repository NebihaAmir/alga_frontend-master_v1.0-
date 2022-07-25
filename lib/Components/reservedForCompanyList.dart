import 'package:flutter/material.dart';

class ReservedForCompanyList extends StatelessWidget {
  const ReservedForCompanyList({
    Key? key,
    required this.reserveId,
    required this.floorNo,
    required this.roomNo,
  }) : super(key: key);

  final reserveId;
  final floorNo;
  final roomNo;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "Reserve Id: ",
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.black54, fontSize: 17),
              ),
              SizedBox(
                width: 30,
              ),
              Text(
                reserveId,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.black54, fontSize: 17),
              ),
              SizedBox(
                width: 30,
              ),
              IconButton(
                  onPressed: () => {print("cancelled")},
                  icon: Icon(Icons.cancel_rounded))
            ],
          ),
          Row(
            children: [
              Text(
                "Floor No: ",
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.black54, fontSize: 17),
              ),
              Text(
                floorNo,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.black54, fontSize: 17),
              ),
              SizedBox(
                width: 30,
              ),
              Text(
                "Room No: ",
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.black54, fontSize: 17),
              ),
              Text(
                roomNo,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.black54, fontSize: 17),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
