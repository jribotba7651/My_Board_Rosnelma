// ignore_for_file: prefer_const_constructors

import 'package:my_board/modules/profile/profile_controller.dart';
import 'package:my_board/widget/custom_appbar_widget.dart';
import '../../imports.dart';
import '../../widget/my_upcomming_session_card.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GetBuilder<ProfileController>(builder: (controller) {
          if (controller.dataLoading) {
            return LoadingAnimation();
          } else {
            return Column(
              children: [
                Container(
                  color: Colors.white,
                  child: CustomAppBar(
                    text: "Profile",
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      color: Colors.white,
                      height: Get.height * 0.25,
                      child: Center(
                        child: Column(
                          children: [
                            CircleAvatar(
                                radius: Get.height * 0.06,
                                backgroundColor: Color(0xFFFFD88D),
                                child: Center(
                                    child: Image.asset(
                                        "assets/images/person.png"))),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              controller.userName,
                              style: TextStyles.text3,
                            ),
                            Text(
                              controller.email,
                              style: TextStyles.smallText!
                                  .copyWith(color: Colors.grey, fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              Text(
                                "My Sessions",
                                style: TextStyles.text3,
                              ),
                            ],
                          ),
                        )),
                    
                  ],
                )
              ],
            );
          }
        }),
      ),
    );
  }
}
