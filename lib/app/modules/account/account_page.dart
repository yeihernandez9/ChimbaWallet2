import 'package:chimba_wallet/app/global_widgets/BackgroundImage.dart';
import 'package:chimba_wallet/app/modules/account/account_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AccountController>(
        builder: (_) => Scaffold(
              backgroundColor: Colors.transparent,
              extendBodyBehindAppBar: true,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                title: Text('Select Account'.tr),
                iconTheme: const IconThemeData(
                  color: Colors.white, // <-- SEE HERE
                ),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.add),
                    tooltip: 'Add address',
                    onPressed: () {
                      _.goCreateWallet();
                    },
                  )
                ],
                actionsIconTheme: const IconThemeData(
                    size: 30.0, color: Colors.white, opacity: 10.0),
              ),
              body: Stack(
                children: [
                  BackgroundImage(),
                  Container(
                    alignment: Alignment.center,
                    child: Container(
                        margin: const EdgeInsets.only(top: 20.0),
                        child: ListView.separated(
                            separatorBuilder: (context, index) => const Divider(
                                  color: Colors.white24,
                                  thickness: 0,
                                  indent: 20,
                                  endIndent: 20,
                                ),
                            itemCount: _.userWalletItems.length,
                            itemBuilder: ((ctx, index) {
                              final name = _.userWalletItems[index]["wallet"];
                              final id = _.userWalletItems[index]["id"];
                              return ListTile(
                                  onTap: () => name == _.nameWalletHome
                                      ? {}
                                      : _.changeWallet(id),
                                  title: Text(
                                    name,
                                    style: TextStyle(
                                        color: name == _.nameWalletHome
                                            ? const Color(0xff50dcd4)
                                            : Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                  trailing: const SizedBox(
                                    child: Icon(
                                      Icons.keyboard_arrow_right,
                                      color: Color(0xff50dcd4),
                                      size: 40,
                                    ),
                                  ));
                            }))),
                  )
                ],
              ),
            ));
  }
}
