import 'dart:io';
import 'dart:async';

import 'package:my_board/data/models/visual_board_model.dart';
import 'package:my_board/imports.dart';
import 'package:rich_editor/rich_editor.dart';

import '../../../../core/api_service.dart';
import '../../../../core/values/api_constant.dart';
import '../../../../data/models/story_model.dart';
import '../../../../core/values/show.dart';

class VisualBoardController extends GetxController {
  GlobalKey<RichEditorState> keyEditor = GlobalKey();

  String selectedType = "";
  File? imageFile;
  List<File> imageLocalPathList = [];
  List<String> imageList = [];
  // String? image = '';
  bool postingData = false;
  bool dataLoading = true;
  Detail selectedDeatilGoal = Detail();
  bool isImageUploading = false;
  VisualBoardModel visualBoardData =VisualBoardModel();

  TextEditingController titleCtrl = TextEditingController();
  TextEditingController descriptionCtrl = TextEditingController();

  List<String> goalsList = [
    "Short Term Goals",
    "Long Term Goals",
    "Cappabilities",
    "Personal Goals",
    "Role Model",
    "Visual Representation"
  ];

  String selectedGoal = "";

  //___________________________ Select Image From Gallery
  Future<void> selectImage(ImageSource source, String type) async {
    try {
      print('VISUAL BOARD: selectImage called with source: $source, type: $type');
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(
        source: source,
        maxWidth: 1800,
        maxHeight: 1800,
        imageQuality: 85,
      );

      if (pickedFile != null) {
        print('VISUAL BOARD: Image picked successfully');
        imageFile = File(pickedFile.path);
        imageLocalPathList.add(imageFile!);
        Get.back();
        isImageUploading = true;
        update();

        print('VISUAL BOARD: Uploading image to server');
        String path = await APIService().uploadSingleFile(imageFile!.path);

        if (type == "file") {
          if (path.isNotEmpty) {
            imageList.add(path);
            isImageUploading = false;
            update();
            print('VISUAL BOARD: Image uploaded successfully');
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
          isImageUploading = false;
          update();
        }
      } else {
        isImageUploading = false;
        update();
        print('VISUAL BOARD: No image selected.');
      }
    } catch (e) {
      isImageUploading = false;
      update();
      print('VISUAL BOARD: Error selecting image: $e');
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

  ///_________________________________ SUBMIT STORY
  addNewvisual(BuildContext context) async {
    if (selectedGoal == "") {
      Show.showErrorSnackBar("Error", "Please Select Goal Type");
    } else if (titleCtrl.text.isEmpty) {
      Show.showErrorSnackBar("Error", "Please Add Title");
    } else if (descriptionCtrl.text.isEmpty) {
      Show.showErrorSnackBar("Error", "Please Add Description");
    } else if (imageList.isEmpty) {
      Show.showErrorSnackBar("Error", "Please Select Image");
    } else if (isImageUploading == true) {
      Show.showErrorSnackBar("Error", "Wait...Image Uploading");
    } else {
      //    "Short Term Goals",
      // " Long Term Goals",
      // "Cappabilities",
      // "Personal Goals",
      // "Role Model"
      String url = "";
      if (selectedGoal == "Short Term Goals") {
        url = "${EndPoint.addVisual}shortTermGoal";
      } else if (selectedGoal == "Long Term Goals") {
        url = "${EndPoint.addVisual}longTermGoal";
      } else if (selectedGoal == "Cappabilities") {
        url = "${EndPoint.addVisual}capability";
      } else if (selectedGoal == "Personal Goals") {
        url = "${EndPoint.addVisual}personalGoal";
      } else if (selectedGoal == "Role Model") {
        url = "${EndPoint.addVisual}roleModel";
      } else if (selectedGoal == "Visual Representation") {
        url = "${EndPoint.addVisual}visualRepresentation";
      }
      var body = {
        "title": titleCtrl.text,
        "description": descriptionCtrl.text,
        "image": imageList,
      };
      try {
        postingData = true;
        update();
        bool result = await APIService()
            .postDataWithAPI(url: url, data: body, context: context);
        if (result) {
          postingData = false;
          titleCtrl.clear();
          descriptionCtrl.clear();
          imageFile = null;
          imageList = [];
          imageLocalPathList = [];
          getAllVisuals();
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

  ///_________________________________ GET VISUAL BOARD DATA
  List<StoryModel> storyList = [];
  getAllVisuals() async {
    print('VISUAL BOARD: getAllVisuals started');
    try {
      print('VISUAL BOARD: Setting dataLoading to true');
      dataLoading = true;
      update();
      print('VISUAL BOARD: update() called after setting loading true');

      print('VISUAL BOARD: Calling API ${EndPoint.viewVisual}');
      dynamic data = await APIService().getDataWithAPIWithoutContext(
        url: EndPoint.viewVisual,
      );
      print('VISUAL BOARD: API call completed, data: $data');

      if (data != null && data['visualBoardData'] != null && data['visualBoardData'].isNotEmpty) {
        storyList.clear();
        print('VISUAL BOARD: Parsing visual board data');
        visualBoardData = VisualBoardModel.fromJson(data['visualBoardData'][0]);
        print('VISUAL BOARD: Visual board data parsed successfully');
      } else {
        print('VISUAL BOARD: No visual board data found, initializing empty model');
        visualBoardData = VisualBoardModel();
      }

      print('VISUAL BOARD: Setting dataLoading to false');
      dataLoading = false;
      update();
      print('VISUAL BOARD: getAllVisuals completed successfully');

    } catch (error) {
      print('VISUAL BOARD ERROR: $error');
      dataLoading = false;
      update();

      // Initialize with empty data on error
      visualBoardData = VisualBoardModel();

      // Show user-friendly error message
      Get.snackbar(
        'Loading Error',
        'Failed to load visual board data. Please check your connection.',
        backgroundColor: Colors.orange,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 3),
      );
    }
  }

  ///_________________________ DELETE STORY
  deletStory(String id, BuildContext context) async {
    String url = "${EndPoint.deletStory}$id";
    try {
      dataLoading = true;
      update();
      await APIService().deleteDataWithAPI(url: url, context: context);
      Get.back();
     // await getStories();
      dataLoading = false;
      update();
    } catch (error) {
      dataLoading = false;
      update();
    }
  }

  ///_________________________ UPDATE STORY
  // updateStory(BuildContext context) async {
  //   String url = "${EndPoint.updateStory}${selectedStory.sId}";
  //   if (selectedStory.title!.isEmpty) {
  //     Show.showErrorSnackBar("Error", "Please Add Title");
  //   } else if (selectedStory.description!.isEmpty) {
  //     Show.showErrorSnackBar("Error", "Please Add Description");
  //   } else if (selectedStory.image!.isEmpty) {
  //     Show.showErrorSnackBar("Error", "Please Add Images");
  //   } else {
  //     try {
  //       postingData = true;
  //       update();
  //       await APIService().putDataWithAPI(
  //           url: url, data: selectedStory.toJson(), context: context);
  //       Get.back();
  //       Get.back();
  //      // await getStories();
  //       postingData = false;
  //       update();
  //     } catch (error) {
  //       postingData = false;
  //       update();
  //     }
  //   }
  // }

  removeSelectedImage(int index) {
    imageLocalPathList.removeAt(index);
    imageList.removeAt(index);
    update();
  }

  removeSelectedStoryImage(index) {
   // selectedStory.image!.removeAt(index);
    update();
  }

  @override
  void onInit() {
    print('VISUAL BOARD: onInit started');
    super.onInit();
    print('VISUAL BOARD: super.onInit completed');
    getAllVisuals();
    print('VISUAL BOARD: getAllVisuals called');
  }
}

      
      