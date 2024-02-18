import 'package:chimba_wallet/app/modules/browser/browser_binding.dart';
import 'package:chimba_wallet/app/modules/browser/browser_page.dart';
import 'package:chimba_wallet/app/modules/home/home_binding.dart';
import 'package:chimba_wallet/app/modules/home/home_page.dart';
import 'package:chimba_wallet/app/modules/nfts/nfts_binding.dart';
import 'package:chimba_wallet/app/modules/nfts/nfts_page.dart';
import 'package:chimba_wallet/app/modules/setting/setting_binding.dart';
import 'package:chimba_wallet/app/modules/setting/setting_page.dart';
import 'package:chimba_wallet/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavigatorBarController extends GetxController {
  RxInt currentIndex = 0.obs;

  final pages = <String>[
    AppRoutes.HOME,
    AppRoutes.NFTS,
    AppRoutes.BROWSER,
    AppRoutes.SETTING
  ];

  String _initPage = AppRoutes.HOME;
  String get initPage => _initPage;

  RxInt _parameter = 1.obs;
  RxInt get parameter => _parameter;

  Future<void> changePage(int index) async {
    currentIndex.value = index;
    Get.toNamed(pages[index], id: 1);
  }

  @override
  void onReady() {
    getArgument();

    // TODO: implement onReady
    update();
    super.onReady();
  }

  @override
  void onInit() {
    update();
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Route? onGenerateRoute(RouteSettings settings) {
    if (settings.name == AppRoutes.HOME) {
      return GetPageRoute(
        settings: settings,
        page: () => HomePage(),
        binding: HomeBinding(),
      );
    }

    if (settings.name == AppRoutes.SETTING) {
      return GetPageRoute(
        settings: settings,
        page: () => SettingPage(),
        binding: SettingBinding(),
      );
    }

    if (settings.name == AppRoutes.NFTS) {
      return GetPageRoute(
        settings: settings,
        page: () => NftsPage(),
        binding: NftsBinding(),
      );
    }

    if (settings.name == AppRoutes.BROWSER) {
      return GetPageRoute(
        settings: settings,
        page: () => BrowserPage(),
        binding: BrowserBinding(),
      );
    }
  }

  getArgument() {
    final argument = Get.arguments;
    if (argument != null && argument is int) {
      _parameter.value = argument;
      changePage(_parameter.value);
      update();
    }
  }
}
