// ignore_for_file: avoid_print, deprecated_member_use

import 'dart:io';

import 'package:my_board/data/models/lkigai_model.dart';
import 'package:my_board/imports.dart';
import 'package:my_board/core/values/show.dart';
import 'package:rich_editor/rich_editor.dart';

import '../../../../core/api_service.dart';
import '../../../../core/values/api_constant.dart';

class LkigaiBoardController extends GetxController {
  GlobalKey<RichEditorState> keyEditor = GlobalKey();
  LkigaiModel selectedLkigai = LkigaiModel();

  String selectedType = "";
  File? imageFile;
  //String? image = '';
  List<String> imageList = [];
  List<File> imageLocalPathList = [];
  bool postingData = false;
  bool dataLoading = true;
  bool isImageUploading = false;

  TextEditingController titleCtrl = TextEditingController();
  TextEditingController descriptionCtrl = TextEditingController();

  //___________________________ Select Image From Gallery
  selectImage(ImageSource source, String type) async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(
        source: source,
        maxWidth: 1800,
        maxHeight: 1800,
        imageQuality: 85,
      );

      if (pickedFile != null) {
        imageFile = File(pickedFile.path);
        imageLocalPathList.add(imageFile!);
        Get.back();
        isImageUploading = true;
        update();

        String path = await APIService().uploadSingleFile(imageFile!.path);

        if (type == "file") {
          if (path.isNotEmpty) {
            imageList.add(path);
            isImageUploading = false;
            update();
            Get.snackbar(
              'Success',
              'Image uploaded successfully',
              backgroundColor: Color(0xFF008B8B),
              colorText: Colors.white,
              snackPosition: SnackPosition.BOTTOM,
              duration: Duration(seconds: 2),
            );
          } else {
            isImageUploading = false;
            update();
            Get.snackbar(
              'Error',
              'Failed to upload image',
              backgroundColor: Colors.red,
              colorText: Colors.white,
            );
          }
        } else {
          if (path.isNotEmpty) {
            selectedLkigai.image!.add(path);
            isImageUploading = false;
            update();
            Get.snackbar(
              'Success',
              'Image uploaded successfully',
              backgroundColor: Color(0xFF008B8B),
              colorText: Colors.white,
              snackPosition: SnackPosition.BOTTOM,
              duration: Duration(seconds: 2),
            );
          } else {
            isImageUploading = false;
            update();
            Get.snackbar(
              'Error',
              'Failed to upload image',
              backgroundColor: Colors.red,
              colorText: Colors.white,
            );
          }
        }
      } else {
        isImageUploading = false;
        update();
        print('No image selected.');
      }
    } catch (e) {
      isImageUploading = false;
      update();
      print('Error selecting image: $e');
      Get.snackbar(
        'Error',
        'Failed to select image: ${e.toString()}',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 3),
      );
    }
  }

  ///_________________________________ SUBMIT LKIGAI
  submitLkigai(BuildContext context) async {
    try {
      // Validate all required fields
      if (titleCtrl.text.trim().isEmpty) {
        Get.snackbar(
          'Validation Error',
          'Please add a title',
          backgroundColor: Colors.orange,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }

      if (descriptionCtrl.text.trim().isEmpty) {
        Get.snackbar(
          'Validation Error',
          'Please add a description',
          backgroundColor: Colors.orange,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }

      if (imageList.isEmpty) {
        Get.snackbar(
          'Validation Error',
          'Please select at least one image',
          backgroundColor: Colors.orange,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }

      if (isImageUploading == true) {
        Get.snackbar(
          'Please Wait',
          'Image is still uploading. Please wait...',
          backgroundColor: Colors.blue,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }

      // Show loading dialog
      Get.dialog(
        Center(
          child: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(color: Color(0xFF008B8B)),
                SizedBox(height: 16),
                Text('Creating Ikigai...'),
              ],
            ),
          ),
        ),
        barrierDismissible: false,
      );

      var body = {
        "title": titleCtrl.text.trim(),
        "description": descriptionCtrl.text.trim(),
        "image": imageList
      };

      print("Creating Ikigai with ${imageList.length} images");

      postingData = true;
      update();

      bool result = await APIService().postDataWithAPI(
        url: "${EndPoint.addLkigai}${selectedType.toLowerCase()}",
        data: body,
        context: context
      );

      postingData = false;
      update();

      // Close loading dialog
      if (Get.isDialogOpen == true) {
        Get.back();
      }

      if (result) {
        // Success - clear form and refresh data
        titleCtrl.clear();
        descriptionCtrl.clear();
        imageFile = null;
        imageList.clear();
        imageLocalPathList.clear();

        await getLkigai();

        Get.snackbar(
          'Success',
          'Ikigai created successfully!',
          backgroundColor: Color(0xFF008B8B),
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 2),
        );

        Get.back(); // Return to list
      } else {
        Get.snackbar(
          'Error',
          'Failed to create Ikigai. Please try again.',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (error) {
      postingData = false;
      update();

      // Close loading dialog if open
      if (Get.isDialogOpen == true) {
        Get.back();
      }

      debugPrint("Error creating Ikigai: $error");

      Get.snackbar(
        'Error',
        'An unexpected error occurred: ${error.toString()}',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 3),
      );
    }
  }

  ///_________________________________ GET LKIGAI
  List<LkigaiModel> lkigaiList = [];
  getLkigai() async {
    String url = "${EndPoint.getLkigai}${selectedType.toLowerCase()}";
    print(url);
    try {
      dataLoading = true;
      update();
      dynamic data = await APIService().getDataWithAPIWithoutContext(
        url: url,
      );
      print(data);
      if (data != null) {
        lkigaiList.clear();
        for (var oneData in data[selectedType.toLowerCase()]) {
          LkigaiModel lkigai = LkigaiModel.fromJson(oneData);
          lkigaiList.add(lkigai);
          dataLoading = false;
          update();
        }
      }
      dataLoading = false;
      update();
    } catch (error) {
      dataLoading = false;
      update();
      // Show.showErrorSnackBar("Error", "Something Went Wrong");
    }
  }

  removeSelectedImage(int index) {
    imageLocalPathList.removeAt(index);
    imageList.removeAt(index);
    update();
  }

  removeSelectedStoryImage(index) {
    selectedLkigai.image!.removeAt(index);
    update();
  }

  ///_________________________ UPDATE STORY
  updateLkigai(BuildContext context) async {
    String url =
        "${EndPoint.updateLkigai}${selectedType.toLowerCase()}/${selectedLkigai.sId}";
    print(url);
    if (selectedLkigai.title!.isEmpty) {
      Show.showErrorSnackBar("Error", "Please Add Title");
    } else if (selectedLkigai.description!.isEmpty) {
      Show.showErrorSnackBar("Error", "Please Add Description");
    } else if (selectedLkigai.image!.isEmpty) {
      Show.showErrorSnackBar("Error", "Please Add Images");
    } else {
      try {
        postingData = true;
        update();
        await APIService().putDataWithAPI(
            url: url, data: selectedLkigai.toJson(), context: context);
        Get.back();
        Get.back();
        await getLkigai();
        postingData = false;
        update();
      } catch (error) {
        postingData = false;
        update();
      }
    }
  }

  ///_________________________ DELETE STORY
  deleteLkigai(String id, BuildContext context) async {
    String url = "${EndPoint.deletLkigai}${selectedType.toLowerCase()}/$id";
    try {
      dataLoading = true;
      update();
      await APIService().getDataWithAPI(url: url, context: context);
      Get.back();
      await getLkigai();
      dataLoading = false;
      update();
    } catch (error) {
      dataLoading = false;
      update();
    }
  }
}
