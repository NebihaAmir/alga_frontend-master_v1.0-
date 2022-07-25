class CancelReservation {
  String cancelreservation = """
    mutation(\$reservationId: ID){
  userCancelReservation(reservationId: \$reservationId) {
    message
  }
}
    """;
}
