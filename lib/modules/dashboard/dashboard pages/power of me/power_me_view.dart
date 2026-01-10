import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_board/core/theme/text_theme.dart';
import 'package:my_board/modules/dashboard/dashboard%20pages/power%20of%20me/power_me_controller.dart';
import 'package:my_board/modules/dashboard/dashboard%20pages/visual%20board/visualBoardDetail.dart';
import 'package:my_board/modules/dashboard/dashboard%20pages/visual%20board/visual_board_controller.dart';

import '../../../../data/models/visual_board_model.dart';
import '../../../../imports.dart';
import 'powerme_detail.dart';

class PowerMeView extends GetView<PowerMeController> {
  const PowerMeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffold2,
      appBar: AppBar(
        backgroundColor: AppColors.appColor,
        leading: InkWell(
          onTap: (){
            Get.back();
          },
          child: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
          ),
        ),
        title: Text("PowerMe Board"),
      ),
      bottomNavigationBar: CommonBottomNav(currentModule: 'power'),
      body: SafeArea(
        child: SingleChildScrollView(
          child: GetBuilder<PowerMeController>(
            builder: (cont) {
              return Column(
                children: [
                  _buildSection("Short Term Goals", controller.visualBoardData.shortTermGoal),
                  _buildSection("Long Term Goals", controller.visualBoardData.longTermGoal),
                  _buildSection("Capabilities", controller.visualBoardData.capability),
                  _buildSection("Missions", controller.visualBoardData.mission),
                  _buildSection("Passions", controller.visualBoardData.passion),
                  _buildSection("Personal Goals", controller.visualBoardData.personalGoal), _buildSection("Professions", controller.visualBoardData.profession),
                  _buildSection("Role Models", controller.visualBoardData.roleModel),
                  _buildSection("Visual Representations", controller.visualBoardData.visualRepresentation),
                //  _buildSection("Vocations", controller.visualBoardData.vocation),

                ],
              );
            }
          ),
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<Detail>? details) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: Row(
            children: [
              Expanded(child: Divider(thickness: 1.1)),
              SizedBox(width: 10),
              Text(title, style: TextStyles.text3),
              SizedBox(width: 10),
              Expanded(child: Divider(thickness: 1.1)),
            ],
          ),
        ),
        details == null || details.isEmpty
            ? Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Text(
                  "No goals added in this category",
                  style: TextStyles.smallText3,
                ),
              )
            : SizedBox(
                //height: 200,
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: details.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: (){
                        controller.selectedDeatilGoal=details[index];
                        Get.to(PowerMeDetailView());
                      },
                      child: Container(
                        padding: EdgeInsets.all(12.0),
                        margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              details[index].title ?? "",
                              style: TextStyles.smallText,
                            ),
                            SizedBox(height: 8),
                            Text(
                              details[index].description ?? "",
                              style: TextStyles.smallText3,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
      ],
    );
  }
}
