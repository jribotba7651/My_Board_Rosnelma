String url = "http://100.27.95.223:8004/api/v1";

/// local server

class EndPoint {
  /// -=-=====   File uploader  =====-=-

  static String fileUploader = "$url/generic/upload-file";

  /// -=-=====   User Auth  =====-=-
  static String registerUser = "$url/users/register";
  static String loginUser = "$url/users/login";
  static String googleLogin = "$url/users/google-login";
  static String appleLogin = "$url/users/apple-login";
  static String forgotPassword = "$url/users/forgot-password";
  static String verifyCode = "$url/users/verify-code";
  static String resetPassword = "$url//users/reset-password/";
  static String getProfile = "$url/users/profile";
  static String updateProfile = "$url/users/update-profile";


  //// ============== LKIGAI BOARD =============////
  static String addLkigai = "$url/ikigai/add/";
  static String getLkigai = "$url/ikigai/view/";
  static String deletLkigai = "$url/ikigai/remove/";
  static String updateLkigai = "$url/ikigai/update/";

  //// ============== STORY BOARD =============////
  static String addStory = "$url/story/add-story";
  static String getStories = "$url/story/view-stories";
  static String deletStory = "$url/story/remove-story/";
  static String updateStory = "$url/story/update-story/";

  //// ============== TASK BOARD =============////
  static String addTask = "$url/task/add-task";
  static String viewTask = "$url/task/view-tasks-by-status?status=";
  static String deletTask = "$url/task/remove-task/";
  static String updateTask = "$url/task/update-task/";
  static String chnageTaskStatus = "$url/task/change-status/";

    //// ============== Vissual BOARD =============////
  static String addVisual = "$url/visual/add/";
  static String viewVisual = "$url/visual/visual-board-detail";
  static String deletVisual = "$url/visual/remove/";
  static String updateVisual = "$url/visual/update/";

      //// ============== PowerMe BOARD =============////
  static String addPowerMe = "$url/powerOfMe/add/";
  static String viewPowerMe = "$url/powerOfMe/power-board-details";
  static String deletPowerMe = "$url/powerOfMe/remove/";
  static String updatePowerMe = "$url/powerOfMe/update/";

  /// -=-=====   User Sessions  =====-=-
  static String createSession = "$url/sessions/create-session";
  static String getUpcomingSessions = "$url/sessions/upcomming-session";
  static String getOnGoingSessions = "$url/sessions/ongoing-session";
  static String getMySessions = "$url/sessions/my-session";
  static String deleteSession = "$url/sessions/delete-session/";
  static String joinSession = "$url/sessions/join-session";
  static String getMyAllSessionResuls = "$url/sessions/session-result-detail";
  static String userResultDeatil = "$url/sessions/user-result-detail/";
  static String attemptSession = "$url/sessions/attempt-session";

  /// -=-=====   User Subscription  =====-=-
  static String subscription = "$url/subscription/create-subscription";
  static String cancelSubscription = "$url/subscription/cancel-subscription";

  
  /// -=-=====   FAMILY TREE  =====-=-
  static String getfamilyTree = "$url/familyTree/view-family-tree";
  static String addFamilyMember = "$url/familyTree/add-family-member";
}
