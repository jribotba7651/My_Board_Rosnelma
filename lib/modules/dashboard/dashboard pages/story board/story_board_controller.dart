// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:my_board/data/models/story_model.dart';
import 'package:my_board/imports.dart';
import 'package:rich_editor/rich_editor.dart';

import '../../../../core/api_service.dart';
import '../../../../core/values/api_constant.dart';
import '../../../../core/values/show.dart';

class StoryBoardController extends GetxController {
  GlobalKey<RichEditorState> keyEditor = GlobalKey();

  String selectedType = "";
  File? imageFile;
  List<File> imageLocalPathList = [];
  List<String> imageList = [];
  // String? image = '';
  bool postingData = false;
  bool dataLoading = true;
  StoryModel selectedStory = StoryModel();
  bool isImageUploading = false;

  TextEditingController titleCtrl = TextEditingController();
  TextEditingController descriptionCtrl = TextEditingController();

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
          if (path.isNotEmpty) {
            selectedStory.image!.add(path);
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

  ///_________________________________ SUBMIT STORY
  addNewStory(BuildContext context) async {
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
                Text('Creating Story...'),
              ],
            ),
          ),
        ),
        barrierDismissible: false,
      );

      var body = {
        "title": titleCtrl.text.trim(),
        "description": descriptionCtrl.text.trim(),
        "image": imageList,
      };

      print("Creating Story with ${imageList.length} images");

      postingData = true;
      update();

      bool result = await APIService().postDataWithAPI(
        url: EndPoint.addStory,
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

        await getStories();

        Get.snackbar(
          'Success',
          'Story created successfully!',
          backgroundColor: Color(0xFF008B8B),
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 2),
        );

        Get.back(); // Return to list
      } else {
        Get.snackbar(
          'Error',
          'Failed to create Story. Please try again.',
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

      debugPrint("Error creating Story: $error");

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

  ///_________________________________ GET STORIES
  List<StoryModel> storyList = [];
  getStories() async {
    try {
      dataLoading = true;
      update();

      dynamic data = await APIService().getDataWithAPIWithoutContext(
        url: EndPoint.getStories,
      );

      if (data != null && data['stories'] != null) {
        storyList.clear();
        for (var oneData in data['stories']) {
          StoryModel story = StoryModel.fromJson(oneData);
          storyList.add(story);
        }
      } else {
        print('No stories data found');
      }

      dataLoading = false;
      update();

    } catch (error) {
      dataLoading = false;
      update();
      print('Error loading stories: $error');

      Get.snackbar(
        'Loading Error',
        'Failed to load stories. Please check your connection.',
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
      await getStories();
      dataLoading = false;
      update();
    } catch (error) {
      dataLoading = false;
      update();
    }
  }

  ///_________________________ UPDATE STORY
  updateStory(BuildContext context) async {
    String url = "${EndPoint.updateStory}${selectedStory.sId}";
    if (selectedStory.title!.isEmpty) {
      Show.showErrorSnackBar("Error", "Please Add Title");
    } else if (selectedStory.description!.isEmpty) {
      Show.showErrorSnackBar("Error", "Please Add Description");
    } else if (selectedStory.image!.isEmpty) {
      Show.showErrorSnackBar("Error", "Please Add Images");
    } else {
      try {
        postingData = true;
        update();
        await APIService().putDataWithAPI(
            url: url, data: selectedStory.toJson(), context: context);
        Get.back();
        Get.back();
        await getStories();
        postingData = false;
        update();
      } catch (error) {
        postingData = false;
        update();
      }
    }
  }

  removeSelectedImage(int index) {
    imageLocalPathList.removeAt(index);
    imageList.removeAt(index);
    update();
  }

  removeSelectedStoryImage(index) {
    selectedStory.image!.removeAt(index);
    update();
  }

  @override
  void onInit() {
    getStories();
    super.onInit();
  }
}
