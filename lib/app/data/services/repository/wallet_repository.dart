import 'package:chimba_wallet/app/data/model/createToken.dart';
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
import 'package:chimba_wallet/app/data/model/resentOpt.dart';
import 'package:chimba_wallet/app/data/provider/wallet_api.dart';
import 'package:get/get.dart';

import '../../model/request_delegate.dart';
import '../../model/request_reward.dart';
import '../../model/request_type_currency.dart';
import '../../model/request_unbonding.dart';

class WalletRepository {
  final WalletApi _api = Get.put(WalletApi());

  Future<RequestTokenTransaction> getTokenTransaction() =>
      _api.getTokenTransaction();

  Future<RequestTransaction> makeTransaction(
          {required String toAddress, required String tokenTransaction}) =>
      _api.makeTransaction(
          toAddress: toAddress, tokenTransaction: tokenTransaction);

  Future<RequestCreateToken> createToken() => _api.createToken();

  Future<RequestGetAllWallets> getAllWallets() => _api.getAllWallets();

  Future<RequestCodeValidate> getCodeValidate(
          {required String token,
          required int code,
          required int phoneNumber}) =>
      _api.getCodeValidate(token: token, code: code, phoneNumber: phoneNumber);

  Future<CreateVerifidWallet> getNumberUser(
          {required String phonePrefix,
          required int phoneNumber,
          required String address,
          required String token}) =>
      _api.createVerifiedWallet(
          phonePrefix: phonePrefix,
          phoneNumber: phoneNumber,
          address: address,
          token: token);

  Future<ObserveVerifidWallet> getVerifiedWalletRquest(
          {required String token}) =>
      _api.getVerifiedWallet(token: token);

  Future<ResendOpt> resendCode(
          {required int phoneNumber, required String token}) =>
      _api.resendCode(token: token, phoneNumber: phoneNumber);

  Future<RequestTypeMoney> getConvertMoneyRequest({
    required String typeMoney,
  }) =>
      _api.getConvertMoney(
        typeMoney: typeMoney,
      );

  Future<RequestAvailable> getAvailableRequest({
    required String address,
  }) =>
      _api.getAvailable(
        address: address,
      );

  Future<RequestDelegate> getDelegateRequest({
    required String address,
  }) =>
      _api.getDelegate(
        address: address,
      );

  Future<List<RequestUnbonding>> getUnbondingRequest({
    required String address,
  }) =>
      _api.getUnbonding(
        address: address,
      );

  Future<RequestReward> getRewardRequest({
    required String address,
  }) =>
      _api.getReward(
        address: address,
      );

  Future<List<RequestGovernance>> getGovernanceRequest() =>
      _api.getGovernance();

  Future<RequestGovernance> getGovernanceIdRequest({
    required String id,
  }) =>
      _api.getGovernanceId(
        id: id,
      );
  Future<RequestVoteByAddress> getVoteByAddressRequest({
    required String proposalId,
    required String voterAddress,
  }) =>
      _api.getVoteByAddress(
        proposalId: proposalId,
        voterAddress: voterAddress,
      );

  Future<List<RequestVote>> getVotesRequest({required String proposalId}) =>
      _api.getVotes(proposalId: proposalId);

  Future addTokenFirebases(
          {required String deviceId,
          required String os,
          required String tokenFirebase,
          required String tokenTransaction}) =>
      _api.addTokenFirebase(
          os: os,
          token: tokenFirebase,
          deviceId: deviceId,
          tokenTransaction: tokenTransaction);

  getTokenFirebase({required String deviceId}) =>
      _api.getTokenFirebase(deviceId: deviceId);

  Future<RequestTokenFirebase> updateTokenFirebase(
          {required String oS,
          required String tokenFirebase,
          required String deviceID,
          required String token,
          required String uid}) =>
      _api.updateTokenFirebase(
          oS: oS,
          tokenFirebase: tokenFirebase,
          deviceID: deviceID,
          token: token,
          uid: uid);
}
