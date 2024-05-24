import 'package:jetcare/src/core/utils/enums.dart';

class EndPoints {
  static const Environment environment = Environment.development;
  static const baseUrl = "https://api.jetcareeg.net/api/";
  static const imageDomain = "https://api.jetcareeg.net/public/images/";

// --------------------- new api
  // ------------------- Auth
  static const register = "register";
  static const login = "login";
  static const resetPassword = "reset_password";
  static const forgetPassword = "forget_password";
  static const logout = "logout";

  // ------------------- Profile
  static const profile = "profile";
  static const updateProfile = "update_profile";
  static const updateFCM = "update_fcm";
  static const deleteAccount = "delete_account";
  static const restoreAccount = "restore_account";

// ---------------------
  static const mail = "mail";
  static const checkEmail = "checkEmail";
  static const getHome = "getHome";
  static const getAppInfo = "getAppInfo";
  static const getAllStates = "getAllStates";
  static const getAreasOfState = "getAreasOfState";
  static const updateAccount = "updateAccount";
  static const getCategoryDetails = "getCategoryDetails";
  static const getPackageDetails = "getPackageDetails";
  static const getPackages = "getPackages";
  static const getMyOrders = "getMyOrders";
  static const addSupport = "addSupport";
  static const getSpaces = "getSpacesMobile";
  static const addAddress = "addAddress";
  static const getAreas = "getAreasMobile";
  static const getDatesMobile = "getDatesMobile";
  static const getPeriods = "getPeriodsMobile";
  static const createOrder = "createOrder";
  static const getMyAddresses = "getMyAddresses";
  static const deleteAddress = "deleteAddress";
  static const updateAddress = "updateAddress";
  static const getMyTasks = "getMyTasks";
  static const rejectOrder = "rejectOrder";
  static const deleteOrder = "deleteOrder";
  static const updateOrderStatusUser = "updateOrderStatusUser";
  static const updateOrderStatus = "updateOrderStatus";
  static const addCorporateOrder = "addCorporateOrder";
  static const saveNotification = "saveNotification";
  static const readNotification = "readNotification";
  static const getNotifications = "getNotifications";
  static const getCalender = "getCalender";
  static const addToCart = "addToCart";
  static const deleteFromCart = "deleteFromCart";
  static const getMyCart = "getMyCart";
}
