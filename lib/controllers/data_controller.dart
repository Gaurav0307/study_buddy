import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:study_buddy/common/constants/api_constants.dart';
import 'package:study_buddy/controllers/base_controller.dart';
import 'package:study_buddy/views/screens/splash_screen.dart';

import '../common/constants/storage_constants.dart';
import '../common/global/global.dart';
import '../common/helper/dialog_helper.dart';
import '../common/services/app_exceptions.dart';
import '../common/services/base_client.dart';
import '../models/BranchesAndYearsModel.dart';
import '../models/ContentModel.dart';

class DataController extends GetxController with BaseController {
  var isLoading = false.obs;
  var branchesAndYearsModel = BranchesAndYearsModel().obs;
  var contentModel = ContentModel().obs;

  Future<void> getBranchesAndYears() async {
    isLoading.value = true;

    var baseUrl = ApiConstants.baseUrl;
    var endpoint = ApiConstants.branchesAndYears;

    var responseJson =
        await BaseClient().get(baseUrl, endpoint, null).catchError(
      (error) {
        if (error is BadRequestException) {
          var apiError = json.decode(error.message!);
          if (apiError["message"] != null) {
            DialogHelper.showErrorSnackBar(
              title: "Error",
              description: apiError["message"],
            );
          }
        } else if (error is UnAuthorizedException) {
          var apiError = json.decode(error.message!);
          if (apiError["message"] != null) {
            DialogHelper.showErrorSnackBar(
              title: "Error",
              description: apiError["message"],
            );
          }
        } else {
          handleError(error);
        }
      },
    );

    if (kDebugMode) {
      log("Branches and Years API Response :-> $responseJson");
    }

    if (responseJson == null || responseJson.toString().contains("jwt")) {
      if (sharedPreferences!.containsKey(StorageConstants.token)) {
        await sharedPreferences!.clear();
        token = "";
        userId = "";
        username = "";
        userEmail = "";
        Get.to(() => const SplashScreen());
      }
    } else {
      var message = jsonDecode(responseJson)["message"];

      if (message != null) {
        // showMessage(description: message.toString());
      }

      branchesAndYearsModel.value = branchesAndYearsModelFromJson(responseJson);
    }

    isLoading.value = false;
  }

  Future<void> getContents(String branch, String year) async {
    isLoading.value = true;

    var baseUrl = ApiConstants.baseUrl;
    var endpoint = "${ApiConstants.contents}?branch=$branch&year=$year";

    var responseJson =
        await BaseClient().get(baseUrl, endpoint, null).catchError(
      (error) {
        if (error is BadRequestException) {
          var apiError = json.decode(error.message!);
          if (apiError["message"] != null) {
            DialogHelper.showErrorSnackBar(
              title: "Error",
              description: apiError["message"],
            );
          }
        } else if (error is UnAuthorizedException) {
          var apiError = json.decode(error.message!);
          if (apiError["message"] != null) {
            DialogHelper.showErrorSnackBar(
              title: "Error",
              description: apiError["message"],
            );
          }
        } else {
          handleError(error);
        }
      },
    );

    if (kDebugMode) {
      log("Contents API Response :-> $responseJson");
    }

    if (responseJson == null || responseJson.toString().contains("jwt")) {
      if (sharedPreferences!.containsKey(StorageConstants.token)) {
        await sharedPreferences!.clear();
        token = "";
        userId = "";
        username = "";
        userEmail = "";
        Get.to(() => const SplashScreen());
      }
    } else {
      var message = jsonDecode(responseJson)["message"];

      if (message != null) {
        // showMessage(description: message);
      }

      contentModel.value = contentModelFromJson(responseJson);
    }

    isLoading.value = false;
  }
}
