// ignore_for_file: must_be_immutable

import 'package:my_board/imports.dart';
import 'package:my_board/modules/auth/auth_controller.dart';

import '../../core/values/form_validator_constant.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  GlobalKey<FormState> signInGlobalKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var controller = Get.find<SplashController>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: Get.height * 0.02, horizontal: Get.height * 0.02),
          child: Form(
            key: signInGlobalKey,
            child: ListView(
              children: [
                SizedBox(
                  height: Get.height * 0.15,
                ),
                Text(
                  "Welcome Back",
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
                  controller: controller.emailCtrl,
                  validator: FormValidatorConstant.emailValidator,
                  decoration: InputDecoration(
                      prefixIcon: SizedBox(
                          height: Get.height * 0.02,
                          width: Get.width * 0.03,
                          child: Padding(
                            padding: const EdgeInsets.all(11.0),
                            child: Image.asset(
                              AppImages.callIcon,
                              fit: BoxFit.contain,
                            ),
                          )),
                      hintText: "Email"),
                ),

                SizedBox(
                  height: Get.height * 0.02,
                ),
                GetBuilder<SplashController>(builder: (cont) {
                  return TextFormField(
                    controller: controller.passwordCtrl,
                    obscureText: cont.showPassword,
                    validator: FormValidatorConstant.passwordValidatorForSignIn,
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
                InkWell(
                  onTap: () {
                    Get.toNamed(Routes.forgotPassword);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Forgot Password  ",
                        style: TextStyles.smallText2,
                      ),
                      Text(
                        "Reset",
                        style: TextStyles.smallText2!
                            .copyWith(color: AppColors.appColor),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                GetBuilder<SplashController>(builder: (controller) {
                  return ElevatedButtonW(
                    buttonText: "Login",
                    isLoading: controller.postingData,
                    onTap: () {
                      controller.loginUser(context, signInGlobalKey);
                    },
                  );
                }),
                AppleSignInButton(
                  text: "Continue With Apple",
                  ontap: () {
                    controller.appleSignIn(context);
                  },
                ),
                SocialButton(
                  image: AppImages.googleIcon,
                  text: "Continue With Google",
                  ontap: () {
                    controller.googleSignIn(context);
                  },
                ),
                SizedBox(
                  height: Get.height * 0.15,
                ),
                // const Spacer(),
                InkWell(
                  onTap: () {
                    Get.toNamed(Routes.signUp);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don’t have a account? ",
                        style: TextStyles.smallText2,
                      ),
                      Text(
                        "Register Now",
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
      ),
    );
  }
}

class SocialButton extends StatelessWidget {
  SocialButton(
      {super.key, required this.text, required this.image, this.ontap});

  String text;
  String image;
  Function? ontap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap != null ? () => ontap!() : null,
      borderRadius: BorderRadius.circular(8.0),
      child: Container(
        height: Get.height * 0.067,
        margin: EdgeInsets.only(top: Get.height * 0.02),
        decoration: BoxDecoration(
            color: const Color(0xFFF2F2F7),
            borderRadius: BorderRadius.circular(8.0)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: 30,
              child: SizedBox(
                  height: Get.height * 0.03,
                  width: Get.height * 0.03,
                  child: Image.asset(image)),
            ),
            Expanded(
              flex: 70,
              child: Text(
                text,
                style: TextStyles.smallText,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class AppleSignInButton extends StatelessWidget {
  AppleSignInButton({super.key, required this.text, this.ontap});

  String text;
  Function? ontap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap != null ? () => ontap!() : null,
      borderRadius: BorderRadius.circular(8.0),
      child: Container(
        height: Get.height * 0.067,
        margin: EdgeInsets.only(top: Get.height * 0.02),
        decoration: BoxDecoration(
            color: const Color(0xFFF2F2F7),
            borderRadius: BorderRadius.circular(8.0)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: 30,
              child: SizedBox(
                  height: Get.height * 0.03,
                  width: Get.height * 0.03,
                  child: Icon(
                    Icons.apple,
                    size: Get.height * 0.03,
                    color: Colors.black,
                  )),
            ),
            Expanded(
              flex: 70,
              child: Text(
                text,
                style: TextStyles.smallText,
              ),
            )
          ],
        ),
      ),
    );
  }
}
