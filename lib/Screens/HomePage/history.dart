import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:nearby_hotel_detction_booking_app/Components/Drawer.dart';
import 'package:nearby_hotel_detction_booking_app/Components/No%20internet%20Connection/error_page.dart';
import 'package:nearby_hotel_detction_booking_app/Components/history_reservation_list_card.dart';
import 'package:nearby_hotel_detction_booking_app/Components/history_booking_list_card.dart';
import 'package:nearby_hotel_detction_booking_app/Components/histrory_company_reservation%20card.dart';
//import 'package:nearby_hotel_detction_booking_app/Components/spinner.dart';
import 'package:nearby_hotel_detction_booking_app/Controllers/variable_conatroller.dart';
import 'package:nearby_hotel_detction_booking_app/Costants/constants.dart';
import 'package:nearby_hotel_detction_booking_app/Query%20Class/Cancel_reservation_mutation.dart';

class History extends StatefulWidget {
  History({Key? key}) : super(key: key);

  @override
  _HistoryState createState() => _HistoryState();
}

VariablesController variables = Get.put(VariablesController());
String reservatioquery = """
    query{
userViewReservation {
  checkout_time
  checkin_time
  createdAt
  Id
  room {
    room_no
    floor_no
  }
  hotel {
    name
  }
}
}
    """;
String companyReservation = """
query{
 userViewCompanyReservation {
  company_name
  checkout_time
  checkin_time
  createdAt
  hotel{
    name
  }
  Id
  room{
    ID
    room_no
    floor_no
  }
}
}
""";

String bookingquery = """
    query{
 userViewBookings {
    checkin_time
    checkout
    checkout_time
    createdAt
    Id
    room {
      available
room_no
floor_no
roomType {
  name
}
    }
hotel {
  name
}
  }
}
    """;
HttpLink httpLink = HttpLink(
  'http://192.168.1.10:5000/graphql',

//  'http://157.230.190.157/graphql',
  defaultHeaders: <String, String>{
    'Authorization': 'Bearer ${variables.getoken()}',
  },
);
ValueNotifier<GraphQLClient> client = ValueNotifier(GraphQLClient(
  link: httpLink,
  cache: GraphQLCache(store: InMemoryStore()),
));

