// ignore_for_file: must_be_immutable

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_board/imports.dart';
import 'package:my_board/widget/custom_textfields.dart';

import '../../core/values/form_validator_constant.dart';
import 'auth_controller.dart';

class ChangePasswordView extends StatelessWidget {
  const ChangePasswordView({super.key});

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
                "Change Password",
                style: TextStyles.h1,
                textAlign: TextAlign.center,
              ),
              Text(
                "Enter your new Password",
                style: TextStyles.smallText,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: Get.height * 0.05,
              ),
              GetBuilder<SplashController>(builder: (cont) {
                return TextFormField(
                  controller: cont.passwordCtrl,
                  obscureText: cont.showPassword,
                  decoration: InputDecoration(
                      prefixIcon: SizedBox(
                          height: Get.height * 0.02,
                          width: Get.width * 0.03,
                          child: Padding(
                            padding: const EdgeInsets.all(11.0),
                            child: Image.asset(
                              AppImages.lockIcon,
                              fit: BoxFit.contain,
                            ),
                          )),
                      suffix: InkWell(
                          onTap: () {
                            cont.showPassword = !cont.showPassword;
                            cont.update();
                          },
                          child: !cont.showPassword
                              ? Icon(
                                  Icons.visibility,
                                  color: AppColors.appColor,
                                )
                              : Icon(
                                  Icons.visibility_off,
                                  color: AppColors.appColor,
                                )),
                      hintText: "Password"),
                );
              }),
              SizedBox(
                height: Get.height * 0.02,
              ),
              GetBuilder<SplashController>(builder: (cont) {
                return TextFormField(
                  controller: cont.confirmPasswordCtrl,
                  obscureText: cont.showPassword,
                  decoration: InputDecoration(
                      prefixIcon: SizedBox(
                          height: Get.height * 0.02,
                          width: Get.width * 0.03,
                          child: Padding(
                            padding: const EdgeInsets.all(11.0),
                            child: Image.asset(
                              AppImages.lockIcon,
                              fit: BoxFit.contain,
                            ),
                          )),
                      suffix: InkWell(
                          onTap: () {
                            cont.showPassword = !cont.showPassword;
                            cont.update();
                          },
                          child: !cont.showPassword
                              ? Icon(
                                  Icons.visibility,
                                  color: AppColors.appColor,
                                )
                              : Icon(
                                  Icons.visibility_off,
                                  color: AppColors.appColor,
                                )),
                      hintText: "Password"),
                );
              }),
              SizedBox(
                height: Get.height * 0.05,
              ),
              GetBuilder<SplashController>(builder: (controller) {
                return ElevatedButtonW(
                  buttonText: "Confirm",
                  onTap: () {
                    controller.resetPassword(context);
                    //Get.toNamed(Routes.signIn);
                  },
                  isLoading: controller.postingData,
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
