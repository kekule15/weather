

import 'package:weather/http/network.dart' as networkutils;
import 'package:weather/http/custom_exception.dart';

class ErrorManager {
  static parseError(dynamic e) {
    if (e.response == null) {
      throw const CustomException('Connection error');
    }
    if (e.response.data is String) {
      if (networkutils.decodeResponseBodyToJson(
          e.response.data as String)['errors'] is String) {
        throw CustomException(
            e.response?.data != null
                ? e.response.data['errors'] != null
                    ? e.response.data['errors'][0] as String
                    : e.message as String
                : e.message as String,
            deviceRegistered: e.response?.statusCode != 409);
      } else if (networkutils
              .decodeResponseBodyToJson(e.response.data.toString())['errors']
              .runtimeType is List ||
          networkutils
                  .decodeResponseBodyToJson(
                      e.response.data.toString())['errors']
                  .runtimeType ==
              List<dynamic>.empty(growable: true).runtimeType) {
        String error = '';
        for (String item in networkutils
            .decodeResponseBodyToJson(e.response.data.toString())['errors']) {
          bool nextLine = error.isNotEmpty;
          error = '$error$item${nextLine ? '\n' : ''}';
        }
        throw CustomException(error,
            deviceRegistered: e.response?.statusCode != 409);
      } else {
        String error = '';
        Map<String, dynamic> errors = networkutils.decodeResponseBodyToJson(
            e.response.data.toString())['errors'] as Map<String, dynamic>;
        for (String item in errors.keys) {
          bool nextLine = error.isNotEmpty;
          error = '$error${errors[item]}${nextLine ? '\n' : ''}';
        }
        throw CustomException(error,
            deviceRegistered: e.response?.statusCode != 409);
      }
    } else {
      if (e.response.data['errors'] is String) {
        throw CustomException(
            e.response?.data != null
                ? e.response.data['errors'] != null
                    ? e.response.data['errors'][0] as String
                    : e.message as String
                : e.message as String,
            deviceRegistered: e.response?.statusCode != 409);
      } else if (e.response.data['errors'] is List) {
        String error = '';
        for (String item in e.response.data['errors']) {
          bool nextLine = error.isNotEmpty;
          error = '$error$item${nextLine ? '\n' : ''}';
        }
        throw CustomException(error,
            deviceRegistered: e.response?.statusCode != 409);
      } else {
        String error = '';
        Map<String, dynamic> errors =
            e.response.data['errors'] as Map<String, dynamic>;
        for (String item in errors.keys) {
          bool nextLine = error.isNotEmpty;
          error = '$error${errors[item]}${nextLine ? '\n' : ''}';
        }
        throw CustomException(error,
            deviceRegistered: e.response?.statusCode != 409);
      }
    }
  }
}
