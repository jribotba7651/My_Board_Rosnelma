import 'package:my_board/imports.dart';

class InstructionView extends StatelessWidget {
  const InstructionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Trivia',
                style: TextStyles.text3White,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: Get.height * 0.3,
              ),
              CircleAvatar(
                  radius: Get.height * 0.06,
                  backgroundColor: const Color(0xFFB9D4D6),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Image.asset(AppImages.mainLogo),
                  )),
              SizedBox(
                height: Get.height * 0.03,
              ),
              Text(
                "My Board",
                style: TextStyles.h2,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: Get.height * 0.01,
              ),
              Text(
                "Discover the power of connection with My Board Appl Dive into a world of diverse boards for personal and family use. Our free package invites you to explore the app's unique vatue Create a Family Tree to uncover and share your ancestry during special family gatherings. Upgrade to unlimited access and share life's moments, dreams, and goals with loved ones. Plus, craft storyboards to capture your experiences, visualize dreams , or narrate family history to your children. Embrace the full experience with My Board App today.",
                style:
                    TextStyles.smallText!.copyWith(height: 1.3, fontSize: 13.0),
                textAlign: TextAlign.justify,
              ),
              const Spacer(),
              ElevatedButtonW(
                onTap: () {
                  Get.toNamed(Routes.signIn);
                },
                buttonText: "Continue",
                buttonColor: AppColors.appColor,
                buttonTextColor: AppColors.whiteColor,
              )
            ],
          ),
        ),
      ),
    );
  }
}
