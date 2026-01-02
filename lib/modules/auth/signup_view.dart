// ignore_for_file: must_be_immutable

import 'package:my_board/imports.dart';
import '../../core/values/form_validator_constant.dart';
import 'auth_controller.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  GlobalKey<FormState> signUpGlobalKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var controller = Get.find<SplashController>();

    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(15.0),
        child: InkWell(
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
                style:
                    TextStyles.smallText2!.copyWith(color: AppColors.appColor),
              )
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: Get.height * 0.02, horizontal: Get.height * 0.02),
          child: Form(
            key: signUpGlobalKey,
            child: ListView(
              children: [
                SizedBox(
                  height: Get.height * 0.04,
                ),
                Text(
                  "Sign up",
                  style: TextStyles.h1,
                  textAlign: TextAlign.center,
                ),
                Text(
                  "Please enter your details",
                  style: TextStyles.smallText,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: Get.height * 0.05,
                ),

                TextFormField(
                  controller: controller.firstNameCtrl,
                  validator: FormValidatorConstant.commonValidator,
                  decoration: const InputDecoration(hintText: "First Name"),
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),

                TextFormField(
                  controller: controller.lastNameCtrl,
                  validator: FormValidatorConstant.commonValidator,
                  decoration: const InputDecoration(hintText: "Last Name"),
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),

                TextFormField(
                  controller: controller.emailCtrl,
                  validator: FormValidatorConstant.emailValidator,
                  decoration: const InputDecoration(hintText: "Email"),
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),

                TextFormField(
                  controller: controller.ageCtrl,
                  keyboardType: TextInputType.number,
                  validator: FormValidatorConstant.commonValidator,
                  decoration: const InputDecoration(hintText: "Your Age"),
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),

                TextFormField(
                  controller: controller.passwordCtrl,
                  validator: FormValidatorConstant.passwordValidatorForSignUp,
                  decoration: const InputDecoration(hintText: "Password"),
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),

                TextFormField(
                  controller: controller.confirmPasswordCtrl,
                  validator: FormValidatorConstant.passwordValidatorForSignUp,
                  decoration:
                      const InputDecoration(hintText: "Confirm Password"),
                ),

                SizedBox(
                  height: Get.height * 0.02,
                ),

                TextFormField(
                  controller: controller.refCodeCtrl,
                  maxLength: 6,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      counterText: '', hintText: "Refferal Code (Optional)"),
                ),
                SizedBox(
                  height: Get.height * 0.01,
                ),
                //____________________________ Radio Buttons
                GetBuilder<SplashController>(builder: (cont) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Radio(
                          value: "Male",
                          groupValue: controller.gender,
                          activeColor: AppColors.appColor,
                          onChanged: (value) {
                            print(value);
                            controller.gender = value!;
                            controller.update();
                          }),
                      SizedBox(
                        width: Get.width * 0.01,
                      ),
                      Text(
                        "Male",
                        style: TextStyles.text3!,
                      ),
                      SizedBox(
                        width: Get.width * 0.1,
                      ),
                      Radio(
                          value: "Female",
                          groupValue: controller.gender,
                          activeColor: AppColors.appColor,
                          onChanged: (value) {
                            controller.gender = value!;
                            controller.update();
                          }),
                      SizedBox(
                        width: Get.width * 0.01,
                      ),
                      Text(
                        "Female",
                        style: TextStyles.text3,
                      ),
                    ],
                  );
                }),
                SizedBox(
                  height: Get.height * 0.01,
                ),

                GetBuilder<SplashController>(builder: (controller) {
                  return ElevatedButtonW(
                    buttonText: "Next",
                    onTap: () {
                      Get.find<SplashController>()
                          .registerNewUser(context, signUpGlobalKey);
                    },
                    isLoading: controller.postingData,
                  );
                }),

                // SizedBox(
                //   height: Get.height * 0.2,
                // ),
                //const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
