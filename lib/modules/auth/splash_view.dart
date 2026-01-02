// ignore_for_file: prefer_const_constructors

import 'package:my_board/imports.dart';

class SplashView extends StatelessWidget {
  const SplashView({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            // Background image with darkness overlay
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AppImages.bgImage),
                  fit: BoxFit.fill,
                ),
              ),
              // Darkness overlay
              foregroundDecoration: BoxDecoration(
                color: Colors.black.withOpacity(0.3),
              ),
            ),
            // Content
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: Get.height * 0.35,
                ),
                CircleAvatar(
                  radius: Get.height * 0.1,
                  backgroundColor: const Color(0xFFB9D4D6),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Image.asset(AppImages.mainLogo),
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.03,
                ),
                Text(
                  "Welcome to",
                  style: TextStyles.text4White,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: Get.height * 0.01,
                ),
                Text(
                  "My Board",
                  style: TextStyles.h2!.copyWith(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: ElevatedButtonW(
                    onTap: () {
                      Get.toNamed(Routes.instrction);
                    },
                    buttonText: "Continue",
                    buttonColor: AppColors.scaffold,
                    buttonTextColor: AppColors.appColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
