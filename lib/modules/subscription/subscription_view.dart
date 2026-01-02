import 'package:my_board/modules/subscription/subsciption_controller.dart';
import 'package:my_board/widget/loading_animation.dart';
import '../../imports.dart';
import '../../widget/custom_appbar_widget.dart';

class SubscriptionView extends GetView<SubscriptionController> {
  const SubscriptionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(10.0),
          child: GetBuilder<SubscriptionController>(builder: (controller) {
            return controller.loading
                ? const SizedBox()
                : ElevatedButtonW(
                    onTap: () {
                      Get.toNamed(Routes.changeCard);
                      // if (controller.currentUser.isSubscriber!) {
                      //   return showDialogue(
                      //     title: "Cancel Membership",
                      //     subtitle:
                      //         " Are you sure wants to cancelyour membership!",
                      //     context: context,
                      //     button1: ElevatedButtonW(
                      //         onTap: () {
                      //           Get.back();
                      //         },
                      //         buttonText: "No Back Off"),
                      //     button2: ElevatedButtonW(
                      //       buttonText: "Cancel Membership",
                      //       onTap: () {
                      //         Get.find<SubscriptionController>()
                      //             .cancelMembership(context);
                      //       },
                      //       buttonColor: const Color(0xFFFFE5E5),
                      //       buttonTextColor: Colors.black,
                      //     ),
                      //   );
                      // } else {
                      //   return customDialogue2(
                      //     image: AppImages.subscriptionReward,
                      //     title: "Become a Pro member",
                      //     subtitle:
                      //         "Unlock the power of membership! Create and join sessions, earn rewards, and elevate your trivia experience as a Pro member",
                      //     context: context,
                      //     button1: ElevatedButtonW(
                      //         onTap: () {
                      //           Get.toNamed(Routes.changeCard);
                      //         },
                      //         buttonText: "Become a member"),
                      //     button2: ElevatedButtonW(
                      //       buttonText: "Not Interested",
                      //       onTap: () {
                      //         Get.back();
                      //       },
                      //       buttonColor: const Color(0xFFFFF5E7),
                      //       buttonTextColor: Colors.black,
                      //     ),
                      //   );
                      // }
                    },
                    buttonText: controller.currentUser.isSubscriber!
                        ? "Cancel Membership"
                        : "Become a member",
                    buttonColor: controller.currentUser.isSubscriber!
                        ? const Color(0xFFFFE5E5)
                        : AppColors.appColor,
                    buttonTextColor: controller.currentUser.isSubscriber!
                        ? const Color(0xFFFF2C2C)
                        : Colors.white);
          })),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: GetBuilder<SubscriptionController>(builder: (controller) {
            return controller.loading
                ? const LoadingAnimation()
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomAppBar(
                        text: "Subscription",
                      ),
                      SizedBox(
                        height: Get.height * 0.02,
                      ),
                      SizedBox(
                        height: Get.height * 0.15,
                        child: Image.asset(AppImages.subscriptionReward),
                      ),
                      SizedBox(
                        height: Get.height * 0.01,
                      ),
                      Text(
                        controller.currentUser.isSubscriber!
                            ? "You are a Pro Member"
                            : "You are a free Member",
                        style: TextStyles.text3,
                      ),
                      SizedBox(
                        height: Get.height * 0.02,
                      ),
                      Container(
                        height: Get.height * 0.07,
                        width: Get.width * 0.5,
                        decoration: BoxDecoration(
                            color: const Color(0xFFFFF5E7),
                            borderRadius: BorderRadius.circular(5.0)),
                        child: Center(
                          child: Text(
                            "10\$ Per Month",
                            style: TextStyles.text3!
                                .copyWith(color: const Color(0xFFFF9811)),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: Get.height * 0.01,
                      ),
                      Text(
                        controller.currentUser.isSubscriber!
                            ? "Subscriber"
                            : "Non Subscriber",
                        style: TextStyles.text3!.copyWith(fontSize: 14),
                      ),
                      SizedBox(
                        height: Get.height * 0.02,
                      ),
                      const Divider(
                        thickness: 0.5,
                      ),
                      SizedBox(
                        height: Get.height * 0.03,
                      ),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Card",
                                style: TextStyles.text3!.copyWith(fontSize: 14),
                              ),
                              InkWell(
                                onTap: () {
                                  Get.toNamed(Routes.changeCard);
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 5.0, horizontal: 12.0),
                                  decoration: BoxDecoration(
                                      color: AppColors.appColor,
                                      borderRadius:
                                          BorderRadius.circular(20.0)),
                                  child: Text(
                                    "Change Card",
                                    style: TextStyles.text3!.copyWith(
                                        fontSize: 12, color: Colors.white),
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: Get.height * 0.03,
                          ),
                          Container(
                            height: Get.height * 0.1,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                color: const Color(0xFFEDEDFF),
                                borderRadius: BorderRadius.circular(8.0)),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "User Name",
                                    style: TextStyles.text3!.copyWith(
                                        fontSize: 16,
                                        color: AppColors.appColor),
                                  ),
                                  Text(
                                    "XXXX 1234 5678 9012",
                                    style: TextStyles.text3!
                                        .copyWith(fontSize: 18),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  );
          }),
        ),
      ),
    );
  }

  showDialogue({title, subtitle, button1, button2, context}) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            elevation: 0,
            backgroundColor: Colors.transparent,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              height: Get.height / 2.5,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Title
                  Text(title, style: TextStyles.h2),
                  const SizedBox(height: 10),
                  // Subtitle
                  Text(
                    subtitle,
                    style: TextStyles.smallText!
                        .copyWith(fontSize: 12, color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  // Button 1
                  button1,
                  const SizedBox(height: 10),
                  // Button 2
                  button2
                ],
              ),
            ),
          );
        });
  }

  customDialogue2({image, title, subtitle, button1, button2, context}) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            elevation: 0,
            backgroundColor: Colors.transparent,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              height: Get.height / 1.8,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Picture
                  Image.asset(
                    image,
                    height: 100,
                    width: 100,
                  ),
                  const SizedBox(height: 20),
                  // Title
                  Text(title, style: TextStyles.h2),
                  const SizedBox(height: 10),

                  Container(
                    height: Get.height * 0.05,
                    width: Get.width * 0.4,
                    decoration: BoxDecoration(
                        color: const Color(0xFFFFF5E7),
                        borderRadius: BorderRadius.circular(5.0)),
                    child: Center(
                      child: Text(
                        "10\$ Per Month",
                        style: TextStyles.text3!
                            .copyWith(color: const Color(0xFFFF9811)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Subtitle
                  Text(
                    subtitle,
                    style: TextStyles.smallText!
                        .copyWith(fontSize: 12, color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  // Button 1
                  button1,
                  const SizedBox(height: 10),
                  // Button 2
                  button2
                ],
              ),
            ),
          );
        });
  }
}
