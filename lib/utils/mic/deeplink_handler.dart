// import 'dart:developer' as dev;
// import 'package:app_links/app_links.dart';
// import 'package:go_router/go_router.dart';
// import 'package:office_book_app/utils/networks/end_point.dart';
// import 'package:office_book_app/utils/networks/network_service.dart';
// import '../constants/local_storage_key_strings.dart';
// import '../navigation/route_manager.dart';
// import '../networks/toast_services/toast_services.dart';

// class DeepLinkHandler {
//   static final DeepLinkHandler _instance = DeepLinkHandler._internal();

//   factory DeepLinkHandler() {
//     return _instance;
//   }

//   DeepLinkHandler._internal();

//   static final AppLinks _appLinks = AppLinks();

//   static Future<void> initDeepLinks() async {
//     try {
//       final Uri? initialLink = await _appLinks.getInitialLink();
//       if (initialLink != null) {
//         dev.log("Initial deep link received: $initialLink");
//         // Delay processing to ensure app is initialized
//         Future.delayed(const Duration(seconds: 1), () {
//           _handleDeepLink(initialLink);
//         });
//       }    } catch (e) {
//       dev.log("Error getting initial link: $e");
//     }

//     _appLinks.uriLinkStream.listen((Uri uri) {
//       dev.log("Stream deep link received: $uri");
//       _handleDeepLink(uri);
//     });
//   }

//   static void _handleDeepLink(Uri uri) {
//     dev.log("Processing deep link: $uri");
//     dev.log(
//         "Scheme: ${uri.scheme}, Authority: ${uri.authority}, Path: ${uri.path}, Query params: ${uri.queryParameters}");

//     // Check for payment-return in the authority/host instead of the path
//     if (uri.authority == 'payment-return' ||
//         uri.toString().contains('payment-return')) {
//       final templateId = uri.queryParameters['templateId'];
//       final admissionId = uri.queryParameters['admissionId'];

//       // Use correct parameter name with capital P in feesPaymentId
//       final paymentId = uri.queryParameters['feesPaymentId'];
//       final payload = uri.queryParameters['payload'];

//       dev.log(
//           "Payment return params: templateId=$templateId, admissionId=$admissionId");
//       if (payload != null && payload.isNotEmpty) {
//         dev.log(
//             "Payment data: paymentId=$paymentId, payload=${payload.substring(0)}...");
//       } else {
//         dev.log("Payment data: paymentId=$paymentId, payload=$payload");
//       }

//       // Navigate to fees details screen first
//       _navigateToFeesDetailsWithRetry();

//       // Process payment if we have the required data
//       if (paymentId != null && payload != null) {
//         dev.log("Found payment data in URL, processing payment");
//         processPaymentResponse(paymentId, payload).then((success) {
//           if (success) {
//             ToastServices.success("Payment", "Payment processed successfully");
//           } else {
//             ToastServices.error("Payment", "Failed to process payment");
//           }
//         });
//       } else {
//         dev.log(
//             "No payment data in URL: paymentId=$paymentId, payload=$payload");
//         ToastServices.success("Payment", "Returned from payment gateway");
//       }
//     }
//   }

//   static void _navigateToFeesDetailsWithRetry() {
//     // First attempt
//     _attemptNavigation();

//     // Try again after delays if needed
//     Future.delayed(const Duration(milliseconds: 500), _attemptNavigation);
//     Future.delayed(const Duration(seconds: 1), _attemptNavigation);
//     Future.delayed(const Duration(seconds: 2), _attemptNavigation);
//   }

//   static void _attemptNavigation() {
//     if (LocalStorageKeyStrings.appNavKey.currentContext != null) {
//       try {
//         dev.log("Navigating to fees details screen");
//         LocalStorageKeyStrings.appNavKey.currentContext
//             ?.go(AppRouter.feesDetailsScreen);
//       } catch (e) {
//         dev.log("Navigation error: $e");
//       }
//     } else {
//       dev.log("No valid navigation context available");
//     }
//   }


// static Future<bool> processPaymentResponse(String paymentId, String payload) async {
//   try {
//     final networkService = NetworkService();
    
//     Map<String, dynamic> data = {
//       "payment_id": paymentId, 
//       "payload": payload
//     };

//     dev.log("Sending payment data: $data");
    
//     final response = await networkService.postRequest(
//      EndPoint.paymentProcessUrl, 
//       body: data
//     );
    
//     dev.log("Payment process response: $response");
    
//     if (response is Map<String, dynamic> && response['success'] == true) {
//       return true;
//     } else {
//       return false;
//     }
//   } catch (e) {
//     dev.log("Error processing payment: $e");
//     return false;
//   }
// }
// }

// import 'dart:developer' as dev;
// import 'package:app_links/app_links.dart';
// import 'package:go_router/go_router.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:office_book_app/utils/networks/end_point.dart';
// import 'package:office_book_app/utils/networks/network_service.dart';
// import '../constants/local_storage_key_strings.dart';
// import '../navigation/route_manager.dart';
// import '../networks/toast_services/toast_services.dart';

// class DeepLinkHandler {
//   static final DeepLinkHandler _instance = DeepLinkHandler._internal();

//   factory DeepLinkHandler() {
//     return _instance;
//   }

