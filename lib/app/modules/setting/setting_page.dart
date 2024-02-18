// ignore_for_file: avoid_print

import 'package:chimba_wallet/app/global_widgets/appBar_child.dart';
import 'package:chimba_wallet/app/global_widgets/button_primary.dart';
import 'package:chimba_wallet/app/global_widgets/text_field_widget.dart';
import 'package:chimba_wallet/app/modules/setting/setting_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';

import '../../core/utils/functions/responsive.dart';
import '../../global_widgets/BackgroundImage.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.on(context);

    return GetBuilder<SettingController>(
        builder: (_) => Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBarChild(nameTitle: 'Settings'.tr, buttonBack: false),
            backgroundColor: Colors.transparent,
            body: Stack(
              children: [
                BackgroundImage(),
                Container(
                  padding: EdgeInsets.fromLTRB(
                      responsive.inchPercent(2),
                      responsive.inchPercent(8),
                      responsive.inchPercent(2),
                      responsive.inchPercent(0)),
                  alignment: Alignment.center,
                  child: Center(
                    child: RefreshIndicator(
                      onRefresh: () async {
                        _.tempInit();
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: const Color(0xff121A23),
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                ListTile(
                                  leading: const Icon(
                                    Icons.account_balance_wallet_outlined,
                                    color: Color(0xff50dcd4),
                                    size: 40,
                                  ),
                                  onTap: () {
                                    _.goAccount();
                                  },
                                  title: Obx(() => Text(
                                        _.nameWallet.value,
                                        style: const TextStyle(
                                            color: Color(0xff50dcd4),
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      )),
                                  trailing: const Icon(
                                    Icons.keyboard_arrow_right,
                                    color: Color(0xff50dcd4),
                                    size: 30,
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: responsive.heightPercent(2),
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(
                                responsive.inchPercent(1),
                                responsive.inchPercent(0),
                                responsive.inchPercent(0),
                                responsive.inchPercent(0)),
                            alignment: AlignmentDirectional.centerStart,
                            child: Text(
                              'GENERAL'.tr,
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 18),
                            ),
                          ),
                          SizedBox(
                            height: responsive.heightPercent(1),
                          ),
                          Container(
                              decoration: const BoxDecoration(
                                  color: Color(0xff121A23),
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10))),
                              child: Center(
                                child: ListTile(
                                  title: Text(
                                    'Currency'.tr,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  ),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Obx((() => Text(
                                            _.currency.value,
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 20),
                                          ))),
                                      const Icon(
                                        Icons.keyboard_arrow_right,
                                        color: Color(0xff50dcd4),
                                        size: 30,
                                      ),
                                    ],
                                  ),
                                  onTap: () {
                                    showModalBottomSheet<void>(
                                      backgroundColor: Colors.black87,
                                      context: context,
                                      isScrollControlled: true,
                                      isDismissible: true,
                                      builder: (BuildContext context) {
                                        return SizedBox(
                                          height: responsive.inchPercent(20),
                                          child: Column(
                                            children: [
//  ==========================================****LISTTILE COP****=================================================================

                                              ListTile(
                                                title: const Text(
                                                  'COP',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                leading: Radio(
                                                  activeColor: Colors.white,
                                                  fillColor: MaterialStateColor
                                                      .resolveWith(
                                                    (states) =>
                                                        const Color(0xff50dcd4),
                                                  ),
                                                  groupValue: _
                                                      .selectedRadioCurrency
                                                      .value,
                                                  value: 1,
                                                  onChanged: (int? value) {
                                                    _.selectedRadioCurrency
                                                        .value = value!;
                                                    _.setSelectedRadioCurrency(
                                                        value);
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                              ),

// ==========================================****LISTTILE USD****=================================================================

                                              ListTile(
                                                title: const Text(
                                                  'USD',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                leading: Radio(
                                                  activeColor: Colors.white,
                                                  fillColor: MaterialStateColor
                                                      .resolveWith(
                                                    (states) =>
                                                        const Color(0xff50dcd4),
                                                  ),
                                                  groupValue: _
                                                      .selectedRadioCurrency
                                                      .value,
                                                  value: 2,
                                                  onChanged: (int? value) {
                                                    _.selectedRadioCurrency
                                                        .value = value!;
                                                    _.setSelectedRadioCurrency(
                                                        value);
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                              ),

// ==========================================****LISTTILE EUR****=================================================================

                                              ListTile(
                                                title: const Text(
                                                  'EUR',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                leading: Radio(
                                                  activeColor: Colors.white,
                                                  fillColor: MaterialStateColor
                                                      .resolveWith(
                                                    (states) =>
                                                        const Color(0xff50dcd4),
                                                  ),
                                                  groupValue: _
                                                      .selectedRadioCurrency
                                                      .value,
                                                  value: 3,
                                                  onChanged: (int? value) {
                                                    _.selectedRadioCurrency
                                                        .value = value!;
                                                    _.setSelectedRadioCurrency(
                                                        value);
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                          /*ListView.builder(
                                            itemCount: _.dataCurrency.length,
                                            itemBuilder: (context, index) {
                                              return ListTile(
                                                title: Text(
                                                  _.dataCurrency[index]["name"],
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                leading: Radio(
                                                  activeColor: Colors.white,
                                                  fillColor: MaterialStateColor
                                                      .resolveWith((states) =>
                                                          const Color(
                                                              0xff50dcd4)),
                                                  groupValue: _
                                                      .selectedRadioCurrency
                                                      .value,
                                                  value: _.dataCurrency[index]
                                                      ["id"],
                                                  onChanged: (val) {
                                                    _.setSelectedRadioCurrency(
                                                        val!);
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                              );
                                            },
                                          ),*/
                                        );
                                      },
                                    );
                                  },
                                ),
                              )),
                          Container(
                            decoration: const BoxDecoration(
                                color: Color(0xff121A23),
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10))),
                            child: Column(
                              children: <Widget>[
                                ListTile(
                                  onTap: () {
                                    _.goBook();
                                  },
                                  title: Text(
                                    'Address book'.tr,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  ),
                                  trailing: const Icon(
                                    Icons.keyboard_arrow_right,
                                    color: Color(0xff50dcd4),
                                    size: 30,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: responsive.heightPercent(2),
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(
                                responsive.inchPercent(1),
                                responsive.inchPercent(0),
                                responsive.inchPercent(0),
                                responsive.inchPercent(0)),
                            alignment: AlignmentDirectional.centerStart,
                            child: Text(
                              'SECURITY'.tr,
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 18),
                            ),
                          ),
                          SizedBox(
                            height: responsive.heightPercent(1),
                          ),
                          Container(
                            decoration: const BoxDecoration(
                                color: Color(0xff121A23),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10))),
                            child: Column(
                              children: <Widget>[
                                ListTile(
                                  onTap: (() {
                                    showModalBottomSheet(
                                        backgroundColor: Colors.black87,
                                        context: context,
                                        isScrollControlled: true,
                                        isDismissible: true,
                                        builder: (context) {
                                          return SizedBox(
                                            height: responsive.inchPercent(26),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.fromLTRB(
                                                      responsive.inchPercent(0),
                                                      responsive.inchPercent(1),
                                                      responsive.inchPercent(0),
                                                      responsive
                                                          .inchPercent(0)),
                                                  child: Column(children: [
                                                    Text(
                                                      'View Mnemonic Seed'.tr,
                                                      textAlign:
                                                          TextAlign.right,
                                                      style: const TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    SizedBox(
                                                      height: responsive
                                                          .inchPercent(1),
                                                    ),
                                                    Divider(
                                                      height: responsive
                                                          .heightPercent(1),
                                                      thickness: 1,
                                                      indent: responsive
                                                          .widthPercent(2),
                                                      endIndent: 0,
                                                      color: Colors.white,
                                                    ),
                                                  ]),
                                                ),
                                                Obx(
                                                  () => TextFieldWidget(
                                                      hideText: true,
                                                      titleText: 'Password'.tr,
                                                      onChanged: (value) {
                                                        _.onchangePassword(
                                                            value);
                                                      },
                                                      errorText: _.errorPassword
                                                                  .value ==
                                                              false
                                                          ? 'Invalid password'
                                                              .tr
                                                          : null),
                                                ),
                                                Container(
                                                    alignment:
                                                        Alignment.bottomCenter,
                                                    child: ButtonPrimary(
                                                      status: true,
                                                      titleButton: 'Approve'.tr,
                                                      fontSizeButton: 20.0,
                                                      callBack: () {
                                                        _.login();
                                                      },
                                                    )),
                                                SizedBox(
                                                  height:
                                                      responsive.inchPercent(5),
                                                )
                                              ],
                                            ),
                                          );
                                        });
                                  }),
                                  title: Text(
                                    'View mnemonic need'.tr,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  ),
                                  trailing: const Icon(
                                    Icons.keyboard_arrow_right,
                                    color: Color(0xff50dcd4),
                                    size: 30,
                                  ),
                                ),
                                ListTile(
                                  onTap: (() {
                                    _.navigationvalidatedWallet();
                                  }),
                                  title: Text(
                                    'Validar Billetera',
                                    style: TextStyle(
                                      color: _.validatedWallet.value
                                          ? Colors.green
                                          : Colors.red,
                                      fontSize: 20,
                                    ),
                                  ),
                                  trailing: _.validatedWallet.value
                                      ? const Icon(
                                          CupertinoIcons.check_mark_circled,
                                          color: Colors.green,
                                        )
                                      : const Icon(
                                          Icons.keyboard_arrow_right,
                                          color: Colors.red,
                                          size: 30,
                                        ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            decoration: const BoxDecoration(
                                color: Color(0xff121A23),
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10))),
                            child: Column(
                              children: <Widget>[
                                ListTile(
                                    onTap: () {},
                                    title: Text(
                                      'Use biometric authentication'.tr,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                      ),
                                    ),
                                    trailing: Obx(
                                      () => Switch(
                                          inactiveThumbColor:
                                              const Color(0xff50dcd4),
                                          inactiveTrackColor:
                                              const Color.fromARGB(
                                                  255, 214, 240, 239),
                                          activeColor: const Color(0xff50dcd4),
                                          onChanged: (val) => _.toggle(),
                                          value: _.on.value),
                                    )),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: responsive.heightPercent(2),
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(
                                responsive.inchPercent(1),
                                responsive.inchPercent(0),
                                responsive.inchPercent(0),
                                responsive.inchPercent(0)),
                            alignment: AlignmentDirectional.centerStart,
                            child: Text(
                              'OTHERS'.tr,
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 18),
                            ),
                          ),
                          SizedBox(
                            height: responsive.heightPercent(1),
                          ),
                          Container(
                            decoration: const BoxDecoration(
                                color: Color(0xff121A23),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: Column(
                              children: <Widget>[
                                ListTile(
                                  onTap: () {},
                                  title: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '${'Version'.tr} de Chimba',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                        ),
                                      ),
                                      Obx(() {
                                        try {
                                          return Text(
                                            '${_.nameVersion}',
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                            ),
                                          );
                                        } catch (e) {
                                          return const Text(
                                              'Error al mostrar la versión de Flutter');
                                        }
                                      })
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: responsive.heightPercent(2),
                          ),
                          Container(
                            decoration: const BoxDecoration(
                                color: Color(0xff121A23),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: Column(
                              children: <Widget>[
                                ListTile(
                                  onTap: () {
                                    showDialog<String>(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            AlertDialog(
                                              title: Text(
                                                'Delete this wallet'.tr,
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                    fontSize: 20),
                                              ),
                                              backgroundColor:
                                                  const Color(0xff303a47)
                                                      .withOpacity(1),
                                              shape:
                                                  const RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  20))),
                                              content: Text(_.wallet.value,
                                                  style: const TextStyle(
                                                      color: Colors.white)),
                                              actions: <Widget>[
                                                TextButton(
                                                  onPressed: () =>
                                                      Navigator.pop(
                                                          context, 'Cancel'),
                                                  child: Text('Cancel'.tr,
                                                      style: const TextStyle(
                                                          color: Color(
                                                              0xff50dcd4))),
                                                ),
                                                TextButton(
                                                  onPressed: () => {
                                                    Navigator.pop(
                                                        context, 'OK'),
                                                    _.delete(_.idWallet.value)
                                                  },
                                                  child: Text('OK'.tr,
                                                      style: const TextStyle(
                                                          color: Color(
                                                              0xff50dcd4))),
                                                ),
                                              ],
                                            ));
                                  },
                                  title: Text(
                                    'Delete this wallet'.tr,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        color: Color(0xff50dcd4),
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: responsive.heightPercent(12),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            )));
  }
}
