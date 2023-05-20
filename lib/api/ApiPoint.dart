class ApiPoint {
  //BASE URL
  String baseUrl = "https://tiqarte.azurewebsites.net/api/";

//END POINT
  String socialLogin = "user/login_social?";
  String getHomeData = "getHomeData";
  String GetEvents = "GetEvents";
  String getEventDetail = "getEventDetail?eventID=";
  String getOrganizerDetail = "getOrganizerDetail?organizerID=";
  String setFav = "setFav";
  String getfavList = "getfavList?customerID=";
  String getEventByLocation = "getEventByLocation";
  String getCategory = "getCategory";
  String GetAllRoles = "GetAllRoles";
  String getRelatedEvents = "getRelatedEvents?eventID=";
  String getEventsByType = "getEventsByType?eventTypeId=";
  String getEventSearch = "getEventSearch?searchText=";
}