class _HistoryState extends State<History> {
  String? message;
  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: client,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          toolbarHeight: MediaQuery.of(context).size.height / 14,
          elevation: 0,
          centerTitle: true,
          title: Text(
            "History",
            style: TextStyle(color: bgcolor),
          ),
          leading: Builder(
              builder: (con) => IconButton(
                    icon: Icon(CupertinoIcons.list_dash, color: bgcolor),
                    onPressed: () => Scaffold.of(con).openDrawer(),
                  )),
        ),
        drawer: Mydrawer(),
        body: DefaultTabController(
          length: 3,
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 18,
                color: Colors.white,
                child: TabBar(
                  indicatorColor: bgcolor,
                  unselectedLabelColor: Color(0xFF555555),
                  labelColor: bgcolor,
                  labelPadding: EdgeInsets.symmetric(horizontal: 8.0),
                  tabs: [
                    Tab(
                      child: Text(
                        "Booked",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    Tab(
                      child: Text(
                        "Reserved",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    Tab(
                      child: Text(
                        "company test",
                        style: TextStyle(fontSize: 16),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Container(
                    height: MediaQuery.of(context).size.height,
                    child: TabBarView(
                      children: [
                        Query(
                            options: QueryOptions(document: gql(bookingquery)),
                            builder: (QueryResult result,
                                {VoidCallback? refetch, FetchMore? fetchMore}) {
                              if (result.hasException) {
                                if (result.exception!.linkException != null) {
                                  return ErrorPage(
                                    backwidget: History(),
                                  );
                                } else {
                                  return ErrorPage2(
                                    backwidget: History(),
                                    messagetext: result
                                        .exception!.graphqlErrors[0].message,
                                  );
                                }
                              }

                              if (result.isLoading) {
                                return Center(
                                    child: CircularProgressIndicator(
                                        color: bgcolor));
                              }
                              return ListView.builder(
                                itemCount:
                                    result.data?['userViewBookings'].length,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                itemBuilder: (BuildContext context, int index) {
                                  return HistoryBookedListCart(
                                      createdAt: result.data?['userViewBookings']
                                          [index]['createdAt'],
                                      hotelname: result.data?['userViewBookings']
                                          [index]['hotel']['name'],
                                      reserveId: result.data?['userViewBookings']
                                          [index]['Id'],
                                      checkInDate: result.data?['userViewBookings']
                                          [index]['checkin_time'],
                                      checkOutDate: result.data?['userViewBookings']
                                          [index]['checkout_time'],
                                      floorno: result.data?['userViewBookings']
                                          [index]['room']['floor_no'],
                                      roomNo: result.data?['userViewBookings']
                                          [index]['room']['room_no'],
                                      checkout: result.data?['userViewBookings']
                                          [index]['checkout'],
                                      services: 'services');
                                },
                              );
                            }),
                        Query(
                            options: QueryOptions(
                              document: gql(reservatioquery),
                            ),
                            builder: (QueryResult result,
                                {VoidCallback? refetch, FetchMore? fetchMore}) {
                              if (result.hasException) {
                                if (result.exception!.linkException != null) {
                                  return ErrorPage(
                                    backwidget: History(),
                                  );
                                } else {
                                  return ErrorPage2(
                                    backwidget: History(),
                                    messagetext: result
                                        .exception!.graphqlErrors[0].message,
                                  );
                                }
                              }

                              if (result.isLoading) {
                                return Center(
                                    child: CircularProgressIndicator(
                                        color: bgcolor));
                              }
                              List<HistoryReservationCard> hotels = [];
                              int count =
                                  result.data?['userViewReservation'].length;
                              for (int i = 0; i < count; i++) {
                                hotels.add(HistoryReservationCard(
                                    createdAt: result.data?['userViewReservation']
                                        [i]['createdAt'],
                                    hotelname: result.data?['userViewReservation']
                                        [i]['hotel']['name'],
                                    reserveId: result.data?['userViewReservation']
                                        [i]['Id'],
                                    checkInDate: result.data?['userViewReservation']
                                        [i]['checkin_time'],
                                    checkOutDate: result.data?['userViewReservation']
                                        [i]['checkout_time'],
                                    floorno: result.data?['userViewReservation']
                                        [i]['room']['floor_no'],
                                    roomNo: result.data?['userViewReservation']
                                        [i]['room']['room_no'],
                                    services: 'services'));
                              }

                              return ListView.builder(
                                itemCount:
                                    result.data?['userViewReservation'].length,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                itemBuilder: (BuildContext context, int index) {
                                  return Container(child: hotels[index]);
                                },
                              );
                            }),
                        Query(
                            options: QueryOptions(
                              document: gql(companyReservation),
                            ),
                            builder: (QueryResult result,
                                {VoidCallback? refetch, FetchMore? fetchMore}) {
                              if (result.hasException) {
                                if (result.exception!.linkException != null) {
                                  return ErrorPage(
                                    backwidget: History(),
                                  );
                                } else {
                                  return ErrorPage2(
                                    backwidget: History(),
                                    messagetext: result
                                        .exception!.graphqlErrors[0].message,
                                  );
                                }
                              }

                              if (result.isLoading) {
                                return Center(
                                    child: CircularProgressIndicator(
                                        color: bgcolor));
                              }
                              List<HistoryCompanyReservation> hotels = [];
                              int count = result
                                  .data?['userViewCompanyReservation'].length;
                              for (int i = 0; i < count; i++) {
                                hotels.add(HistoryCompanyReservation(
                                    companyName: result.data?['userViewCompanyReservation']
                                        [i]['createdAt'],
                                    createdAt: result.data?['userViewCompanyReservation']
                                        [i]['createdAt'],
                                    hotelname: result.data?['userViewCompanyReservation']
                                        [i]['hotel']['name'],
                                    reserveId: result.data?['userViewCompanyReservation']
                                        [i]['Id'],
                                    checkInDate: result.data?['userViewCompanyReservation']
                                        [i]['checkin_time'],
                                    checkOutDate: result.data?['userViewCompanyReservation']
                                        [i]['checkout_time'],
                                    floorno: result.data?['userViewCompanyReservation']
                                        [i]['room']['floor_no'],
                                    roomNo: result.data?['userViewCompanyReservation'][i]['room']['room_no'],
                                    services: 'services'));
                              }

                              return ListView.builder(
                                itemCount: result
                                    .data?['userViewCompanyReservation'].length,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                itemBuilder: (BuildContext context, int index) {
                                  return Container(child: hotels[index]);
                                },
                              );
                            }),
                      ],
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
