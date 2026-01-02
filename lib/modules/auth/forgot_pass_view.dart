// ignore_for_file: must_be_immutable

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_board/imports.dart';
import 'package:my_board/modules/auth/auth_controller.dart';
import 'package:my_board/widget/custom_textfields.dart';

class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: Get.height * 0.02, horizontal: Get.height * 0.02),
          child: ListView(
            children: [
              SizedBox(
                height: Get.height * 0.3,
              ),
              Text(
                "Forgot Password",
                style: TextStyles.h1,
                textAlign: TextAlign.center,
              ),
              Text(
                "Please enter your Phone Number",
                style: TextStyles.smallText,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: Get.height * 0.05,
              ),
              AppTextField(
                  controller: Get.find<SplashController>().emailCtrl,
                  image: AppImages.callIcon,
                  hintText: "Email",
                  isShowLeading: false,
                  textInputType: TextInputType.emailAddress),

              GetBuilder<SplashController>(builder: (contoller) {
                return ElevatedButtonW(
                  buttonText: "Send Otp",
                  onTap: () {
                    contoller.sentOtopToEmail(context);
                  },
                  isLoading: contoller.postingData,
                );
              }),

              SizedBox(
                height: Get.height * 0.3,
              ),
              // const Spacer(),
              InkWell(
                onTap: () {
                  Get.toNamed(Routes.signIn);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have a account? ",
                      style: TextStyles.smallText2,
                    ),
                    Text(
                      "Login",
                      style: TextStyles.smallText2!
                          .copyWith(color: AppColors.appColor),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
