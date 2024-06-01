import 'package:jetcare/src/core/utils/enums.dart';

class EndPoints {
  static const Environment environment = Environment.development;
  static const baseUrl = "https://api.jetcareeg.net/api/";
  static const imageDomain = "https://api.jetcareeg.net/public/images/";

// --------------------- new api
  // ------------------- Auth
  static const verifyEmail = "verify_email";
  static const validateCode = "validate_code";
  static const checkEmail = "check_email";
  static const login = "login";
  static const register = "register";
  static const updateFCM = "update_fcm";
  static const resetPassword = "reset_password";
  static const forgetPassword = "forget_password";
  static const logout = "logout";

  // ------------------- Profile
  static const profile = "profile";
  static const updateProfile = "update_profile";
  static const deleteAccount = "delete_account";
  static const restoreAccount = "restore_account";

  // ------------------- Home
  static const getHome = "get_home";
  static const getPackageDetails = "get_package_details";
  static const getCategoryDetails = "get_category_details";

  // ------------------- Crew Layout
  static const getMyTasks = "get_my_tasks";
  static const getMyTasksHistory = "get_my_tasks_history";
  static const updateOrderStatus = "update_order_status";
  static const rejectOrder = "reject_order";

  // ------------------- Notification
  static const saveNotification = "save_notification";
  static const readNotification = "read_notification";
  static const getNotifications = "get_notifications";

  // ------------------- Support
  static const getTerms = "get_terms";
  static const getAbout = "get_about";
  static const getContact = "get_contact";
  static const addSupport = "add_support";

  // ------------------- Address
  static const addAddress = "add_address";
  static const updateAddress = "update_address";
  static const deleteAddress = "delete_address";
  static const getMyAddresses = "get_my_addresses";
  static const getStates = "get_states_mobile";
  static const getAreasOfState = "get_areas_of_state";

  // ------------------- cart
  static const getMyCart = "get_my_cart";
  static const addToCart = "add_to_cart";
  static const deleteFromCart = "delete_from_cart";

  // ------------------- Appointment
  static const getPeriods = "get_periods_mobile";
  static const getSpaces = "get_spaces_mobile";
  static const getCalendar = "get_calendar";

  // ------------------- Corporate
  static const addCorporateOrder = "add_corporate_order";
  static const getMyCorporateOrders = "get_my_corporate_orders";

  // ------------------- Orders
  static const getMyOrders = "get_my_orders";
  static const createOrder = "create_order";
  static const deleteOrder = "delete_order";
  static const cancelOrder = "cancel_order";
}
