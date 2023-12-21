class ApiPoint {
  //BASE URL
  String baseUrl = "https://tiqarte.azurewebsites.net/api/";

//END POINT
  String register = "customer/register";
  String verifyOtp = "customer/VerifyEmailOTP?otp=";
  String updateProfile = "customer/updateProfile";
  String login = "customer/login";
  String generateOtpTemp = "customer/GenerateEmailOTPTemp?emailAddress=";
  String verifyEmailOTPTemp = "customer/VerifyEmailOTPTemp?";
  String getProfile = "customer/GetProfile";
  String changePassword = "customer/ChangePassword";
  String socialLogin = "user/login_social?";
  String getHomeData =
      "getHomeData?CategoryId=&City=&LocationSearch.la=t&LocationSearch.long=&LocationSearch.disctance=";
  String getHomeDataWithFilter = "getHomeData?";
  String GetEvents = "GetEvents";
  String getEventDetail = "getEventDetail?eventID=";
  String getOrganizerDetails = "getOrganizerDetails?organizerID=";
  String setFav = "setFav";
  String getfavList = "getfavList?customerID=";
  String getEventByLocation = "getEventByLocation?location=";
  String getCategory = "getCategory";
  String GetAllRoles = "GetAllRoles";
  String getRelatedEvents = "getRelatedEvents?eventID=";
  String getReviewsByEvent = "getReviewsByEvent?eventID=";

  String getEventsByType = "getEventsByType?eventTypeId=";
  String getEventsBySearch = "getEventsBySearch";
  String getAllProductList = "getAllProductList?PromotorId=";
  String getSingleProductDetail = "getSingleProductById?ProductId=";
  String getMoreLikeProducts = "getAllProductListByCatagoryId?CatagoryId=";
  String setOrganizerFollow = "setOrganizerFollow";
  String getCustomerTicketList = "getCustomerTicketList";
  String getETicket = "getETicket?TicketUniqueNumber=";
  String eventCancel = "eventCancel?";
  String eventReview = "eventReview?";
  String getAllFAQTypes = "getAllFAQTypes";
  String getAllFAQs = "getAllFAQs";
  String getPromotorContacts = "getPromotorContacts?PromotorId=";

  String ticketBooking = "ticketBooking";
  String searchFAQByType = "searchFAQByType?SearchText=";
  String addToCart = "addToCart";
  String addToCartDelete = "addToCartDelete?Id=";
  String getAddToCartByUser = "getAddToCartByUser";
  String getAllProductListByUser = "getAllProductListByUser";
  String shopCheckout = 'shopCheckOut';
  String createOrder = "payments/createorder";
  String getAllLocations = "getAllLocations";

  //admin
  String getArticles =
      "https://tiqarte.azurewebsites.net/admin/getAllArticleByPromotor?PromotorId=";
}
