import 'package:chimba_wallet/app/core/utils/functions/responsive.dart';
import 'package:chimba_wallet/app/global_widgets/BackgroundImage.dart';
import 'package:chimba_wallet/app/modules/book/book_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookPage extends StatelessWidget {
  const BookPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.on(context);
    return GetBuilder<BookController>(
        builder: (_) => Scaffold(
            backgroundColor: Colors.transparent,
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              title: Text('Address book'.tr),
              iconTheme: const IconThemeData(
                color: Colors.white, // <-- SEE HERE
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.add),
                  tooltip: 'Add address'.tr,
                  onPressed: () {
                    _.goCreateBook();
                  },
                )
              ],
              actionsIconTheme: const IconThemeData(
                  size: 30.0, color: Colors.white, opacity: 10.0),
            ),
            body: Stack(children: [
              BackgroundImage(),
              Container(
                padding: EdgeInsets.fromLTRB(
                    responsive.inchPercent(1),
                    responsive.inchPercent(2),
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
                        itemCount: _.booksAddres.length,
                        itemBuilder: ((ctx, index) {
                          final nickname = _.booksAddres[index]["nickname"];
                          final address = _.booksAddres[index]["address"];
                          final id = _.booksAddres[index]["id"];
                          return ListTile(
                              title: Text(
                                nickname,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                              ),
                              subtitle: Text(address,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 14)),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    onPressed: () => {
                                      _.sendToSaved(address),
                                    },
                                    icon: const Icon(Icons.send),
                                    color: Colors.cyanAccent[200],
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete_forever),
                                    color: Colors.red[400],
                                    onPressed: () {
                                      showDialog<String>(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              AlertDialog(
                                                title: Text(
                                                  'Delete Address'.tr,
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
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
                                                content: Text(nickname,
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
                                                      _.delete(id)
                                                    },
                                                    child: Text('OK'.tr,
                                                        style: const TextStyle(
                                                            color: Color(
                                                                0xff50dcd4))),
                                                  ),
                                                ],
                                              ));
                                    },
                                  ),
                                ],
                              ));
                        }))),
              )
            ])));
  }
}
