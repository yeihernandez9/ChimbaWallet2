import 'package:chimba_wallet/app/data/provider/wallet_api.dart';
import 'package:chimba_wallet/app/data/services/repository/wallet_repository.dart';
import 'package:get/get.dart';

class Injection {
  static void init() {
    //prividers
    Get.lazyPut<WalletApi>(() => WalletApi());

    //Repository
    Get.lazyPut<WalletRepository>(() => WalletRepository());
  }
}
