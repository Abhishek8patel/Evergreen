

class UserModel {
  String user_id;
  String user_token;
  String user_name;
  String user_mobile;
  String user_pic;
  String user_role;
  String user_deviceID;

  UserModel(
      {
        required this.user_id,required this.user_token, required this.user_name, required this.user_mobile, required this.user_pic,required this.user_role,required this.user_deviceID
      });
}