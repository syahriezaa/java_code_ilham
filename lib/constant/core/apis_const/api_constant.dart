class ApiConstant{
  ///baseUrl
  static const String baseUrl ="https://trainee.landa.id/javacode";
  static const apiKey='';

  ///Authorization
  static const String login ='$baseUrl/auth/login';

  ///home
  ///Promo
  static const String allPromo ='$baseUrl/promo/all';
  static const String Promo ='$baseUrl/promo/detail';
  ///Menu
  static const String allMenu ='$baseUrl/menu/all';
  static const String menu ='$baseUrl/menu/detail';

  ///voucher
  static const String allVoucher ='$baseUrl/voucher/all';

  /// Order
  static const String addOrder = '$baseUrl/order/add';
  static const String onGoingOrder = '$baseUrl/order/user';
  static const String historyOrder = '$baseUrl/order/history';
  static const String detailOrder = '$baseUrl/order/detail';
  static const String cancelOrder = '$baseUrl/order/batal';


  /// Profile
  static const String detailUser = '$baseUrl/user/detail';
  static const String updateUser = '$baseUrl/user/update';
  static const String updateUserPhoto = '$baseUrl/user/profil';
  static const String updateUserKTP = '$baseUrl/user/ktp';


  /// Firebase Cloud Messaging
  static const String firebaseCloudMessaging =
      'https://fcm.googleapis.com/fcm/send';
}