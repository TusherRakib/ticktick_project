import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../model/login_model.dart';

abstract class AuthenticationService extends GetxService {
  Future<LoginModel?> getCurrentUser();
  Future<void> signOut();

}

class UserAuthenticationService extends AuthenticationService {

  @override
  Future<LoginModel?> getCurrentUser() async {
    var currentUser = GetStorage("Auth").read('user');
    if (currentUser != null) {
      log(currentUser.toString());
      return LoginModel.fromJson(currentUser);
    }
    log('Auth is null');
    return null;
  }

  @override
  Future<void> signOut() async {
    try {
      await GetStorage().erase();
      await GetStorage("Auth").erase();
      await GetStorage("Swap").erase();
      debugPrint('StorageCleared');
    }catch (e){
      e.printError(info: 'StorageClearedFailed');
    }
  }
}


class AuthenticationException implements Exception {
  final String message;

  AuthenticationException({this.message = 'Unknown error occurred. '});
}
