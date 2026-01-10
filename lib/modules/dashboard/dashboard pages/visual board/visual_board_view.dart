import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_board/core/theme/text_theme.dart';
import 'package:my_board/modules/dashboard/dashboard%20pages/visual%20board/visualBoardDetail.dart';
import 'package:my_board/modules/dashboard/dashboard%20pages/visual%20board/visual_board_controller.dart';

import '../../../../data/models/visual_board_model.dart';
import '../../../../imports.dart';

class VisualBoardView extends GetView<VisualBoardController> {
  const VisualBoardView({super.key});

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
        title: Text("Visual Board"),
      ),
      bottomNavigationBar: CommonBottomNav(currentModule: 'visual'),
      body: SafeArea(
        child: GetBuilder<VisualBoardController>(
          builder: (cont) {
            print('VISUAL BOARD VIEW: Building with dataLoading: ${cont.dataLoading}');

            if (cont.dataLoading) {
              print('VISUAL BOARD VIEW: Showing loading indicator');
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(AppColors.appColor),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Loading visual board data...',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              );
            }

            print('VISUAL BOARD VIEW: Showing content');
            return SingleChildScrollView(
              child: Column(
                children: [
                  _buildSection("Short Term Goals", controller.visualBoardData.shortTermGoal),
                  _buildSection("Long Term Goals", controller.visualBoardData.longTermGoal),
                  _buildSection("Capabilities", controller.visualBoardData.capability),
                  _buildSection("Role Models", controller.visualBoardData.roleModel),
                  _buildSection("Visual Representations", controller.visualBoardData.visualRepresentation),
                  SizedBox(height: 20), // Add bottom padding
                ],
              ),
            );
          }
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
                        Get.to(VisualDetailView());
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
