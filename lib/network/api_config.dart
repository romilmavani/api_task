class ApiConfig {
  // static const String baseUrl = "http://192.168.29.131:3040/";
  // static const String baseUrl = "https://api.danialdean.houstonitdevelopers.com:3040/";
  static const String baseUrl = "https://api.danialdean.houstonitdevelopers.com/";

  static const String signUp = "${baseUrl}api/user/signup";
  static const String login = "${baseUrl}api/user/login";
  static const String forgotPassword = "${baseUrl}api/user/forgotpassword";
  static const String createForm = "${baseUrl}api/form/createForm";
  static const String addImage = "${baseUrl}api/upload/image";
  static const String submitFirstCall = "${baseUrl}api/form/submitfirstcall";
  static const String employeeRequests = "${baseUrl}api/admin/employeeRequests";
  static const String memberList = "${baseUrl}api/admin/memberList";
  static const String getData = "${baseUrl}api/form/getData";
  static const String getFirstCall = "${baseUrl}api/form/getfirstCalls";
  static const String uploadMaterial = "${baseUrl}api/upload/material";
  static const String getScheduleLookAtCall = "${baseUrl}api/form/getscheduleLookAt";
  static const String getDDCall = "${baseUrl}api/form/getDDcall";
  static const String getWorkDetail = "${baseUrl}api/workdetails/workservices";
  static const String getFolder = "${baseUrl}api/form/getFolder";
  static const String getFormData = "${baseUrl}api/form/getFormData";
  static const String getTicket = "${baseUrl}api/form/getTicket";
  static const String submitScheduleLookAt = "${baseUrl}api/form/submitScheduleLookAt";
  static const String submitLookAt = "${baseUrl}api/form/submitLookAt";
  static const String createDuplicate = "${baseUrl}api/form/createDuplicate";
  static const String updateFutureCall = "${baseUrl}api/form/updateFutureCall";
  static const String ticketDate = "${baseUrl}api/form/ticketDate";
  static const String submitDDCall = "${baseUrl}api/form/submitDDcall";
  static const String submitSubmitLookAt = "${baseUrl}api/form/submitLookAt";
  static const String submitSendContract = "${baseUrl}api/form/submitSendContract";
  static const String getSingleLookAt = "${baseUrl}api/form/getSingleLookAt";
  static const String submitNeedConfirmReceive = "${baseUrl}api/form/submitNeedConfirmReceive";
  static const String submitSentContract = "${baseUrl}api/form/submitSentContract";
  static const String getAllContractor = "${baseUrl}api/form/getAllContractor";
  static const String updateForm = "${baseUrl}api/form/updateForm";
  static const String addContact = "${baseUrl}api/form/createContractor";
  static const String contractorMsg = "${baseUrl}api/form/contractorMsg";
  static const String searchCustomerName = "${baseUrl}api/contract/getForm";
  static const String getImages = "${baseUrl}api/form/getPhotos";

  static const String msgTime = "${baseUrl}api/form/msgTime";
  static const String addWorkDetails = "${baseUrl}api/workdetails/searchwork";
  static const String getLatLong = "${baseUrl}api/form/getMapLink";
  static const String invitationMail = "${baseUrl}api/admin/invitationMail";

  static const String submitData = "${baseUrl}api/form/submitData";
  static const String getPriceList = "${baseUrl}api/contract/getPriceList";
  static const String getMainCategory = "${baseUrl}api/contract/getMainTypeList";
  static const String createContract = "${baseUrl}api/contract/contractForm";
  static const String subTypeList = "${baseUrl}api/contract/getSubTypeList";
  static const String getSubSubList = "${baseUrl}api/contract/getPage";
  static const String acceptRequest = "${baseUrl}api/admin/employeeRequests/accept";
  static const String denyRequest = "${baseUrl}api/admin/employeeRequests/deny";

  static const String createContractAPI = "${baseUrl}api/contract/createContract";
  static const String createConditionAPI = "${baseUrl}api/contract/createCondition";
  static const String downLoadPdfAPI = "${baseUrl}api/contract/uploadPDF";
  static const String getContractData = "${baseUrl}api/contract/getContract";

  static const String getMapData = "${baseUrl}api/form/getCustomInfo";

  static const String changePermission = "${baseUrl}api/admin/memberDetails";

  static const String methodPOST = "post";
  static const String methodGET = "get";
  static const String methodPUT = "put";
  static const String methodDELETE = "delete";
  static const String error = "Error";
  static const String success = "Success";
  static const String message = "Message";
  static const String loginPref = "loginPref";
  static const String warning = "Warning";
}
