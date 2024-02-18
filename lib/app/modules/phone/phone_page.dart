import 'package:chimba_wallet/app/core/utils/functions/responsive.dart';
import 'package:chimba_wallet/app/global_widgets/BackgroundImage.dart';
import 'package:chimba_wallet/app/global_widgets/appBar_child.dart';
import 'package:chimba_wallet/app/modules/phone/phone_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class PhonePage extends StatelessWidget {
  const PhonePage({super.key});

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.on(context);
    return GetBuilder<PhoneController>(
      builder: (_) => Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBarChild(
              nameTitle: 'Ingresa tu número de celular'.tr, buttonBack: true),
          body: Stack(
            children: [
              BackgroundImage(),
              Container(
                padding: EdgeInsets.fromLTRB(
                    responsive.inchPercent(2),
                    responsive.inchPercent(10),
                    responsive.inchPercent(2),
                    responsive.inchPercent(0)),
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(
                          responsive.inchPercent(1),
                          responsive.inchPercent(3),
                          responsive.inchPercent(1),
                          responsive.inchPercent(3)),
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(179, 40, 47, 54),
                          borderRadius: BorderRadius.circular(10)),
                      key: _.formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            margin: const EdgeInsets.only(bottom: 30.0),
                            child: const Text(
                                'El número de celular que proporciones será asociado a tu billetera y es importante que sea correcto para asegurar una comunicación efectiva. Asegúrate de incluir el código de país y de verificar que no haya errores en el número ingresado. ¡Gracias!',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                )),
                          ),
                          InternationalPhoneNumberInput(
                              onInputChanged: _.onInputChanged,
                              onInputValidated: _.onInputValidated,
                              selectorConfig: const SelectorConfig(
                                selectorType: PhoneInputSelectorType.DIALOG,
                              ),
                              ignoreBlank: false,
                              autoValidateMode: AutovalidateMode.disabled,
                              selectorTextStyle:
                                  const TextStyle(color: Colors.white),
                              initialValue: _.number,
                              textFieldController: _.textController,
                              formatInput: false,
                              textStyle: const TextStyle(color: Colors.white),
                              errorMessage: "Numero Invalido",
                              hintText: "",
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                signed: true,
                                decimal: true,
                              ),
                              inputBorder: const OutlineInputBorder()),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 30.0),
                      decoration: const BoxDecoration(
                          color: Color(0xff50dcd4),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Column(
                        children: <Widget>[
                          ListTile(
                            onTap: () {
                              showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                        title: _.validateNumber.value
                                            ? Text(
                                                _.verifyNumber.value
                                                    ? 'Este número ya está registrado con una billetera'
                                                    : '¿Está seguro de que el número ${_.phoneNumber.value} está escrito correctamente? Este número se utilizará para verificar su billetera.',
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 17),
                                              )
                                            : const Text(
                                                'Por favor, ingrese un número válido.',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 17),
                                              ),
                                        backgroundColor: const Color(0xff303a47)
                                            .withOpacity(1),
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20))),
                                        content:
                                            _.validateNumber.value == false ||
                                                    _.verifyNumber.value
                                                ? const Icon(
                                                    Icons.error,
                                                    color: Color.fromARGB(
                                                        255, 175, 175, 175),
                                                    size: 50,
                                                  )
                                                : Text('${_.addressValue}',
                                                    style: const TextStyle(
                                                        color: Colors.white)),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () => Navigator.pop(
                                                context, 'Cancel'),
                                            child: Text(
                                                _.verifyNumber.value ||
                                                        _.validateNumber
                                                                .value ==
                                                            false
                                                    ? ''
                                                    : 'Cancel'.tr,
                                                style: const TextStyle(
                                                    color: Color(0xff50dcd4))),
                                          ),
                                          TextButton(
                                            onPressed: () => {
                                              Navigator.pop(context, 'OK'),
                                              _.validateForm(),
                                            },
                                            child: Text('OK'.tr,
                                                style: const TextStyle(
                                                    color: Color(0xff50dcd4))),
                                          ),
                                        ],
                                      ));
                            },
                            title: Text(
                              'Verificar Billetera'.tr,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
