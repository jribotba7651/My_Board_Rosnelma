import 'dart:io';

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
        //selectedStory.image!.add(path);
        isImageUploading = false;

        update();
      }
    } else {
      isImageUploading = false;
      update();
      print('No image selected.');
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

  ///_________________________________ GET STORIES
  List<StoryModel> storyList = [];
  getAllVisuals() async {
    try {
      dataLoading = true;
      update();
      dynamic data = await APIService().getDataWithAPIWithoutContext(
        url: EndPoint.viewVisual,
      );
      if (data != null) {
        storyList.clear();

           visualBoardData = VisualBoardModel.fromJson(data['visualBoardData'][0]);
          dataLoading = false;
          update();
        

        dataLoading = false;
        update();
      } else {
        dataLoading = false;
        update();
      }
    } catch (error) {
      dataLoading = false;
      update();
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
    getAllVisuals();
    super.onInit();
  }
}

      
      