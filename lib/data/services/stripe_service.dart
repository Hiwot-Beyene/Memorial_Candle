import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:lightforisrael/consts.dart';

class StripeService {
  StripeService._();

  static final StripeService instance = StripeService._();

  Future<void> makePayment(BuildContext context) async {
    try {
      // Get the donator's details from the user
      Map<String, String>? donorDetails = await _getDonorDetailsFromUser(context);
      if (donorDetails == null) return;

      // Set the donation amount to $2
      int amount = 2;

      // Create the payment intent with the fixed amount
      String? paymentIntentClientSecret = await _createPaymentIntent(
        amount,
        "usd",
      );
      if (paymentIntentClientSecret == null) return;

      // Initialize the payment sheet
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntentClientSecret,
          merchantDisplayName: "Light For Israel",
        ),
      );

      // Process the payment
      await _processPayment();
    } catch (e) {
      print(e);
    }
  }

  Future<Map<String, String>?> _getDonorDetailsFromUser(BuildContext context) async {
    TextEditingController nameController = TextEditingController();
    TextEditingController wordController = TextEditingController();
    Map<String, String>? donorDetails;

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Donator Details"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                hintText: "Enter your name",
                labelText: "Name",
              ),
            ),
            TextField(
              controller: wordController,
              decoration: InputDecoration(
                hintText: "Enter a personal word",
                labelText: "Personal Word",
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (nameController.text.isNotEmpty && wordController.text.isNotEmpty) {
                donorDetails = {
                  "name": nameController.text,
                  "personalWord": wordController.text,
                };
              }
              Navigator.of(context).pop(donorDetails);
            },
            child: Text(
              "Submit",
              style: TextStyle(color: Colors.blue), // Light text color
            ),
          ),
        ],
      ),
    );

    return donorDetails;
  }

  Future<String?> _createPaymentIntent(int amount, String currency) async {
    try {
      final Dio dio = Dio();
      Map<String, dynamic> data = {
        "amount": _calculateAmount(amount),
        "currency": currency,
      };
      var response = await dio.post(
        "https://api.stripe.com/v1/payment_intents",
        data: data,
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
          headers: {
            "Authorization": "Bearer $stripeSecretKey",
            "Content-Type": 'application/x-www-form-urlencoded'
          },
        ),
      );
      if (response.data != null) {
        return response.data["client_secret"];
      }
      return null;
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<void> _processPayment() async {
    try {
      await Stripe.instance.presentPaymentSheet();
      await Stripe.instance.confirmPaymentSheetPayment();
    } catch (e) {
      print(e);
    }
  }

  String _calculateAmount(int amount) {
    final calculatedAmount = amount * 100;
    return calculatedAmount.toString();
  }
}
