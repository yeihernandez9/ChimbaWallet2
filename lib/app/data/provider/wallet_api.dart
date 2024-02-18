// ignore_for_file: avoid_print, unnecessary_brace_in_string_interps

import 'dart:convert';

import 'package:chimba_wallet/app/core/utils/constant/constant.dart';
import 'package:chimba_wallet/app/data/model/create_verified_wallet.dart';
import 'package:chimba_wallet/app/data/model/observe_verified_wallets.dart';
import 'package:chimba_wallet/app/data/model/request_available.dart';
import 'package:chimba_wallet/app/data/model/request_code_validate.dart';
import 'package:chimba_wallet/app/data/model/request_get_wallets.dart';
import 'package:chimba_wallet/app/data/model/request_governance.dart';
import 'package:chimba_wallet/app/data/model/request_token_firebase.dart';
import 'package:chimba_wallet/app/data/model/request_token_transaction.dart';
import 'package:chimba_wallet/app/data/model/request_transaction.dart';
import 'package:chimba_wallet/app/data/model/request_vote.dart';
import 'package:chimba_wallet/app/data/model/request_vote_by_address.dart';
import 'package:chimba_wallet/app/data/model/createToken.dart';
import 'package:chimba_wallet/app/data/model/resentOpt.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

import '../model/request_delegate.dart';
import '../model/request_reward.dart';
import '../model/request_type_currency.dart';
import '../model/request_unbonding.dart';

class WalletApi {
  final Dio _dio = Dio();

  // GET TOKEN TRANSACTION
  Future<RequestTokenTransaction> getTokenTransaction() async {
    const url = '${Constants.API_TRANSACTION}auth/login';
    final response = await _dio.post(url, data: {
      "clientid": "7896804",
      "secret": "739834fd-f0ae-47a0-8852-753490681544"
    });
    print('responsetoken${response}');
    return RequestTokenTransaction.fromJson(response.data);
  }

  // MAKE TRANSACTION
  Future<RequestTransaction> makeTransaction(
      {required String toAddress, required String tokenTransaction}) async {
    final headers = {'Authorization': 'Bearer $tokenTransaction'};
    _dio.options.headers = headers;
    const url = '${Constants.API_TRANSACTION}transaction/transaction';

    final response = await _dio.post(url, data: {
      'to': toAddress,
      'amount': Constants.AMOUNTOTPTRANSACTION,
    });
    return RequestTransaction.fromJson(response.data);
  }

  // GET ALL WALLETS
  Future<RequestGetAllWallets> getAllWallets() async {
    const url = '${Constants.API_CHIMBA}/cosmos/auth/v1beta1/accounts';
    final response = await _dio.get(url);
    // print('response${response}');
    return RequestGetAllWallets.fromJson(response.data);
  }

  // GET TOKEN*******************************
  Future<RequestCreateToken> createToken() async {
    const url = '${Constants.API_USER}auth/login';

    dynamic response = (await _dio.post(url, data: {
      "clientid": "13",
      "secret": "rsEYgcVzdSHpny4hnp1hxNGhVHRXKfMaiKAfE6lNV9E="
    }));
    final token = RequestCreateToken.fromJson(response.data);

    return token;
  }

  // CREAR BILLETERA VERIFICADA (POST)*******************************

  Future<CreateVerifidWallet> createVerifiedWallet(
      {required String phonePrefix,
      required int phoneNumber,
      required String address,
      required String token,
      bool verifyNumber = false}) async {
    final headers = {'Authorization': 'Bearer $token'};
    _dio.options.headers = headers;

    const url = '${Constants.API_USER}app/';

    final data = {
      'phonePrefix': phonePrefix,
      'phoneNumber': phoneNumber,
      'address': address,
    };

    try {
      final response = await _dio.post(url, data: data);
      return CreateVerifidWallet.fromJson(response.data);
    } catch (error) {
      throw Exception('Error al crear billetera verificada : $error');
    }
  }

  // VERIFICAR BILLETERA (PATCH)**********

  Future<RequestCodeValidate> getCodeValidate(
      {required int code,
      required String token,
      required int phoneNumber}) async {
    final headers = {'Authorization': 'Bearer $token'};
    _dio.options.headers = headers;

    final requestBody = jsonEncode(
        {'OTPCode': code}); // Envuelve el valor code en un objeto JSON

    final response = await _dio.patch(
      '${Constants.API_USER}app/validateOTP/$phoneNumber',
      data: requestBody, // Usa el objeto JSON como cuerpo de la solicitud
    );
    return RequestCodeValidate.fromJson(response.data);
  }

  // VER BILLETERA VERIFICADA (GET)*******************************

  Future<ObserveVerifidWallet> getVerifiedWallet(
      {required String token}) async {
    final headers = {'Authorization': 'Bearer $token'};
    _dio.options.headers = headers;

    final response = await _dio.get('${Constants.API_USER}app/');

    List<dynamic> responseData = response.data as List<dynamic>;
    ObserveVerifidWallet verifiedWallet =
        ObserveVerifidWallet.fromJson(responseData);
    return verifiedWallet;
  }

