import 'package:flutter/material.dart';
import 'package:my_board/core/values/constants.dart';
import 'package:my_board/imports.dart';

class CardChnagedSucessfully extends StatelessWidget {
  const CardChnagedSucessfully({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                height: Get.height * 0.25,
                child: Image.asset(AppImages.congratulation)),
            Text(
              "Congratulations",
              style: TextStyles.text2,
            ),
            SizedBox(
              height: Get.height * 0.01,
            ),
            Text(
              "Your card has been changed",
              style:
                  TextStyles.smallText!.copyWith(fontWeight: FontWeight.w200),
            ),
            SizedBox(
              height: Get.height * 0.04,
            ),
            ElevatedButton(
              onPressed: () {
                Get.offNamed(Routes.dashboard);
              },
              child: const Text("Back to Home"),
            )
          ],
        ),
      ),
    );
  }
}
