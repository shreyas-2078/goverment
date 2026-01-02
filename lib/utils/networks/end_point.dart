import '../../environment_config/environment_config.dart';

class EndPoint {
  // dev appId
  static const int appId = 3498234234232;
  static const String currentAppVersion = '2.0.4';
  static const String faveBaseUrl = '13.127.215.111:8000';
  //document base Url
  static const String documentBaseUrl =
      "mzdj9zyo62.execute-api.ap-south-1.amazonaws.com";
  // S3 bucket URL for file storage
  static const String s3BucketUrl =
      'https://baap-app-images.s3.ap-south-1.amazonaws.com';

  // static const String baseUrl = 'ssp-dev.simplifysandbox.net';
  static var appBaseUrl = EnvironmentConfiguration.baseUrlApi!;
  static var faceBaseUrl = EnvironmentConfiguration.faceUrlApi!;
  // AWS API Gateway host for category services
  static const String awsHost =
      'dt1wp7hrm9.execute-api.ap-south-1.amazonaws.com';
  // Default clientId used across endpoints
  static const String clientId = 'fec98d40-b361-459e-97de-e9ca2bd0239e';
 static const String searchNearbyCurl =
      '/data/search/nearby';
  static const String loginUrl = '/auth/api/auth/login';
  static const String groupUrl = '/auth/api/clients';
  static const String refreshTokenUrl = '/auth/api/auth/refresh-token';
  static const String sendOtpUrl = '/auth/api/auth/request-otp-phoneNumber';
  static const String verifyOtpUrl = '/auth/api/auth/verifyOtp';
  static const String checkUserUrl = '/auth/api/users/check-user';
  // Business Register
  static const String businessRegisterUrl = '/auth/api/business/';
  static const String getAllBusinessTypesApi =
      '/auth/api/business-types/client/';
  static const String getAllBusinessOwnershipApi =
      '/auth/api/business-ownership/client/';
  static const String userRegisterUrl = '/auth/api/public/client/';

  static const String getProfile = '/auth/api/users/client/';
  static const String priceComparison = '/auth/api/product/client/';

  // Product API endpoints
  static const String getProductListBusiness = '/auth/api/product/client';
  static const String getProductDetails =
      '/auth/api/product/client/fec98d40-b361-459e-97de-e9ca2bd0239e/business/product/';

  // Search vs AI endpoints
  static const String searchNearby =
      '/data/search/nearby'; // host: 34.93.228.193:8001
  static const String aiChat = '/api/query'; // host: 34.93.228.193:8000

  // Categories
  static const String getAllCategory = 
  '/auth/api/business-category/client';
  static const String getAllSubCategory =
'/auth/api/business-subcategory/client/';

static const String getAllSubCategoryServiceData =
'/auth/api/business/client';
}
