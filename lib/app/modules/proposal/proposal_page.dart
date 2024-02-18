import 'package:auto_size_text/auto_size_text.dart';
import 'package:chimba_wallet/app/global_widgets/BackgroundImage.dart';
import 'package:chimba_wallet/app/global_widgets/appBar_child.dart';
import 'package:chimba_wallet/app/global_widgets/button_primary.dart';
import 'package:chimba_wallet/app/modules/proposal/proposal_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../../core/utils/functions/responsive.dart';

class ProposalPage extends StatelessWidget {
  const ProposalPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.on(context);

    return GetBuilder<ProposalController>(builder: (_) {
      return Scaffold(
          extendBodyBehindAppBar: true,
          backgroundColor: Colors.transparent,
          appBar: const AppBarChild(nameTitle: 'Propuesta', buttonBack: true),
          body: Stack(
            children: [
              BackgroundImage(),
              Container(
                  padding: EdgeInsets.fromLTRB(
                      responsive.inchPercent(2),
                      responsive.inchPercent(6),
                      responsive.inchPercent(2),
                      responsive.inchPercent(0)),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            textDirection: TextDirection.rtl,
                            children: [
                              Container(
                                padding: EdgeInsets.fromLTRB(
                                    responsive.inchPercent(1.5),
                                    responsive.inchPercent(0.5),
                                    responsive.inchPercent(1.5),
                                    responsive.inchPercent(0.5)),
                                alignment: Alignment.centerRight,
                                decoration: BoxDecoration(
                                  color: _.status == 1
                                      ? const Color(0xff8eefea)
                                      : _.status == 2
                                          ? const Color(0xff49dbd4)
                                          : _.status == 3
                                              ? const Color(0xff1b4e81)
                                              : const Color(0xfff32f8b),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                    _.status == 1
                                        ? 'Periodo de Depósito'
                                        : _.status == 2
                                            ? 'Periodo de Votación'
                                            : _.status == 3
                                                ? 'Aprobado'
                                                : _.status == 4
                                                    ? 'Rechazado'
                                                    : '',
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 12)),
                              ),
                            ]),
                        Row(
                          children: [
                            Text(
                              "#${_.id}",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                        AutoSizeText(
                          _.title,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.normal),
                          maxLines: 2,
                        ),
                        SizedBox(
                          height: responsive.inchPercent(1),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Desvio",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "${_.maxPorcent}%",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        LinearPercentIndicator(
                          animation: true,
                          lineHeight: 8.0,
                          animationDuration: 2500,
                          percent: _.porcentTotal,
                          barRadius: const Radius.circular(16),
                          progressColor: const Color(0xff50dcd4),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(
                              responsive.inchPercent(0),
                              responsive.inchPercent(1),
                              responsive.inchPercent(0),
                              responsive.inchPercent(2)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              CircularPercentIndicator(
                                radius: 40.0,
                                lineWidth: 5.0,
                                animation: true,
                                animationDuration: 1200,
                                percent: _.yes,
                                center: Text("${(_.yes * 100).round()}%",
                                    style:
                                        const TextStyle(color: Colors.white)),
                                progressColor: const Color(0xff50dcd4),
                                footer: Text(
                                  'Yes'.tr,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                              CircularPercentIndicator(
                                radius: 40.0,
                                lineWidth: 5.0,
                                animation: true,
                                animationDuration: 1200,
                                percent: _.no,
                                center: Text("${(_.no * 100).round()}%",
                                    style:
                                        const TextStyle(color: Colors.white)),
                                progressColor: const Color(0xff50dcd4),
                                footer: Text(
                                  "No".tr,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                              CircularPercentIndicator(
                                radius: 40.0,
                                lineWidth: 5.0,
                                animation: true,
                                animationDuration: 1200,
                                percent: _.noWithVeto,
                                center: Text("${(_.noWithVeto * 100).round()}%",
                                    style:
                                        const TextStyle(color: Colors.white)),
                                progressColor: const Color(0xff50dcd4),
                                footer: Text(
                                  "No with veto".tr,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                              CircularPercentIndicator(
                                radius: 40.0,
                                lineWidth: 5.0,
                                animation: true,
                                animationDuration: 1200,
                                percent: _.abstain,
                                center: Text(
                                  "${(_.abstain * 100).round()}%",
                                  style: const TextStyle(color: Colors.white),
                                ),
                                progressColor: const Color(0xff50dcd4),
                                footer: Text(
                                  "Abstain".tr,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              )
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              "Description".tr,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                            ),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(
                              responsive.inchPercent(0),
                              responsive.inchPercent(0.5),
                              responsive.inchPercent(0),
                              responsive.inchPercent(0)),
                          child: Container(
                              height: responsive.inchPercent(30),
                              child: RawScrollbar(
                                  thumbColor: const Color(0xff50dcd4),
                                  thickness: 3, //width of scrollbar
                                  radius: const Radius.circular(10),
                                  child: SingleChildScrollView(
                                    child: RichText(
                                      softWrap: true,
                                      textAlign: TextAlign.justify,
                                      text: TextSpan(
                                        text: _.description,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.white,
                                        ),
                                        children: const <TextSpan>[
                                          TextSpan(
                                              text: '',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold)),
                                        ],
                                      ),
                                    ),
                                  ))),
                        ),
                        const SizedBox(
                          height: 50.0,
                        ),
                        Container(
                          child: ButtonPrimary(
                            status: _.status == 2 ? true : false,
                            typeIcon: Icons.how_to_vote,
                            titleButton: 'Votar',
                            fontSizeButton: 20.0,
                            callBack: () {
                              showModalBottomSheet<void>(
                                backgroundColor: Colors.black87,
                                context: context,
                                isScrollControlled: true,
                                isDismissible: true,
                                builder: (BuildContext context) {
                                  return SizedBox(
                                    height: responsive.inchPercent(20),
                                    child: ListView.builder(
                                      itemCount: _.typeVotes.length,
                                      itemBuilder: (context, index) {
                                        return ListTile(
                                          title: Text(
                                            _.typeVotes[index],
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          leading: Radio(
                                            activeColor: Colors.white,
                                            fillColor: MaterialStateColor
                                                .resolveWith((states) =>
                                                    const Color(0xff50dcd4)),
                                            groupValue:
                                                _.selectedRadioVoted.value,
                                            value: index,
                                            onChanged: (val) {
                                              _.setSelectedRadioVoted(val!);
                                              Navigator.pop(context);
                                              showDialog<String>(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) =>
                                                          AlertDialog(
                                                            title: Text(
                                                              'Vote'.tr,
                                                              style: const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 20),
                                                            ),
                                                            content: Text(
                                                                "Do you wish to proceed with the transaction?"
                                                                    .tr,
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white)),
                                                            backgroundColor:
                                                                const Color(
                                                                        0xff303a47)
                                                                    .withOpacity(
                                                                        1),
                                                            shape: const RoundedRectangleBorder(
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            20))),
                                                            actions: <Widget>[
                                                              TextButton(
                                                                onPressed: () =>
                                                                    Navigator.pop(
                                                                        context,
                                                                        'Cancel'),
                                                                child: Text(
                                                                    'Cancel'.tr,
                                                                    style: TextStyle(
                                                                        color: Color(
                                                                            0xff50dcd4))),
                                                              ),
                                                              TextButton(
                                                                  onPressed:
                                                                      () => {
                                                                            Navigator.pop(context,
                                                                                'OK'),
                                                                            _.vote(val)
                                                                          },
                                                                  child: Text(
                                                                    'OK'.tr,
                                                                    style: TextStyle(
                                                                        color: Color(
                                                                            0xff50dcd4)),
                                                                  )),
                                                            ],
                                                          ));
                                            },
                                          ),
                                        );
                                      },
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 50.0,
                        ),
                      ],
                    ),
                  ))
            ],
          ));
    });
  }
}
