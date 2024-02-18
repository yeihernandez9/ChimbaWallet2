import 'package:auto_size_text/auto_size_text.dart';
import 'package:chimba_wallet/app/global_widgets/BackgroundImage.dart';
import 'package:chimba_wallet/app/global_widgets/appBar_child.dart';
import 'package:chimba_wallet/app/modules/governance/governance_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../core/utils/functions/responsive.dart';

class GovernancePage extends StatelessWidget {
  const GovernancePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.on(context);

    return GetBuilder<GovernanceController>(
        builder: (_) => Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBarChild(nameTitle: 'Governance'.tr, buttonBack: true),
            backgroundColor: Colors.transparent,
            body: Stack(
              children: [
                BackgroundImage(),
                Container(
                  padding: EdgeInsets.fromLTRB(
                      responsive.inchPercent(1),
                      responsive.inchPercent(0),
                      responsive.inchPercent(1),
                      responsive.inchPercent(0)),
                  child: Container(
                      constraints: const BoxConstraints(
                        maxHeight: double.infinity,
                      ),
                      child: ListView.separated(
                          separatorBuilder: (context, index) => const Divider(
                                color: Colors.white24,
                                thickness: 1,
                                indent: 20,
                                endIndent: 20,
                              ),
                          itemCount: _.statusVoting.length,
                          itemBuilder: ((ctx, index) {
                            final titulo =
                                _.statusVoting[index].content?.value?.title;
                            final id = _.statusVoting[index].id;
                            final status = _.statusVoting[index].status;
                            DateFormat dateFormat =
                                DateFormat('MMMM dd h:mm a', 'es_ES');
                            String fechaFormateada = dateFormat
                                .format(_.statusVoting[index].votingEndTime!);

                            return GestureDetector(
                                onTap: () {
                                  _.goStatusGovenance(id);
                                },
                                child: Container(
                                    padding: EdgeInsets.fromLTRB(
                                        responsive.inchPercent(1),
                                        responsive.inchPercent(0),
                                        responsive.inchPercent(1),
                                        responsive.inchPercent(0)),
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
                                                          ? const Color(
                                                              0xff49dbd4)
                                                          : status == 3
                                                              ? const Color(
                                                                  0xff1b4e81)
                                                              : const Color(
                                                                  0xfff32f8b),
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
                                                              ? 'VOTING PERIOD'
                                                                  .tr
                                                              : status == 3
                                                                  ? 'PASSED'.tr
                                                                  : status == 4
                                                                      ? 'REJECTED'
                                                                          .tr
                                                                      : '',
                                                      style: const TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 12)),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        AutoSizeText(
                                          titulo!,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                          textAlign: TextAlign.left,
                                          maxLines: 2,
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
                ),
              ],
            )));
  }
}
