import 'package:my_board/core/api_service.dart';
import 'package:my_board/core/storage.dart';
import 'package:my_board/core/values/api_constant.dart';
import 'package:my_board/data/models/user_model.dart';
import 'package:my_board/imports.dart';
import 'package:my_board/core/values/show.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class SplashController extends GetxController {
  TextEditingController firstNameCtrl = TextEditingController();
  TextEditingController lastNameCtrl = TextEditingController();
  TextEditingController refCodeCtrl = TextEditingController();

  TextEditingController ageCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();
  TextEditingController confirmPasswordCtrl = TextEditingController();
  TextEditingController codeCtrl = TextEditingController();
  //final GlobalKey<FormState> signInGlobalKey = GlobalKey<FormState>();
  //final GlobalKey<FormState> signUpGlobalKey = GlobalKey<FormState>();
  bool postingData = false;
  String userId = '';
  bool showPassword = true;
  String gender = "Male";

  // Google Sign-In instance
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId: '896230566230-np87gonsfrbs89r5ljmauls19n6r5te9.apps.googleusercontent.com',
  );

  ///_____________________________REGITER NEW USER
  registerNewUser(
      BuildContext context, GlobalKey<FormState> signUpGlobalKey) async {
    var body = {
      "firstName": firstNameCtrl.text,
      "lastName": lastNameCtrl.text,
      "password": passwordCtrl.text,
      "email": emailCtrl.text,
      "age": ageCtrl.text,
      "refCode": refCodeCtrl.text,
      "gender":gender,
    };
    print(body);

    if (signUpGlobalKey.currentState!.validate()) {
      if (passwordCtrl.text != confirmPasswordCtrl.text) {
        Show.showErrorSnackBar("Error", "Password Must Same");
      } else {
        try {
          postingData = true;
          update();
          bool result = await APIService().postDataWithAPI(
              url: EndPoint.registerUser, data: body, context: context);
          if (result) {
            firstNameCtrl.clear();
            lastNameCtrl.clear();
            ageCtrl.clear();
            emailCtrl.clear();
            passwordCtrl.clear();
            confirmPasswordCtrl.clear();
            postingData = false;
            Get.toNamed(Routes.signIn);
          } else {
            firstNameCtrl.clear();
            lastNameCtrl.clear();
            ageCtrl.clear();
            emailCtrl.clear();
            passwordCtrl.clear();
            confirmPasswordCtrl.clear();
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
  }

  ///__________________________________________LOGIN
  loginUser(BuildContext context, GlobalKey<FormState> signInGlobalKey) async {
    var body = {"email": emailCtrl.text, "password": passwordCtrl.text};

    // ========== DEBUGGING LOGS START ==========
    print("🔐 LOGIN DEBUG: Starting login process");
    print("📧 EMAIL: ${emailCtrl.text}");
    print("🔒 PASSWORD LENGTH: ${passwordCtrl.text.length}");
    print("📡 LOGIN URL: ${EndPoint.loginUser}");
    print("📦 REQUEST BODY: $body");
    print("=========================================");

    //Get.offNamed(Routes.dashboard);
    print("🔍 VALIDATION: Checking form validation...");
    print("📧 EMAIL FILLED: ${emailCtrl.text.isNotEmpty}");
    print("🔒 PASSWORD FILLED: ${passwordCtrl.text.isNotEmpty}");

    if (signInGlobalKey.currentState!.validate()) {
      try {
        postingData = true;
        update();

        print("✅ Form validation passed, calling API...");

        bool result = await APIService().postDataWithAPI(
            url: EndPoint.loginUser, data: body, context: context);

        print("📝 API RESULT: $result");

        if (result) {
          print("🎉 LOGIN SUCCESS: Redirecting to dashboard");
          emailCtrl.clear();
          passwordCtrl.clear();
          postingData = false;
          Get.offNamed(Routes.dashboard);
          update();
        } else {
          print("❌ LOGIN FAILED: API returned false");
          emailCtrl.clear();
          passwordCtrl.clear();
          postingData = false;
          update();
        }
      } catch (error) {
        print("💥 LOGIN EXCEPTION: $error");
        print("📍 EXCEPTION TYPE: ${error.runtimeType}");
        postingData = false;
        update();
        debugPrint("Error $error");
      }
    } else {
      print("❌ FORM VALIDATION FAILED");
    }
    print("🏁 LOGIN PROCESS FINISHED");
    print("==========================================");
  }

  ///_________________________________________GOOGLE SIGN-IN
  googleSignIn(BuildContext context) async {
    try {
      print("🔍 GOOGLE SIGN-IN DEBUG: Starting Google Sign-In process");
      postingData = true;
      update();

      // Sign out any existing user first
      await _googleSignIn.signOut();

      print("⏳ Initiating Google Sign-In...");
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        print("❌ GOOGLE SIGN-IN: User cancelled the sign-in process");
        postingData = false;
        update();
        return;
      }

      print("✅ GOOGLE SIGN-IN: User selected account: ${googleUser.email}");
      print("👤 GOOGLE USER INFO:");
      print("   📧 Email: ${googleUser.email}");
      print("   👤 Display Name: ${googleUser.displayName}");
      print("   🆔 ID: ${googleUser.id}");
      print("   🖼️ Photo URL: ${googleUser.photoUrl}");

      // Get authentication details
      print("🔑 Getting Google authentication details...");
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      print("🔑 GOOGLE AUTH TOKENS:");
      print("   🎫 Access Token: ${googleAuth.accessToken?.substring(0, 10)}...");
      print("   🔐 ID Token: ${googleAuth.idToken?.substring(0, 10)}...");

      // Prepare data for backend
      var body = {
        "email": googleUser.email,
        "firstName": googleUser.displayName?.split(' ').first ?? '',
        "lastName": googleUser.displayName?.split(' ').skip(1).join(' ') ?? '',
        "googleId": googleUser.id,
        "photoUrl": googleUser.photoUrl ?? '',
        "accessToken": googleAuth.accessToken,
        "idToken": googleAuth.idToken,
        "authProvider": "google"
      };

      print("📦 SENDING TO BACKEND:");
      print("📧 Email: ${body["email"]}");
      print("👤 Name: ${body["firstName"]} ${body["lastName"]}");
      print("🆔 Google ID: ${body["googleId"]}");

      // Call your backend API for Google Sign-In
      // Note: You'll need to create this endpoint on your backend
      print("📡 Calling backend: ${EndPoint.googleLogin}");
      bool result = await APIService().postDataWithAPI(
          url: EndPoint.googleLogin, data: body, context: context);

      if (result) {
        print("🎉 GOOGLE SIGN-IN SUCCESS: Redirecting to dashboard");
        postingData = false;
        Get.offNamed(Routes.dashboard);
        update();
      } else {
        print("❌ GOOGLE SIGN-IN FAILED: Backend returned false");
        postingData = false;
        update();
        Show.showErrorSnackBar("Error", "Google Sign-In failed. Please try again.");
      }

    } catch (error) {
      print("💥 GOOGLE SIGN-IN EXCEPTION: $error");
      print("📍 EXCEPTION TYPE: ${error.runtimeType}");
      postingData = false;
      update();
      Show.showErrorSnackBar("Error", "Google Sign-In failed. Please try again.");
      debugPrint("Google Sign-In Error: $error");
    }
  }

  ///_________________________________________APPLE SIGN-IN
  appleSignIn(BuildContext context) async {
    try {
      print("🍎 APPLE SIGN-IN DEBUG: Starting Apple Sign-In process");
      postingData = true;
      update();

      print("⏳ Initiating Apple Sign-In...");
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      print("✅ APPLE SIGN-IN: User authenticated successfully");
      print("👤 APPLE USER INFO:");
      print("   🆔 User ID: ${credential.userIdentifier}");
      print("   📧 Email: ${credential.email ?? 'Not provided'}");
      print("   👤 Given Name: ${credential.givenName ?? 'Not provided'}");
      print("   👤 Family Name: ${credential.familyName ?? 'Not provided'}");

      // Prepare data for backend
      var body = {
        "email": credential.email ?? '',
        "firstName": credential.givenName ?? '',
        "lastName": credential.familyName ?? '',
        "appleId": credential.userIdentifier,
        "identityToken": credential.identityToken,
        "authorizationCode": credential.authorizationCode,
        "authProvider": "apple"
      };

      print("📦 SENDING TO BACKEND:");
      print("📧 Email: ${body["email"]}");
      print("👤 Name: ${body["firstName"]} ${body["lastName"]}");
      print("🆔 Apple ID: ${body["appleId"]}");

      // Call backend API for Apple Sign-In
      print("📡 Calling backend: ${EndPoint.appleLogin}");
      bool result = await APIService().postDataWithAPI(
          url: EndPoint.appleLogin, data: body, context: context);

      if (result) {
        print("🎉 APPLE SIGN-IN SUCCESS: Redirecting to dashboard");
        postingData = false;
        Get.offNamed(Routes.dashboard);
        update();
      } else {
        print("❌ APPLE SIGN-IN FAILED: Backend returned false");
        postingData = false;
        update();
        Show.showErrorSnackBar("Error", "Apple Sign-In failed. Please try again.");
      }

    } catch (error) {
      print("💥 APPLE SIGN-IN EXCEPTION: $error");
      print("📍 EXCEPTION TYPE: ${error.runtimeType}");
      postingData = false;
      update();
      Show.showErrorSnackBar("Error", "Apple Sign-In failed. Please try again.");
      debugPrint("Apple Sign-In Error: $error");
    }
  }

  ///_________________________ SENT OTP
  sentOtopToEmail(BuildContext context) async {
    var body = {"email": emailCtrl.text};
    // Get.toNamed(Routes.verificationCode);
    try {
      postingData = true;
      update();
      bool result = await APIService().postDataWithAPI(
          url: EndPoint.forgotPassword, data: body, context: context);
      if (result == true) {
        emailCtrl.clear();
        Get.toNamed(Routes.verificationCode);
      }
      postingData = false;
      update();
    } catch (error) {
      postingData = false;
      update();
    }
  }

  verifyCode(BuildContext context) async {
    if (codeCtrl.text.isEmpty) {
      Show.showErrorSnackBar("Error", "Varification Code Required");
    } else {
      try {
        var body = {"code": int.parse(codeCtrl.text)};
        postingData = true;
        update();
        dynamic result = await APIService().postDataWithReturn(
            url: EndPoint.verifyCode, data: body, context: context);
        if (result != null) {
          if (result["success"] = true) {
            codeCtrl.clear();
            UserModel user = UserModel.fromJson(result["user"]);
            userId = user.sId!;
            Get.toNamed(Routes.changePassword, arguments: [user]);
          }
        }

        postingData = false;
        update();
      } catch (error) {
        postingData = false;
        update();
      }
    }
  }

  resetPassword(BuildContext context) async {
    if (passwordCtrl.text.isEmpty) {
      Show.showErrorSnackBar("Error", "Please Enter Password");
    } else if (passwordCtrl.text != confirmPasswordCtrl.text) {
      Show.showErrorSnackBar("Error", "Please Enter Same Password");
    } else {
      var body = {"newPassword": passwordCtrl.text};
      String endPoint = "${EndPoint.resetPassword}$userId";
      try {
        postingData = true;
        update();
        bool result = await APIService()
            .postDataWithAPI(url: endPoint, data: body, context: context);
        if (result == true) {
          passwordCtrl.clear();
          confirmPasswordCtrl.clear();
          Get.toNamed(Routes.signIn);
        }
        postingData = false;
        update();
      } catch (error) {
        postingData = false;
        update();
      }
    }
  }

  whereMove() async {
    String? data = await SharedPrefStorage.getString(key: "token");
    if (data?.isEmpty ?? true) {
      Get.toNamed(Routes.initialSplash);
    } else {
      Get.offNamed(Routes.dashboard);
    }
  }

  @override
  void onInit() {
    whereMove();
    super.onInit();
  }
}
