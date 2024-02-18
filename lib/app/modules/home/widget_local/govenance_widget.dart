import 'package:chimba_wallet/app/modules/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../core/utils/functions/responsive.dart';

class GovenanceWidget extends StatelessWidget {
  GovenanceWidget({Key? key}) : super(key: key);

  final _ = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.on(context);

    return Container(
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(6)),
          color: Color(0xff121A23)),
      child: Column(
        children: <Widget>[
          ListTile(
            onTap: _.goGovernance,
            title: Text(
              'Governance'.tr,
              style: const TextStyle(
                  color: Color(0xff50dcd4),
                  fontSize: 14,
                  fontWeight: FontWeight.normal),
            ),
            trailing: const Icon(
              Icons.keyboard_arrow_right,
              color: Colors.white,
              size: 34,
            ),
          ),
          Container(
              child: ListView.separated(
                  shrinkWrap: true,
                  separatorBuilder: (context, index) => const Divider(
                        color: Colors.white24,
                        thickness: 1,
                        indent: 20,
                        endIndent: 20,
                      ),
                  padding: EdgeInsets.zero,
                  itemCount:
                      _.dataGovernance.length > 3 ? 3 : _.dataGovernance.length,
                  itemBuilder: ((ctx, index) {
                    final titulo =
                        _.dataGovernance[index].content?.value?.title;
                    final id = _.dataGovernance[index].id;
                    final status = _.dataGovernance[index].status;
                    DateFormat dateFormat =
                        DateFormat('MMMM dd h:mm a', 'es_ES');
                    String fechaFormateada = dateFormat
                        .format(_.dataGovernance[index].votingEndTime!);

                    return GestureDetector(
                        onTap: () {
                          _.goStatusGovenance(id);
                        },
                        child: Container(
                            padding: EdgeInsets.fromLTRB(
                                responsive.inchPercent(1),
                                responsive.inchPercent(0),
                                responsive.inchPercent(1),
                                responsive.inchPercent(1)),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "#$id",
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    ClipRRect(
                                      child: Container(
                                        height: 27,
                                        decoration: BoxDecoration(
                                          color: status == 1
                                              ? const Color(0xff8eefea)
                                              : status == 2
                                                  ? const Color(0xff49dbd4)
                                                  : status == 3
                                                      ? const Color(0xff1b4e81)
                                                      : const Color(0xfff32f8b),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: TextButton(
                                          onPressed: () {
                                            // Aquí puedes definir lo que quieres que haga el botón al presionarlo
                                          },
                                          child: Text(
                                              status == 1
                                                  ? 'VOTING DEPOSIT'.tr
                                                  : status == 2
                                                      ? 'VOTING PERIOD'.tr
                                                      : status == 3
                                                          ? 'PASSED'.tr
                                                          : status == 4
                                                              ? 'REJECTED'.tr
                                                              : '',
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12)),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      titulo!,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.left,
                                    ),
                                  ],
                                ),
                                Row(children: [
                                  Text(
                                    "${"Voting ends".tr}: $fechaFormateada",
                                    style: const TextStyle(
                                        color: Colors.white30,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ])
                              ],
                            )));
                  }))),
        ],
      ),
    );
  }
}
