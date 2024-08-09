// import 'package:customer_application/features/home/views/home_screen.dart';
// import 'package:razorpay_flutter/razorpay_flutter.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class RazorpayService {
//   static const String _keyId = 'rzp_test_8xlE5n49iITFkd';
//   late Razorpay _razorpay;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   double _lastAmount = 0;
//   final BuildContext context;

//   RazorpayService(this.context) {
//     _razorpay = Razorpay();
//     _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
//     _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
//     _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
//   }

//   void initiatePayment(double amount) {
//     _lastAmount = amount;
//     var options = {
//       'key': _keyId,
//       'amount': (amount * 100).toInt(),
//       'name': 'ALFA Aluminium works',
//       'description': 'Test Payment',
//       'prefill': {
//         'contact': FirebaseAuth.instance.currentUser?.phoneNumber ?? '',
//         'email': FirebaseAuth.instance.currentUser?.email ?? '',
//       },
//       'external': {
//         'wallets': ['paytm']
//       }
//     };

//     try {
//       _razorpay.open(options);
//     } catch (e) {
//       debugPrint('Error: $e');
//     }
//   }

//   void _handlePaymentSuccess(PaymentSuccessResponse response) async {
//     print("Payment successful");
//     print("Payment ID: ${response.paymentId}");
//     print("Order ID: ${response.orderId}");
//     print("Signature: ${response.signature}");
    
//     // Save payment details to Firestore
//     await _firestore.collection('payments').add({
//       'amount': _lastAmount,
//       'paymentId': response.paymentId,
//       'orderId': response.orderId,
//       'signature': response.signature,
//       'date': DateTime.now().toIso8601String(),
//       'customerId': FirebaseAuth.instance.currentUser?.uid,
//     });

//     // Navigate to HomeScreen
//     Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomeScreen()));
//   }

//   void _handlePaymentError(PaymentFailureResponse response) {
//     print("Payment failed");
//     print("Error code: ${response.code}");
//     print("Error message: ${response.message}");
//   }

//   void _handleExternalWallet(ExternalWalletResponse response) {
//     print("External wallet selected: ${response.walletName}");
//   }

//   void dispose() {
//     _razorpay.clear();
//   }
// }
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RazorpayService {
  static const String _keyId = 'rzp_test_8xlE5n49iITFkd';
  late Razorpay _razorpay;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  double _lastAmount = 0;
  final BuildContext context;
  Function? onPaymentSuccess;

  RazorpayService(this.context) {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void initiatePayment(double amount) {
    _lastAmount = amount;
    var options = {
      'key': _keyId,
      'amount': (amount * 100).toInt(),
      'name': 'ALFA Aluminium works',
      'description': 'Test Payment',
      'prefill': {
        'contact': FirebaseAuth.instance.currentUser?.phoneNumber ?? '',
        'email': FirebaseAuth.instance.currentUser?.email ?? '',
      },
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    print("Payment successful");
    print("Payment ID: ${response.paymentId}");
    print("Order ID: ${response.orderId}");
    print("Signature: ${response.signature}");
    
    await _firestore.collection('payments').add({
      'amount': _lastAmount,
      'paymentId': response.paymentId,
      'orderId': response.orderId,
      'signature': response.signature,
      'date': DateTime.now().toIso8601String(),
      'customerId': FirebaseAuth.instance.currentUser?.uid,
    });

    if (onPaymentSuccess != null) {
      onPaymentSuccess!();
    }
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print("Payment failed");
    print("Error code: ${response.code}");
    print("Error message: ${response.message}");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print("External wallet selected: ${response.walletName}");
  }

  void dispose() {
    _razorpay.clear();
  }
}