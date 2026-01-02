import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:my_board/imports.dart';
import 'package:my_board/modules/subscription/subsciption_controller.dart';
import 'package:my_board/widget/custom_appbar_widget.dart';
import 'package:my_board/widget/custom_textfields.dart';

import 'card_changed_sucessfully.dart';

class ChangeCardView extends GetView<SubscriptionController> {
  const ChangeCardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GetBuilder<SubscriptionController>(builder: (controller) {
          return ElevatedButtonW(
            onTap: () {
              controller.submitData(context);
             // Get.to(const CardChnagedSucessfully());
            },
            buttonText: "Pay now",
            isLoading: controller.paymentlaoding,
            buttonColor: controller.buttonActive
                ? AppColors.appColor
                : AppColors.greyColor,
            buttonTextColor:
                controller.buttonActive ? Colors.white : Colors.black,
          );
        }),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomAppBar(
                  text: "Payment",
                ),
                CreditCardWidget(
                  cardBgColor: AppColors.appColor,
                  chipColor: AppColors.greyColor,
                  // bankName: "Master Card",
                  enableFloatingCard: true,
                  isHolderNameVisible: true,
                  cardType: CardType.mastercard,
                  textStyle: TextStyles.text3White!.copyWith(fontSize: 12),
                  cardNumber: "11111111111111",
                  expiryDate: "Jan 2020",
                  cardHolderName: "Dansih Ali",
                  cvvCode: "111",
                  showBackView:
                      true, //true when you want to show cvv(back) view
                  onCreditCardWidgetChange: (CreditCardBrand
                      brand) {}, // Callback for anytime credit card brand is changed
                ),
                SizedBox(
                  height: Get.height * 0.05,
                ),
                //_____________________________________CARD NUMBER
                Text(
                  "Card Number ",
                  style: TextStyles.text3!.copyWith(fontSize: 16),
                ),
                SizedBox(
                  height: Get.height * 0.01,
                ),
                AppTextField(
                  controller: controller.cardNumberCtrl,
                  image: "",
                  maxLength: 16,
                  hintText: "Number",
                  onchanged: (value) {
                    controller.isDataValidate();
                  },
                  textInputType: TextInputType.number,
                  isShowLeading: false,
                ),

                //_____________________________________CARD NUMBER
                Text(
                  "Name on card ",
                  style: TextStyles.text3!.copyWith(fontSize: 16),
                ),
                SizedBox(
                  height: Get.height * 0.01,
                ),
                AppTextField(
                  controller: controller.cardNameCtrl,
                  image: "",
                  onchanged: (value) {
                    controller.isDataValidate();
                  },
                  hintText: "Name",
                  textInputType: TextInputType.name,
                  isShowLeading: false,
                ),

                Row(
                  children: [
                    SizedBox(
                      height: Get.height * 0.05,
                    ),
                    //_____________________________________CARD NUMBER
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Expiration Date",
                            style: TextStyles.text3!.copyWith(fontSize: 16),
                          ),
                          SizedBox(
                            height: Get.height * 0.01,
                          ),
                          GetBuilder<SubscriptionController>(
                              builder: (controller) {
                            return AppTextField(
                              controller: controller.cardExpiryCtrl,
                              onchanged: (value) {
                                controller.onDateChange();
                                controller.isDataValidate();
                              },
                              image: "",
                              maxLength: 5,
                              hintText: "MM/YY",
                              textInputType: TextInputType.number,
                              isShowLeading: false,
                            );
                          })
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    //_____________________________________CARD NUMBER
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Security Code",
                            style: TextStyles.text3!.copyWith(fontSize: 16),
                          ),
                          SizedBox(
                            height: Get.height * 0.01,
                          ),
                          AppTextField(
                            controller: controller.cardCvvCtrl,
                            image: "",
                            maxLength: 3,
                            hintText: "Code",
                            onchanged: (value) {
                              controller.isDataValidate();
                            },
                            textInputType: TextInputType.number,
                            isShowLeading: false,
                          )
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