//   DeepLinkHandler._internal();

//   static final AppLinks _appLinks = AppLinks();
//   static final _storage = GetStorage();
//   static const _processedPaymentKey = 'processed_payment_ids';

//   static Future<void> initDeepLinks() async {
//     try {
//       final Uri? initialLink = await _appLinks.getInitialLink();
//       if (initialLink != null) {
//         dev.log("Initial deep link received: $initialLink");
//         // Delay processing to ensure app is initialized
//         Future.delayed(const Duration(seconds: 1), () {
//           _handleDeepLink(initialLink);
//         });
//       }
//     } catch (e) {
//       dev.log("Error getting initial link: $e");
//     }

//     _appLinks.uriLinkStream.listen((Uri uri) {
//       dev.log("Stream deep link received: $uri");
//       _handleDeepLink(uri);
//     });
//   }

//   static void _handleDeepLink(Uri uri) {
//     dev.log("Processing deep link: $uri");
//     dev.log(
//         "Scheme: ${uri.scheme}, Authority: ${uri.authority}, Path: ${uri.path}, Query params: ${uri.queryParameters}");

//     // Check for payment-return in the authority/host instead of the path
//     if (uri.authority == 'payment-return' ||
//         uri.toString().contains('payment-return')) {
//       final templateId = uri.queryParameters['templateId'];
//       final admissionId = uri.queryParameters['admissionId'];

//       // Use correct parameter name with capital P in feesPaymentId
//       final paymentId = uri.queryParameters['feesPaymentId'];
//       final payload = uri.queryParameters['payload'];

//       // Check if this payment has already been processed
//       if (paymentId != null && _hasPaymentBeenProcessed(paymentId)) {
//         dev.log("Payment ID $paymentId has already been processed, skipping");
//         // Still navigate to the fees details screen
//         _navigateToFeesDetailsWithRetry();
//         return;
//       }

//       dev.log(
//           "Payment return params: templateId=$templateId, admissionId=$admissionId");
//       if (payload != null && payload.isNotEmpty) {
//         dev.log(
//             "Payment data: paymentId=$paymentId, payload length=${payload.length}");
//       } else {
//         dev.log("Payment data: paymentId=$paymentId, payload=$payload");
//       }

//       // Navigate to fees details screen first
//       _navigateToFeesDetailsWithRetry();

//       // Process payment if we have the required data
//       if (paymentId != null && payload != null) {
//         dev.log("Found payment data in URL, processing payment");
//         processPaymentResponse(paymentId, payload).then((success) {
//           if (success) {
//             ToastServices.success("Payment", "Payment processed successfully");
//             // Mark this payment as processed
//             _markPaymentAsProcessed(paymentId);
//           } else {
//             ToastServices.error("Payment", "Failed to process payment");
//           }
//         });
//       } else {
//         dev.log(
//             "No payment data in URL: paymentId=$paymentId, payload=$payload");
//         ToastServices.success("Payment", "Returned from payment gateway");
//       }
//     }
//   }

//   // Check if a payment has already been processed
//   static bool _hasPaymentBeenProcessed(String paymentId) {
//     final processedPayments = _storage.read<List<dynamic>>(_processedPaymentKey) ?? [];
//     return processedPayments.contains(paymentId);
//   }

//   // Mark a payment as processed
//   static void _markPaymentAsProcessed(String paymentId) {
//     final processedPayments = _storage.read<List<dynamic>>(_processedPaymentKey) ?? [];
//     if (!processedPayments.contains(paymentId)) {
//       processedPayments.add(paymentId);
//       _storage.write(_processedPaymentKey, processedPayments);
//       dev.log("Marked payment ID $paymentId as processed");
//     }
//   }

//   static void _navigateToFeesDetailsWithRetry() {
//     // First attempt
//     _attemptNavigation();

//     // Try again after delays if needed
//     Future.delayed(const Duration(milliseconds: 500), _attemptNavigation);
//     Future.delayed(const Duration(seconds: 1), _attemptNavigation);
//     Future.delayed(const Duration(seconds: 2), _attemptNavigation);
//   }

//   static void _attemptNavigation() {
//     if (LocalStorageKeyStrings.appNavKey.currentContext != null) {
//       try {
//         dev.log("Navigating to fees details screen");
//         LocalStorageKeyStrings.appNavKey.currentContext
//             ?.go(AppRouter.feesDetailsScreen);
//       } catch (e) {
//         dev.log("Navigation error: $e");
//       }
//     } else {
//       dev.log("No valid navigation context available");
//     }
//   }

//   static Future<bool> processPaymentResponse(String paymentId, String payload) async {
//     try {
//       final networkService = NetworkService();
      
//       Map<String, dynamic> data = {
//         "payment_id": paymentId, 
//         "payload": payload
//       };

//       dev.log("Sending payment data: $data");
      
//       final response = await networkService.postRequest(
//         EndPoint.paymentProcessUrl, 
//         body: data
//       );
      
//       dev.log("Payment process response: $response");
      
//       if (response is Map<String, dynamic> && response['success'] == true) {
//         return true;
//       } else {
//         return false;
//       }
//     } catch (e) {
//       dev.log("Error processing payment: $e");
//       return false;
//     }
//   }
// }
