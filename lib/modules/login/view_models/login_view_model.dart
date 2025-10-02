import 'package:ayur_project/constants/string_constants.dart';
import 'package:ayur_project/utils/shared_utils.dart';
import 'package:flutter/cupertino.dart';
import '../services/login_service.dart';

class LoginViewModel extends ChangeNotifier {

  bool isLoading = false;

  Future<bool> tryLogin (String username, String password) async {
    setLoader(true);
    final response = await LoginService.login(username, password);
    setLoader(false);
    if(response == null || (response.status == false)){
      return false;
    } else {
      SharedUtils.setString(StringConstants.appToken, response.token ?? "");
      return true;
    }
  }

  setLoader(bool val){
    isLoading = val;
    notifyListeners();
  }
}