  // REENVIAR CODIGO PARA VERIFICAR BILLETERA (PATCH)*******************************
  Future<ResendOpt> resendCode(
      {required int phoneNumber, required String token}) async {
    final headers = {'Authorization': 'Bearer $token'};
    _dio.options.headers = headers;

    final response =
        await _dio.patch('${Constants.API_USER}app/resendOTP/$phoneNumber');
    bool send = response.data.toLowerCase() == 'true';
    return ResendOpt(send);
  }

  Future<RequestTypeMoney> getConvertMoney({required String typeMoney}) async {
    final response = await _dio.get(
      'https://api.cambio.today/v1/quotes/$typeMoney/COP/json?quantity=1&key=39611|0McuKD^p59NcGCCosVQa^rpU_gf9uHDO',
    );
    return RequestTypeMoney.fromJson(response.data);
  }

  Future<RequestAvailable> getAvailable({required String address}) async {
    final response = await _dio.get(
      '${Constants.API_CHIMBA}bank/balances/${address}',
    );
    return RequestAvailable.fromJson(response.data);
  }

  Future<RequestDelegate> getDelegate({required String address}) async {
    final response = await _dio.get(
      '${Constants.API_CHIMBA}staking/delegators/${address}/delegations',
    );
    return RequestDelegate.fromJson(response.data);
  }

  Future<List<RequestUnbonding>> getUnbonding({required String address}) async {
    final response = await _dio.get(
      '${Constants.API_CHIMBA}staking/delegators/${address}/unbonding_delegations',
    );

    if (response.data["result"].length > 0) {
      return (response.data["result"][0]["entries"] as List)
          .map((e) => RequestUnbonding.fromJson(e))
          .toList();
    } else {
      return [RequestUnbonding()];
    }
  }

  Future<RequestReward> getReward({required String address}) async {
    final response = await _dio.get(
      '${Constants.API_CHIMBA}distribution/delegators/${address}/rewards',
    );

    return RequestReward.fromJson(response.data);
  }

  Future<List<RequestGovernance>> getGovernance() async {
    final Response response = await _dio.get(
      '${Constants.API_CHIMBA}gov/proposals',
    );
    return (response.data["result"] as List)
        .map((e) => RequestGovernance.fromJson(e))
        .toList();
  }

  Future<RequestGovernance> getGovernanceId({required String id}) async {
    final Response response = await _dio.get(
      '${Constants.API_CHIMBA}gov/proposals/$id',
    );
    return RequestGovernance.fromJson(response.data["result"]);
  }

  Future<RequestVoteByAddress> getVoteByAddress(
      {required String proposalId, required String voterAddress}) async {
    final Response response = await _dio.get(
      '${Constants.API_CHIMBA}gov/proposals/$proposalId/votes/$voterAddress',
    );
    return RequestVoteByAddress.fromJson(response.data);
  }

  Future<List<RequestVote>> getVotes({required String proposalId}) async {
    final Response response = await _dio.get(
      '${Constants.API_CHIMBA}gov/proposals/$proposalId/votes',
    );

    if (response.data["result"].length > 0) {
      return (response.data["result"] as List)
          .map((vote) => RequestVote.fromJson(vote))
          .toList();
    } else {
      return [RequestVote()];
    }
  }

  // ADD TOKEN FIREBASE *******************************
  Future<RequestTokenFirebase> addTokenFirebase(
      {required String os,
      required String token,
      required String deviceId,
      required String tokenTransaction}) async {
    DateTime fechaActual = DateTime.now();

    String formattedDate = DateFormat('yyyy-MM-dd').format(fechaActual);
    final headers = {'Authorization': 'Bearer $tokenTransaction'};
    _dio.options.headers = headers;
    final url = '${Constants.API_USER}device';

    final response = await _dio.post(url,
        data: {'OS': os, 'Token': token, 'DeviceID': deviceId, 'Date': ''});
    return RequestTokenFirebase.fromJson(response.data);
  }

  Future<String> getTokenFirebase({required String deviceId}) async {
    final Response response = await _dio.get(
      '${Constants.API_USER}device/ByDeviceID/$deviceId',
    );

    return response.toString();
  }

  Future<RequestTokenFirebase> updateTokenFirebase(
      {required String oS,
      required String tokenFirebase,
      required String deviceID,
      required String token,
      required String uid}) async {
    final headers = {'Authorization': 'Bearer $token'};
    _dio.options.headers = headers;

    var url = '${Constants.API_USER}device/$uid';

    final data = {
      'OS': oS,
      'Token': tokenFirebase,
      'DeviceID': deviceID,
    };

    try {
      final response = await _dio.patch(url, data: data);
      return RequestTokenFirebase.fromJson(response.data);
    } catch (error) {
      throw Exception('Error al crear billetera verificada : $error');
    }
  }
}
