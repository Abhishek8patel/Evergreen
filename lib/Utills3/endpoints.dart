class AppEndPoints {
  static String register = "/api/user/register_User";
  static String forget_pw = "/api/user/forgetPassword";
  static String resend_otp = "/api/user/resendOTP";
  static String image_upload = "/api/user/upload_Images_Profile";

  static String edit_image_upload ="/api/user/editProfilePic";
  static String update_profile ="/api/user/EditProfileData";
  static String logout_user ="/api/user/logoutUser";
  static String contact_us ="/api/CompanyDetails/contactUs";
  static String get_pro ="/api/user/getUser";
  static String change_password ="/api/user/ChangePassword";
  static String SEAttendace="/api/se/SEAttendance";
  static String SESite="/api/se/SiteGetAllotmentUser";
  static String SITEPRODUCTS="/api/se/SiteByProduct";
  static String GETPROBLEMS="/api/problems/get_all_Problem";
  static String SUBMITFORM="/api/Report/ReportSubmit";

  static String CHEMICAL_LIST_GET="/api/products/GetChemicallist";
  static String UPDATE_CHEMICAL="/api/products/UpdateChemicallist";
  static String SESitesFromAllotment="/api/sv/SESitesFromAllotment";
  static String LEAVE="/api/user/leaveApplication";
  static String RESIGNATION="/api/user/resignationApplication";
  //api/user/leaveApplication

  static String seSitesHomePage="/api/se/getReportHomePage";

  static String UPLOAD_SELFI="/api/sv/AddSelfie";

//api/products/UpdateChemicallist

//api/sv/SESitesFromAllotmen
  //se

  static String getSiteData="/api/admin/SESitesFromAllotment";
  static String SVAttendace="/api/sv/SVAttendance";
  static String SVSITEPRODUCTS="/api/sv/SiteByProduct";
  static String CLIENT_EMAIL="/api/sv/GetClientEmail";
  static String SEND_EMAIL="/api/sv/OtpSendClientEmail";
  static String VERIFY_OTP="/api/sv/ClientVerifyOtp";

  static String SV_GET_REPORT="/api/Report/ReportGet";

//new

  static String PRODUCTBYSITE="/api/se/getAllProductNamebySite";


  static String POSTWORKINGTYPE="/api/se/AddWorkingType";

  static String SVPOSTWORKINGTYPE="/api/sv/AddWorkingType";

  static String POSTEDITWORKINGTYPE="/api/se/EditWorkingType";

  static String SVPOSTEDITWORKINGTYPE="/api/sv/EditWorkingType";

  //api/se/EditWorkingType
  static String NOTEMPTYVALUES="/api/products/getNotEmptyVaule";

  static String SVNOTEMPTYVALUES="/api/products/getNotEmptyVaule";

  static String EDITNOTEMPTYVALUES="/api/se/getEditNotEmptyVaule";


  static String SVEDITNOTEMPTYVALUES="/api/sv/getEditNotEmptyVaule";


  static String EDITGETIMAGES="/api/se/EditgetImages";

  static String SVEDITGETIMAGES="/api/sv/EditgetImages";



  //api/se/getEditNotEmptyVaule

  static String POSTCOTRERCVALUES="/api/se/Addvalue";
  static String SVPOSTCOTRERCVALUES="/api/sv/Addvalue";



  static String EDITPOSTCOTRERCVALUES="/api/se/Editvalue";

  static String SVEDITPOSTCOTRERCVALUES="/api/sv/Editvalue";


  //api/sv/Editvalue
  static String FINALFORMSUBMIT="/api/se/dataSubmitupdate";


  static String SVFINALFORMSUBMIT="/api/sv/dataSubmitupdate";



  static String ADDIMAGE="/api/se/AddImage";

  static String SVADDIMAGE="/api/sv/AddImage";

  static String SOLUTIONS="/api/problems/getSolutionById";
  //api/problems/getSolutionById



  static String SEEDITADDIMAGE="/api/se/EditImages";

  static String SVEDITADDIMAGE="/api/sv/EditImages";




  static String SEEDITPRODUCT="/api/se/EditgetWorkingType";


  static String SVEDITPRODUCT="/api/sv/EditgetWorkingType";



  //api/se/EditgetWorkingType
//api/se/dataSubmitupdate


//api/se/SiteByProduct

  static String SVPRODUCTBYSITE="/api/sv/getAllProductNamebySite";

  static String SVHOMEPAGESITE="/api/sv/SESitesFromAllotment";

}
