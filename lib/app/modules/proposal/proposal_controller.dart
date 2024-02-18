import 'package:alan/proto/cosmos/gov/v1beta1/export.dart';
import 'package:chimba_wallet/app/core/utils/constant/constant.dart';
import 'package:chimba_wallet/app/core/utils/helpers/dataWalletHelper.dart';
import 'package:chimba_wallet/app/data/model/request_governance.dart';
import 'package:chimba_wallet/app/data/model/request_vote.dart';
import 'package:chimba_wallet/app/data/model/request_vote_by_address.dart';
import 'package:chimba_wallet/app/data/services/repository/wallet_repository.dart';
import 'package:chimba_wallet/app/global_widgets/loading_dialog.dart';
import 'package:chimba_wallet/app/routes/app_routes.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

import 'package:alan/alan.dart';

class ProposalController extends GetxController {
  final WalletRepository _requestWallet = Get.find<WalletRepository>();

  String _requestGovernance = '';
  String get requestGovernance => _requestGovernance;

  String _id = '';
  String get id => _id;

  String _title = '';
  String get title => _title;

  int _status = 0;
  int get status => _status;

  String _description = '';
  String get description => _description;

  String _fechaStart = '';
  String get fechaStart => _fechaStart;

  String _fechaEnd = '';
  String get fechaEnd => _fechaEnd;

  double _maxPorcent = 0;
  double get maxPorcent => _maxPorcent;

  double _porcentTotal = 0;
  double get porcentTotal => _porcentTotal;

  double _yes = 0;
  double get yes => _yes;

  double _no = 0;
  double get no => _no;

  double _noWithVeto = 0;
  double get noWithVeto => _noWithVeto;

  double _abstain = 0;
  double get abstain => _abstain;

  List<String> _typeVotes = ["Si", "No", "No con derecho a veto", "Abstenerse"];
  List<String> get typeVotes => _typeVotes;

  RxInt selectedRadioVoted = 6.obs;

  RxList userWalletItems = [].obs;

  List<String> _mnemonic = [];
  List<String> get mnemonic => _mnemonic;

  final isLoading = false.obs;

  @override
  void onInit() {
    fechtWallet();
    super.onInit();
  }

  fechtWallet() async {
    DataWalletHelper.db
        .getUserWakketMapList()
        .then((walletList) => {userWalletItems.value = walletList});
  }

  @override
  void onReady() async {
    super.onReady();
    await initializeDateFormatting('es_ES');
    await leerProposal();
    await realVotes();
    await updateVote();
  }

  Future<void> updateVote() async {
    String seed = userWalletItems[0]["mnemonic"];
    _mnemonic = seed.substring(1, seed.length - 1).split(', ');

    final networkInfo = NetworkInfo.fromSingleHost(
      bech32Hrp: Constants.CHAIN,
      host: Constants.GRPC,
    );

    final wallet = Wallet.derive(_mnemonic, networkInfo);

    RequestVoteByAddress requestVoteByAddress =
        await _requestWallet.getVoteByAddressRequest(
            proposalId: Get.arguments, voterAddress: wallet.bech32Address);

    if (requestVoteByAddress.option != "") {
      int opt = int.parse(requestVoteByAddress.option);
      if (opt == 1) {
        selectedRadioVoted = 0.obs;
      } else if (opt == 2) {
        selectedRadioVoted = 3.obs;
      } else if (opt == 3) {
        selectedRadioVoted = 1.obs;
      } else if (opt == 4) {
        selectedRadioVoted = 2.obs;
      }
    }
  }

  Future<void> leerProposal() async {
    RequestGovernance requestGovernance =
        await _requestWallet.getGovernanceIdRequest(id: Get.arguments);

    _id = requestGovernance.id.toString();
    _title = requestGovernance.content!.value!.title!;
    _status = requestGovernance.status!;
    _description = requestGovernance.content!.value!.description!;

    DateFormat dateFormat = DateFormat('MMMM dd h:mm a', 'es_ES');
    _fechaStart = dateFormat.format(requestGovernance.votingStartTime!);
    _fechaEnd = dateFormat.format(requestGovernance.votingEndTime!);
  }

