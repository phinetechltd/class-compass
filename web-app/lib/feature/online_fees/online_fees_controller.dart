import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:class_compass/api_handle/api_checker.dart';
import 'package:class_compass/api_handle/api_client.dart';
import 'package:class_compass/common/widget/custom_snackbar.dart';
import 'package:class_compass/util/app_constants.dart';
import 'package:universal_html/html.dart' as html;

class OnlineFeesRepository {
  final ApiClient apiClient;
  OnlineFeesRepository({required this.apiClient});

  Future<Response> getDue() => apiClient.getData(AppConstants.onlineFeesDue);
  Future<Response> pay(Map<String, dynamic> body) => apiClient.postData(AppConstants.onlineFeesPay, body);
  Future<Response> status(String id) => apiClient.getData("${AppConstants.onlineFeesPayments}/$id");
  Future<Response> history() => apiClient.getData(AppConstants.onlineFeesPayments);
  Future<Response> adminList(int page) => apiClient.getData("${AppConstants.adminOnlineFeePayments}?page=$page");
}

/// Parents and students paying school fees with M-Pesa (STK push) or Paystack.
class OnlineFeesController extends GetxController implements GetxService {
  final OnlineFeesRepository repository;
  OnlineFeesController({required this.repository});

  bool loading = false;
  bool paying = false;
  Map<String, dynamic>? due;
  List<dynamic> history = [];
  String selectedMethod = 'mpesa';

  /// Status of the payment currently being tracked: pending | paid | failed.
  String? trackingStatus;
  String? trackingMessage;
  String? trackingReceipt;
  Timer? _poll;

  List<dynamic> get methods => (due?['methods'] as List?) ?? [];
  double get totalDue => double.tryParse('${due?['total_due'] ?? 0}') ?? 0;
  String get currency => '${due?['currency'] ?? 'KES'}';

  Future<void> load() async {
    loading = true;
    update();
    final response = await repository.getDue();
    if (response.statusCode == 200) {
      due = response.body['data'];
      if (methods.isNotEmpty && !methods.any((m) => m['key'] == selectedMethod)) {
        selectedMethod = methods.first['key'];
      }
    } else {
      ApiChecker.checkApi(response);
    }
    final historyResponse = await repository.history();
    if (historyResponse.statusCode == 200) {
      history = historyResponse.body['data'] ?? [];
    }
    loading = false;
    update();
  }

  void selectMethod(String method) {
    selectedMethod = method;
    update();
  }

  Future<void> pay({required double amount, String? phone}) async {
    if (amount <= 0) {
      showCustomSnackBar("enter_amount".tr);
      return;
    }
    paying = true;
    update();
    final body = <String, dynamic>{
      'method': selectedMethod,
      'amount': amount,
      if (phone != null) 'phone': phone,
      if (kIsWeb) 'redirect_url': '${html.window.location.origin}${html.window.location.pathname}',
    };
    final response = await repository.pay(body);
    paying = false;
    if (response.statusCode == 200) {
      final data = response.body['data'];
      if (data['method'] == 'paystack') {
        if (kIsWeb) {
          html.window.open(data['authorization_url'], '_self');
          return;
        }
        // Mobile: pay in the browser, then come back to the app; we keep checking the status.
        await launchUrl(Uri.parse(data['authorization_url']), mode: LaunchMode.externalApplication);
        trackingStatus = 'pending';
        trackingMessage = "complete_payment_in_browser".tr;
        _startPolling(data['payment_id']);
        update();
        return;
      }
      trackingStatus = 'pending';
      trackingMessage = data['message'];
      trackingReceipt = null;
      _startPolling(data['payment_id']);
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  /// Called when Paystack redirects back with ?payment_id=..&flag=..
  void resumeFromRedirect(String paymentId) {
    trackingStatus = 'pending';
    trackingMessage = "confirming_payment".tr;
    update();
    _startPolling(paymentId);
  }

  void _startPolling(String paymentId) {
    _poll?.cancel();
    int ticks = 0;
    _poll = Timer.periodic(const Duration(seconds: 4), (timer) async {
      ticks++;
      final response = await repository.status(paymentId);
      if (response.statusCode == 200) {
        final data = response.body['data'];
        final status = data['status'];
        if (status == 'paid' || status == 'failed') {
          timer.cancel();
          trackingStatus = status;
          trackingReceipt = data['receipt'];
          trackingMessage = status == 'paid' ? "payment_received".tr : (data['message'] ?? "payment_not_completed".tr);
          await load();
        }
      }
      if (ticks >= 45 && trackingStatus == 'pending') {
        timer.cancel();
        trackingStatus = 'failed';
        trackingMessage = "payment_timed_out".tr;
      }
      update();
    });
  }

  void clearTracking() {
    _poll?.cancel();
    trackingStatus = null;
    trackingMessage = null;
    trackingReceipt = null;
    update();
  }

  // ------------------------------------------------------------ school admin
  List<dynamic> adminPayments = [];
  int adminPage = 1;
  int adminLastPage = 1;
  bool adminLoading = false;

  Future<void> loadAdmin({int page = 1}) async {
    adminLoading = true;
    update();
    final response = await repository.adminList(page);
    if (response.statusCode == 200) {
      final data = response.body['data'];
      adminPayments = data['data'] ?? [];
      adminPage = data['current_page'] ?? 1;
      adminLastPage = data['last_page'] ?? 1;
    } else {
      ApiChecker.checkApi(response);
    }
    adminLoading = false;
    update();
  }

  @override
  void onClose() {
    _poll?.cancel();
    super.onClose();
  }
}
