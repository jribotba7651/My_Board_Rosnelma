import 'package:my_board/imports.dart';
import 'package:my_board/modules/auth/change_password.dart';
import 'package:my_board/modules/auth/forgot_pass_view.dart';
import 'package:my_board/modules/auth/instruction_view.dart';
import 'package:my_board/modules/auth/sign_in_view.dart';
import 'package:my_board/modules/auth/signup_view.dart';
import 'package:my_board/modules/auth/splash_view.dart';
import 'package:my_board/modules/auth/verification_code_view.dart';
import 'package:my_board/modules/dashboard/dashboard%20pages/family%20tree/add_family_form_view.dart';
import 'package:my_board/modules/dashboard/dashboard%20pages/family%20tree/edit_family_form_view.dart';
import 'package:my_board/modules/dashboard/dashboard%20pages/family%20tree/family_tree_view.dart';
import 'package:my_board/modules/dashboard/dashboard%20pages/lkigai%20board/list_lkigai_view.dart';
import 'package:my_board/modules/dashboard/dashboard%20pages/lkigai%20board/lkigai_board_view.dart';
import 'package:my_board/modules/dashboard/dashboard%20pages/lkigai%20board/lkigai_detail_view.dart';
import 'package:my_board/modules/dashboard/dashboard%20pages/lkigai%20board/update_lkigai_view.dart';
import 'package:my_board/modules/dashboard/dashboard%20pages/power%20of%20me/add_power_me_view.dart';
import 'package:my_board/modules/dashboard/dashboard%20pages/power%20of%20me/power_me_view.dart';
import 'package:my_board/modules/dashboard/dashboard%20pages/story%20board/add_story_board_view.dart';
import 'package:my_board/modules/dashboard/dashboard%20pages/story%20board/story_board_view.dart';
import 'package:my_board/modules/dashboard/dashboard%20pages/story%20board/story_detail.dart';
import 'package:my_board/modules/dashboard/dashboard%20pages/story%20board/update_story_board.dart';
import 'package:my_board/modules/dashboard/dashboard%20pages/task%20board/task_bindings.dart';
import 'package:my_board/modules/dashboard/dashboard%20pages/task%20board/task_home_view.dart';
import 'package:my_board/modules/dashboard/dashboard%20pages/task%20board/update_task.dart';
import 'package:my_board/modules/dashboard/dashboard%20pages/visual%20board/visual_board_bindings.dart';
import 'package:my_board/modules/profile/profile_view.dart';
import 'package:my_board/modules/subscription/chnage_card_view.dart';
import 'package:my_board/modules/subscription/subscription_view.dart';
import '../modules/auth/auth_bindings.dart';
import '../modules/dashboard/dashboard pages/family tree/family_tree_bindings.dart';
import '../modules/dashboard/dashboard pages/home/home_bindings.dart';
import '../modules/dashboard/dashboard pages/home/home_view.dart';
import '../modules/dashboard/dashboard pages/lkigai board/add_lkigai_view.dart';
import '../modules/dashboard/dashboard pages/lkigai board/lkigai_board_bindings.dart';
import '../modules/dashboard/dashboard pages/power of me/power_me_bindings.dart';
import '../modules/dashboard/dashboard pages/story board/story_board_bindings.dart';
import '../modules/dashboard/dashboard pages/visual board/add_visual_board_view.dart';
import '../modules/dashboard/dashboard pages/visual board/visual_board_view.dart';
import '../modules/dashboard/dashboard pages/quantum deck/quantum_deck_view.dart';
import '../modules/dashboard/dashboard pages/quantum deck/quantum_deck_bindings.dart';
import '../modules/profile/profile_bindings.dart';
import '../modules/subscription/subscription_bindings.dart';
import 'binding.dart';

abstract class AppPages {
  static final pages = [
    GetPage(
        name: Routes.initialSplash, // '/'
        page: () => const SplashView(),
        binding: SplashBinding()),
    GetPage(
      name: Routes.instrction, // '/'
      page: () => const InstructionView(),
    ),
    GetPage(
        name: Routes.signIn,
        page: () => const SignInView(),
        binding: SplashBinding()),
    GetPage(
      name: Routes.signUp,
      page: () => const SignUpView(),
    ),
    GetPage(
      name: Routes.forgotPassword,
      page: () => const ForgotPasswordView(),
    ),
    GetPage(
      name: Routes.verificationCode,
      page: () => const VerificationCodeView(),
    ),
    GetPage(
      name: Routes.changePassword,
      page: () => const ChangePasswordView(),
    ),
    GetPage(
      name: Routes.subscription,
      page: () => const SubscriptionView(),
      binding: ChangeCardBindings(),
    ),
    GetPage(
      name: Routes.changeCard,
      page: () => const ChangeCardView(),
      binding: ChangeCardBindings(),
    ),
    GetPage(
      name: Routes.profile,
      page: () => const ProfileView(),
    ),
    GetPage(
      name: Routes.dashboard,
      page: () => const HomeView(),
      binding: DashBoardBinding(),
    ),
    GetPage(
      name: Routes.taskBoard,
      page: () => const TaskBoardHomeView(),
      binding: TaskBoardBindings(),
    ),
    GetPage(
      name: Routes.updateTask,
      page: () => const UpdateTaskBoardView(),
    ),
    GetPage(
      name: Routes.powerMe,
      page: () => const PowerMeView(),
      binding: PowerMeBindings(),
    ),
    GetPage(
      name: Routes.addPowerMe,
      page: () => const AddPowerMeView(),
    ),
    GetPage(
      name: Routes.visualBoard,
      page: () => const VisualBoardView(),
      binding: VisualBoardBindings(),
    ),
    GetPage(
      name: Routes.addVisualBoard,
      page: () =>  AddVisualBoardView(),
    ),
    GetPage(
        name: Routes.storyBoard,
        page: () => const StoryBoardView(),
        binding: StoryBoardBindings()),
    GetPage(
      name: Routes.addStoryBoard,
      page: () => const AddStoryBoardView(),
    ),
    GetPage(
      name: Routes.updateStoryBoard,
      page: () => const UpdateStoryBoardView(),
    ),
    GetPage(
      name: Routes.storyBoardDetail,
      page: () => const StoryDetailView(),
    ),
    GetPage(
        name: Routes.familyTree,
        page: () =>  FamilyTreeView(),
        binding: FamilyTreeBindings()),
    GetPage(
      name: Routes.addFamilyTree,
      page: () => const AddFamilyTreeView(),
    ),
    GetPage(
      name: Routes.editFamilyTree,
      page: () => const EditFamilyTreeView(),
    ),
    GetPage(
        name: Routes.lkigaiBoard,
        page: () => const LkiGaiBoardView(),
        binding: LkigaiBoardBindings()),
    GetPage(
      name: Routes.lkigaiDetail,
      page: () => const LkigaiDetailView(),
    ),
      GetPage(
      name: Routes.updateLkigai,
      page: () => const UpdateLkigaiBoardView(),
    ),
    GetPage(
      name: Routes.listLkigaiBoard,
      page: () => const LkigaiListView(),
    ),
    GetPage(
      name: Routes.addLkigaiBoard,
      page: () => const AddLkigaiBoardView(),
    ),
    GetPage(
      name: Routes.quantumDeck,
      page: () => const QuantumDeckView(),
      binding: QuantumDeckBindings(),
    ),
  ];
}
