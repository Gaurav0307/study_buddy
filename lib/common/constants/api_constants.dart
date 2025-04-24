import '../global/global.dart';

class ApiConstants {
  static const String baseUrl = apiBaseUrl;

  /// GraphQl Endpoint
  static const String graphQL = "/graphql";

  /// REST API Endpoints
  static const String branchesAndYears = "/api/booklets"; // GET
  static const String contents = "/api/1/booklet-questions"; // GET
}
