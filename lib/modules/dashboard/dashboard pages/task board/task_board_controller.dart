// ignore_for_file: depend_on_referenced_packages, avoid_print, deprecated_member_use

import 'dart:io';

import 'package:my_board/data/models/task_model.dart';
import 'package:my_board/core/values/show.dart';
import 'package:rich_editor/rich_editor.dart';
import '../../../../core/api_service.dart';
import '../../../../core/values/api_constant.dart';
import '../../../../imports.dart';

class TaskBoardController extends GetxController {
  String selectedTab = "To do";
  String selectedRadioButton = "Todo";
  GlobalKey<RichEditorState> keyEditor = GlobalKey();

  String selectedType = "";
  File? imageFile;
  //String? image = '';
  List<File> imageLocalPathList = [];
  List<String> imageList = [];
  bool postingData = false;
  bool dataLoading = true;
  String? startDate = '';
  String? endDate = '';
  TaskModel selectedTask = TaskModel();
  bool isImageUploading = false;

  TextEditingController titleCtrl = TextEditingController();
  TextEditingController descriptionCtrl = TextEditingController();
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
        selectedTask.image!.add(path);
        isImageUploading = false;

        update();
      }
    } else {
      isImageUploading = false;
      update();
      print('No image selected.');
    }
  }

  //______________________________________________ ADD NEW TASK
  addNewTask(BuildContext context) async {
    if (titleCtrl.text.isEmpty) {
      Show.showErrorSnackBar("Error", "Please Add Title");
    } else if (descriptionCtrl.text.isEmpty) {
      Show.showErrorSnackBar("Error", "Please Add Description");
    } else if (imageList.isEmpty) {
      Show.showErrorSnackBar("Error", "Please Select Image");
    } else if (startDate == '' || endDate == '') {
      Show.showErrorSnackBar("Error", "Please Select Start/End Date");
    } else {
      var body = {
        "title": titleCtrl.text,
        "description": descriptionCtrl.text,
        "image": imageList,
        "startedOn": startDate,
        "deadline": endDate
      };
      print("Body $body");
      try {
        postingData = true;
        update();
        bool result = await APIService().postDataWithAPI(
            url: EndPoint.addTask, data: body, context: context);
        if (result) {
          clearData();
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

  //__________________________________ GET NEW TASKS

  List<TaskModel> tasksList = [];
  getTasks(String type) async {
    String url = '${EndPoint.viewTask}$type';
    try {
      dataLoading = true;
      update();
      dynamic data = await APIService().getDataWithAPIWithoutContext(
        url: url,
      );
      if (data != null) {
        tasksList.clear();

        for (var oneData in data['tasks']) {
          TaskModel story = TaskModel.fromJson(oneData);
          tasksList.add(story);
          dataLoading = false;
          update();
        }

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

  ///_________________________ Update Task
  updateStatus(String id, String status, BuildContext context) async {
    String url = "${EndPoint.chnageTaskStatus}$id?status=$status";
    try {
      dataLoading = true;
      update();
      await APIService().putDataWithAPI(url: url, data: {}, context: context);
      Get.back();
      if (selectedTab == "To do") {
        getTasks("Todo");
      } else if (selectedTab == "In Progress") {
        getTasks("Inprogress");
      } else {
        getTasks("Complete");
      }
      dataLoading = false;
      update();
    } catch (error) {
      dataLoading = false;
      update();
    }
  }

  ///_________________________ DELETE Task
  deleteTask(String id, BuildContext context) async {
    String url = "${EndPoint.deletTask}$id";
    try {
      dataLoading = true;
      update();
      await APIService().deleteDataWithAPI(url: url, context: context);
      Get.back();
      if (selectedTab == "To do") {
        getTasks("Todo");
      } else if (selectedTab == "In Progress") {
        getTasks("Inprogress");
      } else {
        getTasks("Complete");
      }
      dataLoading = false;
      update();
    } catch (error) {
      dataLoading = false;
      update();
    }
  }

  ///_________________________ DELETE Task
  // updateTask(BuildContext context) async {
  //   String url = "${EndPoint.updateTask}${selectedTask.sId}";
  //   try {
  //     dataLoading = true;
  //     update();
  //     await APIService().putDataWithAPI(
  //         url: url, context: context, data: selectedTask.toJson());
  //     Get.back();
  //     if (selectedTab == "To do") {
  //       getTasks("Todo");
  //     } else if (selectedTab == "In Progress") {
  //       getTasks("Inprogress");
  //     } else {
  //       getTasks("Complete");
  //     }
  //     dataLoading = false;
  //     update();
  //   } catch (error) {
  //     dataLoading = false;
  //     update();
  //   }
  // }

  clearData() {
    selectedType = "";
    imageFile = null;
    imageList = [];
    imageLocalPathList = [];
    postingData = false;
    dataLoading = true;
    startDate = '';
    endDate = '';
    titleCtrl.clear();
    descriptionCtrl.clear();
    update();
  }

  ///_________________________ UPDATE TASK
  updateTask(BuildContext context) async {
    String url = "${EndPoint.updateTask}${selectedTask.sId}";
    if (selectedTask.title!.isEmpty) {
      Show.showErrorSnackBar("Error", "Please Add Title");
    } else if (selectedTask.description!.isEmpty) {
      Show.showErrorSnackBar("Error", "Please Add Description");
    } else if (selectedTask.image!.isEmpty) {
      Show.showErrorSnackBar("Error", "Please Add Images");
    } else if (isImageUploading) {
      Show.showErrorSnackBar("Error", "Please Wait...Image Uploading");
    } else {
      try {
        dataLoading = true;
        update();
        await APIService().putDataWithAPI(
            url: url, context: context, data: selectedTask.toJson());

        Get.back();
        if (selectedTab == "To do") {
          getTasks("Todo");
        } else if (selectedTab == "In Progress") {
          getTasks("Inprogress");
        } else {
          getTasks("Complete");
        }
        dataLoading = false;
        update();
      } catch (error) {
        dataLoading = false;
        update();
      }
    }
  }

  changeTab({tab}) {
    tasksList = [];
    update();
    selectedTab = tab;
    if (selectedTab == "To do") {
      getTasks("Todo");
    } else if (selectedTab == "In Progress") {
      getTasks("Inprogress");
    } else {
      getTasks("Complete");
    }
    update();
  }

  changeRadio({newValue, id, context}) {
    selectedRadioButton = newValue;
    ChangeNotifier();
    updateStatus(id, newValue, context);
    update();
  }

  removeSelectedImage(int index) {
    imageLocalPathList.removeAt(index);
    imageList.removeAt(index);
    update();
  }

  removeSelectedStoryImage(index) {
    selectedTask.image!.removeAt(index);
    update();
  }

  @override
  void onInit() {
    getTasks("Todo");
    super.onInit();
  }
}
