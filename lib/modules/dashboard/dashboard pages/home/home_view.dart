// ignore_for_file: prefer_const_constructors

import 'package:flutter/services.dart';
import 'package:my_board/global_controllers/global_controller.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/storage.dart';
import '../../../../imports.dart';
import 'home_controller.dart';

class HomeView extends GetView<DashBoardHomeController> {
  const HomeView({Key? key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        drawer: customDrawer(context),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniCenterTop,
        body: Container(
          height: Get.height,
          width: Get.width,
          child: Stack(
            children: [
              // Background image
              Container(
                height: Get.height,
                width: Get.width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(AppImages.bgImage),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // Darkness overlay
              Container(
                height: Get.height,
                width: Get.width,
                color:
                    Colors.black.withOpacity(0.25), // Adjust opacity as needed
              ),
              // Other content
              SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Builder(
                            builder: (context) => InkWell(
                              onTap: () {
                                Scaffold.of(context).openDrawer();
                              },
                              child: Icon(
                                Icons.menu,
                                size: Get.height * 0.035,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Text(
                            "My Board",
                            style: TextStyles.text3White,
                            textAlign: TextAlign.center,
                          ),
                          Text(""),
                        ],
                      ),
                    ),
                    const Divider(
                      color: Colors.white,
                      thickness: 1.1,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Welcome",
                            style: TextStyles.text4White,
                            textAlign: TextAlign.center,
                          ),
                          GetBuilder<DashBoardHomeController>(builder: (cont) {
                            return Text(
                              "${Get.find<GlobalController>().currentUser.firstName.toString()} ${Get.find<GlobalController>().currentUser.lastName.toString()}",
                              style:
                                  TextStyles.h2!.copyWith(color: Colors.white),
                              textAlign: TextAlign.center,
                            );
                          }),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        gridCard(
                            image: AppImages.lkigaiBoard,
                            text: 'Ikigai Board',
                            type: 'lkigaiBoard'),
                        gridCard(
                            image: AppImages.taskBoard,
                            text: 'Task Board',
                            type: 'taskBoard'),
                      ],
                    ),
                    Row(
                      children: [
                        gridCard(
                            image: AppImages.powerMeBoard,
                            text: 'Power of me',
                            type: 'powerMe'),
                        gridCard(
                            image: AppImages.storyBoard,
                            text: 'Story board',
                            type: 'storyBoard'),
                      ],
                    ),
                    Row(
                      children: [
                        gridCard(
                            image: AppImages.familyTreeeBoard,
                            text: 'Family Tree',
                            type: 'familyTree'),
                        gridCard(
                            image: AppImages.visualBoard,
                            text: 'Visual Board',
                            type: 'visualBoard'),
                      ],
                    ),
                    Row(
                      children: [
                        gridCard(
                            image: '🔮',
                            text: 'Quantum Deck',
                            type: 'quantumDeck'),
                        Expanded(child: Container()), // Empty space for now
                      ],
                    ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: Padding(
          padding: EdgeInsets.only(
              left: 15.0, right: 15.0, bottom: Get.height * 0.04),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButtonW(
                onTap: () {
                  shareBottomSheet(context, 123235);
                },
                buttonText: "Share App and earn board",
                buttonColor: AppColors.appColor,
                buttonTextColor: AppColors.whiteColor,
              ),
              SizedBox(height: Get.height * 0.01),
              ElevatedButtonW(
                onTap: () {
                  Get.toNamed(Routes.changeCard);
                },
                buttonText: "Become a member",
                buttonColor: AppColors.appColor,
                buttonTextColor: AppColors.whiteColor,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Your gridCard function remains unchanged
  gridCard({image, text, type}) {
    return Expanded(
      child: InkWell(
        onTap: () {
          if (type == "lkigaiBoard") {
            Get.toNamed(Routes.lkigaiBoard);
          }
          if (type == "taskBoard") {
            Get.toNamed(Routes.taskBoard);
          }
          if (type == "powerMe") {
            Get.toNamed(Routes.powerMe);
          }
          if (type == "visualBoard") {
            Get.toNamed(Routes.visualBoard);
          }
          if (type == "storyBoard") {
            Get.toNamed(Routes.storyBoard);
          }
          if (type == "familyTree") {
            Get.toNamed(Routes.familyTree);
          }
          if (type == "quantumDeck") {
            Get.toNamed(Routes.quantumDeck);
          }
        },
        child: Container(
          // height: Get.height * 0.25,
          margin: const EdgeInsets.all(8.0),
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          decoration: BoxDecoration(
              color: AppColors.appColor,
              borderRadius: BorderRadius.circular(8.0)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                  radius: Get.height * 0.07,
                  backgroundColor: type == "quantumDeck"
                      ? const Color(0xFF008B8B).withOpacity(0.2)
                      : const Color(0xFFB9D4D6),
                  child: Padding(
                    padding: const EdgeInsets.all(7.0),
                    child: type == "quantumDeck"
                        ? Text(
                            image,
                            style: TextStyle(fontSize: Get.height * 0.05),
                          )
                        : Image.asset(image),
                  )),
              SizedBox(
                height: Get.height * 0.015,
              ),
              Text(
                text,
                style: TextStyles.text4White!
                    .copyWith(fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  shareBottomSheet(BuildContext context, int code) {
    return showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: Get.height * 0.28,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadiusDirectional.only(
                  topStart: Radius.circular(12.0),
                  topEnd: Radius.circular(12.0),
                )),
            child: Column(
              children: [
                SizedBox(
                  width: 100,
                  child: Divider(
                    color: AppColors.appColor,
                    thickness: 2.5,
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.015,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    "Share MyBoard App and earn 2 boards in each.",
                    style: TextStyles.smallText!
                        .copyWith(color: AppColors.appColor),
                    textAlign: TextAlign.start,
                  ),
                ),
                Divider(
                  color: Color(0xFFBBBBBB),
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Share to",
                          style: TextStyles.text3,
                        ),
                      ),
                      SizedBox(
                        height: Get.height * 0.02,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          shareCircle(
                              image: AppImages.share,
                              text: 'Copy Link',
                              ontap: () {
                                String link =
                                    "https://play.google.com/store/apps/details?id=com.five_star_solution.my_board_app&hl=en&gl=US";
                                String dynamicText =
                                    'Download MyBoard App and Signup using this refferal code ${Get.find<DashBoardHomeController>().currentUser?.referralCode.toString()} Downlaod app using link:  $link';

                                Clipboard.setData(
                                    ClipboardData(text: "$dynamicText"));
                              }),
                          shareCircle(
                              image: AppImages.whatsapp,
                              text: 'Whats App',
                              ontap: () async {
                                String link =
                                    "https://play.google.com/store/apps/details?id=com.five_star_solution.my_board_app&hl=en&gl=US";
                                String dynamicText =
                                    'Download MyBoard App and Signup using this refferal code ${Get.find<DashBoardHomeController>().currentUser?.referralCode.toString()} Downlaod app using link:  $link';
                                String encodedText =
                                    Uri.encodeFull(dynamicText);

                                String url = 'https://wa.me/?text=$encodedText';

                                if (await canLaunch(url)) {
                                  await launch(url);
                                } else {
                                  throw 'Could not launch $url';
                                }
                              }),
                          shareCircle(
                              image: AppImages.insta,
                              text: 'Instagram',
                              ontap: () async {
                                String link =
                                    "https://play.google.com/store/apps/details?id=com.five_star_solution.my_board_app&hl=en&gl=US";
                                String dynamicText =
                                    'Download MyBoard App and Signup using this refferal code ${Get.find<DashBoardHomeController>().currentUser?.referralCode.toString()} Downlaod app using link:  $link';
                                String url =
                                    'https://www.instagram.com/?url=${Uri.encodeFull(dynamicText)}';

                                if (await canLaunch(url)) {
                                  await launch(url);
                                } else {
                                  throw 'Could not launch $url';
                                }
                              }),
                          shareCircle(
                              image: AppImages.messenger,
                              text: 'Messenger',
                              ontap: () async {
                                String link =
                                    "https://play.google.com/store/apps/details?id=com.five_star_solution.my_board_app&hl=en&gl=US";
                                String dynamicText =
                                    'Download MyBoard App and Signup using this refferal code ${Get.find<DashBoardHomeController>().currentUser?.referralCode.toString()} Downlaod app using link:  $link';
                                String url =
                                    'https://www.facebook.com/dialog/send?link=${Uri.encodeFull(dynamicText)}';

                                if (await canLaunch(url)) {
                                  await launch(url);
                                } else {
                                  throw 'Could not launch $url';
                                }
                              })
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }

  shareCircle({image, text, ontap}) {
    return InkWell(
      onTap: ontap,
      child: Column(
        children: [
          SizedBox(
            height: Get.height * 0.07,
            width: Get.height * 0.07,
            child: Image.asset(image),
          ),
          SizedBox(
            height: Get.height * 0.005,
          ),
          Text(
            text,
            style: TextStyles.smallText3!
                .copyWith(color: Colors.black, fontWeight: FontWeight.w300),
          ),
        ],
      ),
    );
  }

  Drawer customDrawer(BuildContext context) {
    return Drawer(
      child: Column(
        //padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: InkWell(
                onTap: () {
                //  Get.toNamed(Routes.profile);
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                        radius: Get.height * 0.04,
                        backgroundColor: Color(0xFFFFD88D),
                        child: Center(
                            child: Image.asset("assets/images/person.png"))),
                    SizedBox(
                      width: 10,
                    ),
                    GetBuilder<DashBoardHomeController>(builder: (cont) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${Get.find<GlobalController>().currentUser.firstName ?? ""} ${Get.find<GlobalController>().currentUser.lastName ?? ""}",
                            style: TextStyles.text3,
                          ),
                          Text(
                            Get.find<GlobalController>().currentUser.email ??
                                "No Email",
                            style: TextStyles.smallText!
                                .copyWith(color: Colors.grey, fontSize: 12),
                          ),
                          Text(
                            "Refferal Code: ${
                              Get.find<GlobalController>()
                                .currentUser
                                .referralCode
                                .toString()
                            }",
                            style: TextStyles.smallText!
                                .copyWith(color: Colors.grey, fontSize: 12),
                          )
                        ],
                      );
                    })
                  ],
                ),
              )),
          ListTile(
            onTap: () {
              Get.toNamed(Routes.subscription);
            },
            leading: Icon(
              Icons.workspace_premium_rounded,
              size: 30,
            ),
            title: Text("Subscription", style: TextStyles.text3),
          ),
          // ListTile(
          //   onTap: () {
          //     //   Get.toNamed(Routes.sessionsList);
          //   },
          //   leading: Icon(
          //     Icons.width_normal,
          //     size: 30,
          //   ),
          //   title: Text("Referral", style: TextStyles.text3),
          // ),
          Spacer(),
          InkWell(
            onTap: () {
              SharedPrefStorage.clearStorage();
              Get.offAllNamed(Routes.signIn);
            },
            child: Container(
              margin: EdgeInsets.all(10.0),
              padding: EdgeInsets.all(10.0),
              height: MediaQuery.of(context).size.height * 0.07,
              decoration: BoxDecoration(
                  color: Color(0XFFFFE5E5),
                  borderRadius: BorderRadius.circular(8.0)),
              child: Row(
                children: [
                  Icon(
                    Icons.logout,
                    size: 30,
                    color: Color(0xFFFF2C2C),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    "Logout",
                    style: TextStyles.text3!.copyWith(
                      color: Color(0xFFFF2C2C),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
