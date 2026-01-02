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
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: source);

    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
      imageLocalPathList.add(imageFile!);
      Get.back();
      isImageUploading = true;
      update();
      String path = await APIService().uploadSingleFile(imageFile!.path);
      if (type == "file") {
        if (path.isNotEmpty) {
          //image = path;
          imageList.add(path);
          isImageUploading = false;
          update();
        }
      } else {
        selectedLkigai.image!.add(path);
        isImageUploading = false;

        update();
      }
    } else {
      isImageUploading = false;
      update();
      print('No image selected.');
    }
  }

  ///_________________________________ SUBMIT LKIGAI
  submitLkigai(BuildContext context) async {
    if (titleCtrl.text.isEmpty) {
      Show.showErrorSnackBar("Error", "Please Add Title");
    } else if (descriptionCtrl.text.isEmpty) {
      Show.showErrorSnackBar("Error", "Please Add Description");
    } else if (imageList.isEmpty) {
      Show.showErrorSnackBar("Error", "Please Select Image");
    } else if (isImageUploading == true) {
      Show.showErrorSnackBar("Error", "Wait....Image Uploading");
    } else {
      var body = {
        "title": titleCtrl.text,
        "description": descriptionCtrl.text,
        "image": imageList
      };
      print("Image Length: ${imageList.length}");
      try {
        postingData = true;
        update();
        bool result = await APIService().postDataWithAPI(
            url: "${EndPoint.addLkigai}${selectedType.toLowerCase()}",
            data: body,
            context: context);
        if (result) {
          postingData = false;
          titleCtrl.clear();
          descriptionCtrl.clear();
          imageFile = null;
          imageList = [];
          await getLkigai();
          Get.back();
        } else {
          postingData = false;
          update();
        }
      } catch (error) {
        postingData = false;
        update();
        debugPrint("Error $error");
      }
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
