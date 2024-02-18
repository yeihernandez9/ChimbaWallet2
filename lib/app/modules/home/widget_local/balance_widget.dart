import 'package:auto_size_text/auto_size_text.dart';
import 'package:chimba_wallet/app/modules/home/home_controller.dart';
import 'package:chimba_wallet/app/modules/home/widget_local/my_rewards_widget.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../core/utils/functions/responsive.dart';
import '../../../global_widgets/button_circle.dart';
import '../../../global_widgets/button_primary.dart';

class BalanceWidget extends StatelessWidget {
  BalanceWidget({Key? key}) : super(key: key);

  final _ = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.on(context);

    return Column(
      children: [
        Text(
          _.nameWallet,
          textAlign: TextAlign.center,
          style: const TextStyle(
              fontSize: 28.0,
              color: Color(0xff50dcd4),
              fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: responsive.inchPercent(1),
        ),
        InkWell(
          child: Container(
              width: responsive.widthPercent(70),
              height: responsive.heightPercent(5),
              alignment: Alignment.center,
              padding: EdgeInsets.fromLTRB(
                  responsive.inchPercent(1),
                  responsive.inchPercent(0),
                  responsive.inchPercent(1),
                  responsive.inchPercent(0)),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                color: Color(0xff121A23),
              ),
              child: Row(
                children: [
                  SizedBox(
                      width: responsive.widthPercent(55),
                      child: Text(
                        _.address,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 18.0, color: Colors.white),
                      )),
                  SizedBox(
                    width: responsive.widthPercent(1),
                  ),
                  Image.asset(
                    'assets/icon/copy.png',
                    width: responsive.widthPercent(7),
                  ),
                ],
              )),
          onTap: () async {
            FlutterClipboard.copy(_.address).then(
              (value) {
                return ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Address copy!'.tr),
                  ),
                );
              },
            );
          },
        ),
        SizedBox(
          height: responsive.inchPercent(2),
        ),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: const Color(0xff121A23)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: responsive.inchPercent(1),
              ),
              SizedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/logo_insignia.png',
                      width: responsive.widthPercent(17),
                    ),
                    AutoSizeText(
                      '${'Total Balance'.tr}\n CMBA',
                      style: const TextStyle(
                          fontSize: 24.0,
                          color: Color(0xff50dcd4),
                          fontWeight: FontWeight.bold),
                      maxLines: 2,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Obx(
                () => _.balance.value == '0'
                    ? Container(
                        width: 20, // Ajusta el ancho del contenedor
                        height: 20,
                        alignment: Alignment.centerRight,
                        child: const CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white)))
                    : AutoSizeText(
                        '${_.balance}',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 24.0,
                            color: Color(0xff50dcd4),
                            fontWeight: FontWeight.normal),
                        maxLines: 1,
                      ),
              ),
              Obx(
                () => AutoSizeText(
                  "${_.typeCurrency.value}\$ ${_.balancePesos}",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 14.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w200),
                  maxLines: 1,
                ),
              ),
              SizedBox(
                height: responsive.inchPercent(1),
              ),
            ],
          ),
        ),
        SizedBox(
          height: responsive.inchPercent(0.5),
        ),
        Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: const Color(0xff121A23)),
            child: Column(
              children: [
                SizedBox(
                  height: responsive.heightPercent(1),
                ),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Image.asset(
                    'assets/images/logo_insignia.png',
                    width: responsive.widthPercent(12),
                  ),
                  SizedBox(
                    width: responsive.widthPercent(2),
                  ),
                  Column(
                    children: [
                      Text(
                        'CMBA ${'Available'.tr}',
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w200),
                      ),
                      AutoSizeText(
                        _.available.value,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.normal),
                        maxLines: 1,
                      ),
                    ],
                  ),
                ]),
                SizedBox(
                  height: responsive.heightPercent(1),
                ),
                SizedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ButtonCircle(
                          status: true,
                          width: 120,
                          titleButton: "Receive".tr,
                          fontSizeButton: 12,
                          typeIcon: Icons.file_download_outlined,
                          callBack: () {
                            showModalBottomSheet(
                                backgroundColor: Colors.black87,
                                context: context,
                                isScrollControlled: true,
                                isDismissible: true,
                                builder: (context) {
                                  return SizedBox(
                                    height: responsive.inchPercent(35),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.fromLTRB(
                                              responsive.inchPercent(1),
                                              responsive.inchPercent(2),
                                              responsive.inchPercent(1),
                                              responsive.inchPercent(0)),
                                          child: Column(children: [
                                            Text(
                                              'Scan QR code'.tr,
                                              textAlign: TextAlign.right,
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            const Divider(
                                              height: 20,
                                              thickness: 1,
                                              indent: 10,
                                              endIndent: 0,
                                              color: Colors.white,
                                            ),
                                          ]),
                                        ),
                                        InkWell(
                                          child: Container(
                                              width:
                                                  responsive.widthPercent(70),
                                              height:
                                                  responsive.heightPercent(5),
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.fromLTRB(
                                                  responsive.inchPercent(1),
                                                  responsive.inchPercent(0),
                                                  responsive.inchPercent(1),
                                                  responsive.inchPercent(0)),
                                              decoration: const BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10)),
                                                color: Color(0xff121A23),
                                              ),
                                              child: Row(
                                                children: [
                                                  SizedBox(
                                                      width: responsive
                                                          .widthPercent(55),
                                                      child: Text(
                                                        _.address,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: const TextStyle(
                                                            fontSize: 18.0,
                                                            color:
                                                                Colors.white),
                                                      )),
                                                  SizedBox(
                                                    width: responsive
                                                        .widthPercent(3),
                                                  ),
                                                  const Icon(
                                                    Icons.copy_outlined,
                                                    color: Colors.white,
                                                  ),
                                                ],
                                              )),
                                          onTap: () async {
                                            FlutterClipboard.copy(_.address)
                                                .then(
                                              (value) {
                                                return ScaffoldMessenger.of(
                                                        context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                        'Address copy!'.tr),
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                        ),
                                        QrImage(
                                          data: _.address,
                                          version: QrVersions.auto,
                                          size: 200.0,
                                          backgroundColor: Colors.white,
                                        ),
                                        Container(
                                            padding: EdgeInsets.fromLTRB(
                                                responsive.inchPercent(0),
                                                responsive.inchPercent(0),
                                                responsive.inchPercent(0),
                                                responsive.inchPercent(8)),
                                            alignment: Alignment.bottomCenter,
                                            child: ButtonPrimary(
                                              status: true,
                                              titleButton: 'Share Address'.tr,
                                              fontSizeButton: 20.0,
                                              callBack: () {
                                                _.share();
                                              },
                                            )),
                                      ],
                                    ),
                                  );
                                });
                          }),
                      SizedBox(
                        width: responsive.inchPercent(0),
                      ),
                      Obx(() => ButtonCircle(
                            status: _.status.value,
                            width: 120,
                            titleButton: "Send".tr,
                            fontSizeButton: 12,
                            typeIcon: Icons.arrow_outward_rounded,
                            callBack: () {
                              _.goSend();
                            },
                          )),
                      SizedBox(
                        width: responsive.inchPercent(0),
                      ),
                      Obx(() => ButtonCircle(
                            status: _.status.value,
                            width: 120,
                            titleButton: "Stake".tr,
                            fontSizeButton: 12,
                            typeIcon: Icons.stacked_line_chart_rounded,
                            callBack: () {
                              _.goStaking();
                            },
                          )),
                    ],
                  ),
                ),
                SizedBox(
                  height: responsive.inchPercent(1),
                ),
              ],
            )),
        SizedBox(
          height: responsive.inchPercent(2),
        ),
        Obx(() => Container(
            decoration: _.status.value
                ? BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: const Color(0xff121A23))
                : BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: const Color.fromARGB(255, 3, 18, 35)),
            child: InkWell(
              child: ListTile(
                leading: Image.asset(
                  'assets/images/comisionar.png',
                  width: responsive.widthPercent(10),
                ),
                title: Text(
                  'CMBA ${'Staking'.tr}',
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w200),
                ),
                subtitle: _.delegate.value == '0'
                    ? Container(
                        alignment: Alignment.centerRight,
                        child: const CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(Colors.white)))
                    : AutoSizeText(
                        '${_.delegate}',
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                        maxLines: 1,
                      ),
              ),
              onTap: () {
                if (_.status.value) _.goUnstaking();
              },
            ))),
        SizedBox(
          height: responsive.heightPercent(1),
        ),
        MyRewardsWidget(),
        SizedBox(
          height: responsive.heightPercent(1),
        ),
        Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: const Color(0xff121A23)),
            child: InkWell(
              child: ListTile(
                leading: Image.asset(
                  'assets/images/descomisionar.png',
                  width: responsive.widthPercent(10),
                ),
                title: Text(
                  'CMBA ${'Unstake'.tr}',
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w200),
                ),
                subtitle: _.unbonding.value == '0'
                    ? Container(
                        alignment: Alignment.centerRight,
                        child: const CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(Colors.white)))
                    : AutoSizeText(
                        '${_.unbonding}',
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                        maxLines: 1,
                      ),
              ),
              onTap: () {
                showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: Text(
                      'Unbounding CMBA'.tr,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20),
                    ),
                    backgroundColor: const Color(0xff303a47).withOpacity(1),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    content: const Text(
                        "Visita validador.chimba.ooo para más información.",
                        style: TextStyle(color: Colors.white)),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => {
                          Navigator.pop(context, 'Cancel'),
                        },
                        child: Text('OK'.tr,
                            style: const TextStyle(color: Color(0xff50dcd4))),
                      ),
                    ],
                  ),
                );
              },
            )),
      ],
    );
  }
}
