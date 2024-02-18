import 'package:chimba_wallet/app/modules/navigator_bar/navigator_bar_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavigatorBarPage extends StatelessWidget {
  const NavigatorBarPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NavigatorBarController>(
        builder: (_) => Scaffold(
            extendBodyBehindAppBar: true,
            body: Stack(children: [
              Navigator(
                key: Get.nestedKey(1),
                initialRoute: _.initPage,
                onGenerateRoute: _.onGenerateRoute,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Theme(
                    data: Theme.of(context)
                        .copyWith(canvasColor: Colors.transparent),
                    child: Obx(
                      () => BottomNavigationBar(
                        showSelectedLabels: false,
                        showUnselectedLabels: false,
                        elevation: 0,
                        backgroundColor: const Color(0xff303a47).withOpacity(1),
                        iconSize: 34,
                        items: const <BottomNavigationBarItem>[
                          BottomNavigationBarItem(
                            icon: Icon(Icons.wallet),
                            label: '',
                          ),
                          BottomNavigationBarItem(
                            icon: ImageIcon(AssetImage("assets/icon/nft.png")),
                            label: '',
                          ),
                          BottomNavigationBarItem(
                            icon: Icon(Icons.credit_card_rounded),
                            label: '',
                          ),
                          BottomNavigationBarItem(
                            icon: Icon(Icons.settings),
                            label: '',
                          ),
                        ],
                        currentIndex: _.currentIndex.value,
                        selectedItemColor: const Color(0xff50dcd4),
                        unselectedItemColor: Colors.white,
                        onTap: _.changePage,
                      ),
                    )),
              )
            ])));
  }
}
