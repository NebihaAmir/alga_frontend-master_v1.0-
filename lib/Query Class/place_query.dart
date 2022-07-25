class PlacesQuery {
  String placesQuery = """
  query{
  viewHotelsState {
      location{
            state
      }
    
  }
}
  """;
}

class FindPlaces {
  String viewHotelByState = """
query viewHotelsByState (\$state: String!){
   viewHotelByState(state : \$state){
          name
          email
    
  
  }
  }
""";
}
