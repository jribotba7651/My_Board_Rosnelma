// ignore_for_file: prefer_const_constructors

import 'package:my_board/imports.dart';

selectImageDialogue(
    BuildContext context, Function fromCamera, Function fromGallery) {
  return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: Get.height * 0.22,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadiusDirectional.only(
              topStart: Radius.circular(12.0),
              topEnd: Radius.circular(12.0),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                ElevatedButtonW(
                  buttonText: "Select From Camera",
                  buttonColor: Color(0xFFD6F6FB),
                  buttonTextColor: Color(0xFF177D8C),
                  onTap: () {
                    fromCamera();
                  },
                ),
                SizedBox(height: Get.height * 0.02),
                ElevatedButtonW(
                  buttonText: "Select From Gallery",
                  buttonColor: Color(0xFFD6F6FB),
                  buttonTextColor: Color(0xFF177D8C),
                  onTap: () {
                    fromGallery();
                  },
                )
              ],
            ),
          ),
        );
      });
}