  void validateNanOrNull() {
    _maxPorcent = _maxPorcent.isNaN ? 0 : _maxPorcent;
    _porcentTotal = _porcentTotal.isNaN ? 0 : _porcentTotal;
    _yes = _yes.isNaN ? 0 : _yes;
    _noWithVeto = _noWithVeto.isNaN ? 0 : _noWithVeto;
    _no = _no.isNaN ? 0 : _no;
    _abstain = _abstain.isNaN ? 0 : _abstain;
  }

  void setSelectedRadioVoted(int val) {
    selectedRadioVoted.value = val;
  }

  Future<void> vote(int val) async {
    showLoadingDialog();
    String seed = userWalletItems[0]["mnemonic"];
    _mnemonic = seed.substring(1, seed.length - 1).split(', ');

    var optionVote = VoteOption.VOTE_OPTION_YES;
    if (val == 1) {
      optionVote = VoteOption.VOTE_OPTION_NO;
    } else if (val == 2) {
      optionVote = VoteOption.VOTE_OPTION_NO_WITH_VETO;
    } else if (val == 3) {
      optionVote = VoteOption.VOTE_OPTION_ABSTAIN;
    }

    final networkInfo = NetworkInfo.fromSingleHost(
      bech32Hrp: Constants.CHAIN,
      host: Constants.GRPC,
    );

    final wallet = Wallet.derive(_mnemonic, networkInfo);

    // Compose the transaction fees
    final fee = Fee();
    fee.gasLimit = 200000.toInt64();
    fee.amount.add(
      Coin.create()
        ..amount = '7500'
        ..denom = Constants.CHAIN,
    );

    final msgDelegate = MsgVote.create()
      ..proposalId = int.parse(_id).toInt64()
      ..voter = wallet.bech32Address
      ..option = optionVote;

    // Build the signer
    final signer = TxSigner.fromNetworkInfo(networkInfo);

    final signedTx = await signer.createAndSign(
      wallet,
      [msgDelegate],
      memo: "", // Optional
      fee: fee, // Optional (Default is 200000 gas and empty amount)
    );

    final sender = TxSender.fromNetworkInfo(networkInfo);
    final result = await sender.broadcastTx(
      signedTx,
      mode: BroadcastMode
          .BROADCAST_MODE_BLOCK, // Optional (Default: BroadcastMode.BROADCAST_MODE_SYNC)
    );

    if (result.height > 0) {
      hideLoadingDialog();
      Get.offNamed(AppRoutes.SUCCESSFULTRANSACTION, arguments: result.txhash);
    }
  }

  void showLoadingDialog() {
    isLoading.value = true;
    Get.dialog(const LoadingDialog(msg: "Votando"), barrierDismissible: false);
  }

  void hideLoadingDialog() {
    isLoading.value = false;
    Get.back();
  }

  Future<List<int>> realVotes() async {
    List<RequestVote> requestVotes =
        await _requestWallet.getVotesRequest(proposalId: Get.arguments);

    double y = 0;
    double n = 0;
    double a = 0;
    double w = 0;

    requestVotes.forEach((vote) {
      if (vote.option == "1") {
        y++;
      } else if (vote.option == "3") {
        n++;
      } else if (vote.option == "2") {
        a++;
      } else {
        w++;
      }
    });

    double suma = y + n + a + w;

    double yr = (y / suma) * 100;
    double nr = (n / suma) * 100;
    double ar = (a / suma) * 100;
    double wr = (w / suma) * 100;

    _no = nr / 100;
    _noWithVeto = wr / 100;
    _abstain = ar / 100;

    if (_yes.isInfinite || _yes.isNaN) {
      _yes = 0;
    } else {
      _yes = yr / 100;
    }

    _porcentTotal = (yr + nr + ar + wr) / 100;
    _maxPorcent = (yr + nr + ar + wr);

    validateNanOrNull();
    update();

    return [1];
  }
}
