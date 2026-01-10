
import 'package:my_board/imports.dart';
import 'package:rich_editor/rich_editor.dart';
import 'dart:io';

import 'package:my_board/data/models/visual_board_model.dart';
import 'package:my_board/imports.dart';
import 'package:rich_editor/rich_editor.dart';

import '../../../../core/api_service.dart';
import '../../../../core/values/api_constant.dart';
import '../../../../data/models/story_model.dart';
import '../../../../core/values/show.dart';



class PowerMeController extends GetxController {
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
    "Visual Representation",
    "Passion",
    "Mission",
    "Vocation",
    "Profession",

  ];

  String selectedGoal = "";

  //___________________________ Select Image From Gallery
  Future<void> selectImage(ImageSource source, String type) async {
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
          isImageUploading = false;
          update();
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

  ///_________________________________ SUBMIT STORY
  addNewPowerMe(BuildContext context) async {
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
        url = "${EndPoint.addPowerMe}shortTermGoal";
      } else if (selectedGoal == "Long Term Goals") {
        url = "${EndPoint.addPowerMe}longTermGoal";
      } else if (selectedGoal == "Cappabilities") {
        url = "${EndPoint.addPowerMe}capability";
      } else if (selectedGoal == "Personal Goals") {
        url = "${EndPoint.addPowerMe}personalGoal";
      } else if (selectedGoal == "Role Model") {
        url = "${EndPoint.addPowerMe}roleModel";
      } else if (selectedGoal == "Visual Representation") {
        url = "${EndPoint.addPowerMe}visualRepresentation";
      }else if (selectedGoal == "Passion") {
        url = "${EndPoint.addPowerMe}passion";
      }else if (selectedGoal == "Mission") {
        url = "${EndPoint.addPowerMe}mission";
      }else if (selectedGoal == "Vocation") {
        url = "${EndPoint.addPowerMe}vocation";
      }else if (selectedGoal == "Profession") {
        url = "${EndPoint.addPowerMe}profession";
      }
      print(url);
      
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
         getAllPowerMe();
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

  ///_________________________________ GET POWER ME DATA
  List<StoryModel> storyList = [];
  getAllPowerMe() async {
    print(EndPoint.viewPowerMe);
    try {
      dataLoading = true;
      update();

      dynamic data = await APIService().getDataWithAPIWithoutContext(
        url: EndPoint.viewPowerMe,
      );

      if (data != null && data['powerOfMeData'] != null && data['powerOfMeData'].isNotEmpty) {
        storyList.clear();
        visualBoardData = VisualBoardModel.fromJson(data['powerOfMeData'][0]);
      } else {
        // Initialize with empty data if no data found
        visualBoardData = VisualBoardModel();
        print('No PowerMe data found, initializing with empty model');
      }

      dataLoading = false;
      update();

    } catch (error) {
      dataLoading = false;
      update();
      print('Error loading PowerMe data: $error');

      // Initialize with empty data on error
      visualBoardData = VisualBoardModel();

      // Show user-friendly error message
      Get.snackbar(
        'Loading Error',
        'Failed to load Power Me data. Please check your connection.',
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
    getAllPowerMe();
    super.onInit();
  }
}

      
      