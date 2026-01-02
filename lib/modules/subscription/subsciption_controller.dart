// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:my_board/imports.dart';
import 'package:my_board/modules/subscription/card_changed_sucessfully.dart';
import 'package:my_board/core/values/show.dart';

import '../../core/api_service.dart';
import '../../core/values/api_constant.dart';
import '../../data/models/user_model.dart';
import '../dashboard/dashboard pages/home/home_controller.dart';

class SubscriptionController extends GetxController {
  TextEditingController cardNumberCtrl = TextEditingController();
  TextEditingController cardNameCtrl = TextEditingController();
  TextEditingController cardExpiryCtrl = TextEditingController();
  TextEditingController cardCvvCtrl = TextEditingController();
  bool buttonActive = false;
  bool loading = true;
  bool paymentlaoding = false;
  UserModel currentUser = UserModel();

  onDateChange() {
    if (cardExpiryCtrl.text.length == 2 && !cardExpiryCtrl.text.contains("/")) {
      cardExpiryCtrl.text = '${cardExpiryCtrl.text}/';
      update();
    }
  }

  isDataValidate() {
    print("Cling...........");
    if (cardNumberCtrl.text.length == 16 &&
        cardNameCtrl.text.isNotEmpty &&
        (cardExpiryCtrl.text.length == 5 && cardExpiryCtrl.text[2] == "/") &&
        cardCvvCtrl.text.length == 3) {
      buttonActive = true;
    } else {
      buttonActive = false;
    }
    update();
  }

  submitData(context) async {
    if (!buttonActive) {
      Show.showErrorSnackBar("Error", "Please Enter Valid Data");
    } else {
      createStripeToken(context);
      // Show.showSuccessSnackBar("Success", "Card Detail Changed");
      //  Get.to(const CardChnagedSucessfully());
    }
  }

  createStripeToken(BuildContext context) async {
    try {
      final cardDetails = CardDetails(
          number: cardNumberCtrl.text, // Valid test card number
          expirationMonth: int.parse(cardExpiryCtrl.text
              .split("/")[0]), // Use a future expiration month
          expirationYear: int.parse(cardExpiryCtrl.text
              .split("/")[1]), // Use a future expiration year
          cvc: cardCvvCtrl.text // Use a valid test CVC
          );

      Stripe.instance.dangerouslyUpdateCardDetails(cardDetails);

      final billingDetails = BillingDetails(
        email: "example@doe.com",
        name: cardNameCtrl.text,
        address: const Address(
          city: "Test City",
          country: "US", // Use the two-letter country code
          line1: "123 Test Street",
          line2: '',
          state: "CA", // Use the two-letter state code if applicable
          postalCode: "12345",
        ),
      );

      /// Create a payment method
      final paymentMethod = await Stripe.instance.createPaymentMethod(
        params: PaymentMethodParams.card(
          paymentMethodData: PaymentMethodData(billingDetails: billingDetails),
        ),
      );
      String token = paymentMethod.id;
      if (token.isNotEmpty) {
        try {
          paymentlaoding = true;
          update();
          String email = await getUserEmail();
          var data = {"stripeToken": token, "customerEmail": email};
          print(data);
          print(EndPoint.subscription);
          bool result = await APIService().postDataWithAPI(
              url: EndPoint.subscription, data: data, context: context);
          if (result == false) {
            paymentlaoding = false;
            update();
            Show.showErrorSnackBar("Error", "Enter Correct Card Detail");
          } else {
            await getCurrentUser();
            Get.find<DashBoardHomeController>().getCurrentUser();
            paymentlaoding = false;
            update();
            Show.showSuccessSnackBar("Success", "Card Detail Changed");
            Get.to(const CardChnagedSucessfully());
          }
        } catch (error) {
          paymentlaoding = false;
          update();
        }
      }

      return true;
    } catch (error) {
      Show.showErrorSnackBar("Error", "Enter Correct Card Detail");
      print("Error creating token: $error");
      return false;
    }
  }

  cancelMembership(BuildContext context) async {
    try {
      bool result = await APIService().deleteDataWithAPI(
          url: EndPoint.cancelSubscription, context: context);
      if (result) {
        await getCurrentUser();
        Get.find<DashBoardHomeController>().getCurrentUser();
        Get.back();
      //  Get.offNamed(Routes.navigation);
      }
    } catch (error) {
      return null;
    }
  }

  getUserEmail() async {
    try {
      var data = await APIService()
          .getDataWithAPIWithoutContext(url: EndPoint.getProfile);
      if (data != null) {
        UserModel user = UserModel.fromJson(data["user"]);

        return user.email!;
      }
    } catch (error) {
      return null;
    }
  }

  getCurrentUser() async {
    try {
      loading = true;
      update();
      var data = await APIService()
          .getDataWithAPIWithoutContext(url: EndPoint.getProfile);
      if (data != null) {
        currentUser = UserModel.fromJson(data["user"]);
        loading = false;
        update();
      }
      loading = false;
      update();
    } catch (error) {
      loading = false;
      update();
      print(error);
    }
  }

  @override
  void onInit() {
    getCurrentUser();
    super.onInit();
  }
}
