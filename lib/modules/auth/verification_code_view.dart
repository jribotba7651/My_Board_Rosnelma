// ignore_for_file: must_be_immutable

import 'package:my_board/imports.dart';
import 'package:my_board/widget/custom_textfields.dart';

import 'auth_controller.dart';

class VerificationCodeView extends StatelessWidget {
  const VerificationCodeView({super.key});

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
                "Enter Verification Code",
                style: TextStyles.h1,
                textAlign: TextAlign.center,
              ),
              Text(
                "Code Sent To Phone 03105499844",
                style: TextStyles.smallText,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: Get.height * 0.05,
              ),
              AppTextField(
                  controller: Get.find<SplashController>().codeCtrl,
                  image: AppImages.callIcon,
                  hintText: "Verification Code",
                  isShowLeading: false,
                  textInputType: TextInputType.phone),

              GetBuilder<SplashController>(builder: (controller) {
                return ElevatedButtonW(
                  buttonText: "Verify",
                  onTap: () {
                    controller.verifyCode(context);
                    // Get.toNamed(Routes.changePassword);
                  },
                  isLoading: controller.postingData,
                );
              }),
              SizedBox(
                height: Get.height * 0.015,
              ),

              InkWell(
                onTap: () {
                  Get.toNamed(Routes.forgotPassword);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "If you didn’t receive a code, ",
                      style: TextStyles.smallText2,
                    ),
                    Text(
                      "Resend",
                      style: TextStyles.smallText2!
                          .copyWith(color: AppColors.appColor),
                    )
                  ],
                ),
              ),

              SizedBox(
                height: Get.height * 0.28,
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
