import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/values/form_validator_constant.dart';
import '../../../../imports.dart';
import 'package:intl/intl.dart';

import 'family_tree_controller.dart';

class AddFamilyTreeView extends GetView<FamilyTreeController> {
  const AddFamilyTreeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: GetBuilder<FamilyTreeController>(builder: (cont) {
        return Container(
          height: Get.height * 0.10,
          color: Colors.white,
          child: Center(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: ElevatedButtonW(
                buttonText: "ADD",
                isLoading: cont.postingData,
                onTap: () {
                  cont.addFamilyMember(context);
                }),
          )),
        );
      }),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: Get.height * 0.06,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(bottom: BorderSide(width: 0.1))),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          InkWell(
                              onTap: () {
                                Get.back();
                              },
                              child: Icon(Icons.arrow_back_ios)),
                          Text(
                            "Add Person",
                            style: TextStyles.text3,
                          ),
                          Text("")
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    Align(
                      child: CircleAvatar(
                        radius: Get.height * 0.06,
                        backgroundColor: AppColors.lightGreen,
                        child: Icon(
                          Icons.person_3_rounded,
                          size: Get.height * 0.08,
                          color: AppColors.appColor,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    Text(
                      "First Name",
                      style: TextStyles.text3,
                    ),
                    SizedBox(
                      height: Get.height * 0.01,
                    ),
                    TextFormField(
                      controller: controller.fnameCtrl,
                      validator: FormValidatorConstant.commonValidator,
                      decoration: InputDecoration(hintText: "First Name"),
                    ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    Text(
                      "Last Name",
                      style: TextStyles.text3,
                    ),
                    SizedBox(
                      height: Get.height * 0.01,
                    ),
                    TextFormField(
                      controller: controller.lnameCtrl,
                      validator: FormValidatorConstant.commonValidator,
                      decoration: InputDecoration(hintText: "Last Name"),
                    ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    Text(
                      "Date of Birth",
                      style: TextStyles.text3,
                    ),
                    SizedBox(
                      height: Get.height * 0.01,
                    ),
                    TextFormField(
                      controller: controller.dobCtrl,
                      readOnly: true,
                      decoration: InputDecoration(
                        suffixIcon: Icon(Icons.calendar_today),
                        hintText: "Date of Birth",
                      ),
                      onTap: () => selectDOB(context),
                    ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    Text(
                      "Relation",
                      style: TextStyles.text3,
                    ),
                    SizedBox(
                      height: Get.height * 0.01,
                    ),
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Select Relation",
                      ),
                      items: controller.relations
                          .map((relation) => DropdownMenuItem<String>(
                                value: relation,
                                child: Text(relation),
                              ))
                          .toList(),
                      onChanged: (value) {
                        controller.selectedRelation = value!.toLowerCase();
                      },
                      validator: (value) =>
                          value == null ? "Please select a relation" : null,
                    ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Is person alive",
                          style: TextStyles.text3,
                        ),
                        GetBuilder<FamilyTreeController>(builder: (controller) {
                          return Switch(
                            value: controller.islive,
                            activeColor: AppColors.appColor,
                            onChanged: (value) {
                              controller.changeLive(value);
                            },
                          );
                        }),
                      ],
                    ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    GetBuilder<FamilyTreeController>(builder: (controller) {
                      return controller.islive == true
                          ? SizedBox()
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Date of Death",
                                  style: TextStyles.text3,
                                ),
                                SizedBox(
                                  height: Get.height * 0.01,
                                ),
                                TextFormField(
                                  controller: controller.dodCtrl,
                                  readOnly: true,
                                  decoration: InputDecoration(
                                    suffixIcon: Icon(Icons.calendar_today),
                                    hintText: "Date of Death",
                                  ),
                                  onTap: () => selectDOD(context),
                                ),
                              ],
                            );
                    })
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> selectDOB(BuildContext context) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (selectedDate != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
      controller.dobCtrl.text = formattedDate;
    }
  }

  Future<void> selectDOD(BuildContext context) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (selectedDate != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
      controller.dodCtrl.text = formattedDate;
    }
  }
}
