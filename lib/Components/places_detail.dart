// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:nearby_hotel_detction_booking_app/Components/Hotellist_card.dart';
import 'package:nearby_hotel_detction_booking_app/Components/No%20internet%20Connection/error_page.dart';
import 'package:nearby_hotel_detction_booking_app/Controllers/variable_conatroller.dart';
import 'package:nearby_hotel_detction_booking_app/Costants/constants.dart';
import 'package:nearby_hotel_detction_booking_app/Pages/Blank%20Pages/placesbyState.dart';
import 'package:nearby_hotel_detction_booking_app/Pages/Hotel_list.dart';
import 'package:nearby_hotel_detction_booking_app/Pages/Hotel_page.dart';
import 'package:nearby_hotel_detction_booking_app/Query%20Class/hotel_query.dart';
import 'package:nearby_hotel_detction_booking_app/Query%20Class/place_query.dart';

class PlacesDetails extends StatefulWidget {
  const PlacesDetails({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<PlacesDetails> createState() => _PlacesDetailsState();
}

class _PlacesDetailsState extends State<PlacesDetails> {
  final VariablesController variables = Get.put(VariablesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.chevron_left,
              color: bgcolor,
              size: 35,
            )),
        centerTitle: true,
        leadingWidth: 30,
        title: Text(
          "Hotels in " + widget.title,
          style: TextStyle(color: bgcolor),
        ),
      ),
      body: Query(
          options: QueryOptions(
              document: gql(FindPlaces().viewHotelByState),
              variables: {'state': widget.title}),
          builder: (QueryResult result,
              {VoidCallback? refetch, FetchMore? fetchMore}) {
            if (result.hasException) {
              if (result.exception!.linkException != null) {
                return ErrorPage(
                  backwidget: PlaceByState(),
                );
              } else {
                return ErrorPage2(
                  backwidget: Hotels(),
                  messagetext: result.exception!.graphqlErrors[0].message,
                );
              }
            }

            if (result.isLoading) {
              print("loading");
              //  return Center(child:  CircularProgressIndicator(color: bgcolor));
              return Center(child: CircularProgressIndicator(color: bgcolor));
            }

            return ListView.builder(
              shrinkWrap: true,
              itemCount: result.data?['viewHotelByState'].length,
              padding: const EdgeInsets.symmetric(horizontal: 5),
              itemBuilder: (BuildContext context, int index) {
                print(result.data?['viewHotelByState'][index]['state']);
                return (Text("hello"));
                /*            return HotelListCart2(
                  star: result.data?['viewHotelByState'][index]['star'],
                  index: index,
                  address: result.data?['viewHotelByState
                  
                  
                  '][index]['location']
                          ['state'] +
                      ", " +
                      result.data?['viewHotelByState'][index]['location']
                          ['city'] +
                      ", " +
                      result.data?['viewHotelByState'][index]['location']
                          ['wereda'],
                  onpress: () {
                    List<String> hotels = [];
                    int y = result
                        .data?['viewHotelByState'][index]['roomTypes'].length;
                    String name = '';

                    for (int z = 0; z < y; z++) {
                      name = result.data?['viewHotelByState'][index]
                          ['roomTypes'][z]['name'];
                      hotels.add(name);
                    }

                    variables.sethotelIndex(index);
                    variables.setHotelid(
                        result.data?['viewHotelByState'][index]['Id']);

                    Get.to(() => TravelApp(
                          rating: result.data?['viewHotelByState'][index]
                              ['rate']['rateAvarage'],
                          ratetotal: result.data?['viewHotelByState'][index]
                              ['rate']['rateCount'],
                          aboutHoteldescription: result
                              .data?['viewHotelByState'][index]['description'],
                          aboutHotelname: result.data?['viewHotelByState']
                              [index]['name'],
                          city: result.data?['viewHotelByState'][index]
                              ['location']['city'],
                          wereda: result.data?['viewHotelByState'][index]
                              ['location']['wereda'],
                          state: result.data?['viewHotelByState'][index]
                              ['location']['state'],
                          email: result.data?['viewHotelByState'][index]
                              ['email'],
                          phoneNo: result.data!['viewHotelByState'][index]
                                  ['phone_no']
                              .toString(),
                          aboutImageUrl: result.data?['viewHotelByState'][index]
                              ['photos'][0]['imageURI'],
                          roomTypescount: index,
                          hotelName: hotels,
                          id: variables.hotelid,
                          hotelImageurl: result.data?['viewHotelByState'][index]
                              ['photos'][0]['imageURI'],
                        ));
                  },
                  hotelImageUrl: result.data?['viewHotelByState'][index]
                      ['photos'][0]['imageURI'],
                  hotelname: result.data?['viewHotelByState'][index]['name'],
                );
   */
              },
            );
          }),
    );
  }
}
