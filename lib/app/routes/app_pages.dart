// ignore_for_file: prefer_const_constructors

import 'package:chimba_wallet/app/modules/account/account_binding.dart';
import 'package:chimba_wallet/app/modules/account/account_page.dart';
import 'package:chimba_wallet/app/modules/beginning/beginning_binding.dart';
import 'package:chimba_wallet/app/modules/beginning/beginning_page.dart';
import 'package:chimba_wallet/app/modules/book/book_binding.dart';
import 'package:chimba_wallet/app/modules/book/book_page.dart';
import 'package:chimba_wallet/app/modules/browser/browser_binding.dart';
import 'package:chimba_wallet/app/modules/browser/browser_page.dart';
import 'package:chimba_wallet/app/modules/create_book/create_book_binding.dart';
import 'package:chimba_wallet/app/modules/create_book/create_book_page.dart';
import 'package:chimba_wallet/app/modules/faild_transaction/faild_transaction_binding.dart';
import 'package:chimba_wallet/app/modules/faild_transaction/faild_transaction_page.dart';
import 'package:chimba_wallet/app/modules/governance/governance_binding.dart';
import 'package:chimba_wallet/app/modules/governance/governance_page.dart';
import 'package:chimba_wallet/app/modules/home/home_binding.dart';
import 'package:chimba_wallet/app/modules/home/home_page.dart';
import 'package:chimba_wallet/app/modules/import_mnemonic/import_mnemonic_binding.dart';
import 'package:chimba_wallet/app/modules/import_mnemonic/import_mnemonic_page.dart';
import 'package:chimba_wallet/app/modules/import_wallet/import_wallet_binding.dart';
import 'package:chimba_wallet/app/modules/import_wallet/import_wallet_page.dart';
import 'package:chimba_wallet/app/modules/login/bindings/login_binding.dart';
import 'package:chimba_wallet/app/modules/login/views/login_view.dart';
import 'package:chimba_wallet/app/modules/mnemonic/mnemonic_binding.dart';
import 'package:chimba_wallet/app/modules/mnemonic/mnemonic_page.dart';
import 'package:chimba_wallet/app/modules/navigator_bar/navigator_bar_binding.dart';
import 'package:chimba_wallet/app/modules/navigator_bar/navigator_bar_page.dart';
import 'package:chimba_wallet/app/modules/nfts/nfts_binding.dart';
import 'package:chimba_wallet/app/modules/nfts/nfts_page.dart';
import 'package:chimba_wallet/app/modules/notification/notification_binding.dart';
import 'package:chimba_wallet/app/modules/notification/notification_page.dart';
import 'package:chimba_wallet/app/modules/opt/opt_binding.dart';
import 'package:chimba_wallet/app/modules/opt/opt_page.dart';
import 'package:chimba_wallet/app/modules/phone/phone_binding.dart';
import 'package:chimba_wallet/app/modules/phone/phone_page.dart';
import 'package:chimba_wallet/app/modules/proposal/proposal_binding.dart';
import 'package:chimba_wallet/app/modules/proposal/proposal_page.dart';
import 'package:chimba_wallet/app/modules/qr_scanner/qr_scanner_binding.dart';
import 'package:chimba_wallet/app/modules/qr_scanner/qr_scanner_page.dart';
import 'package:chimba_wallet/app/modules/rewards/rewards_binding.dart';
import 'package:chimba_wallet/app/modules/rewards/rewards_page.dart';
import 'package:chimba_wallet/app/modules/send/send_binding.dart';
import 'package:chimba_wallet/app/modules/send/send_page.dart';
import 'package:chimba_wallet/app/modules/setting/setting_binding.dart';
import 'package:chimba_wallet/app/modules/setting/setting_page.dart';
import 'package:chimba_wallet/app/modules/show_mnemonic/show_mnemonic_binding.dart';
import 'package:chimba_wallet/app/modules/show_mnemonic/show_mnemonic_page.dart';
import 'package:chimba_wallet/app/modules/splash/splash_binding.dart';
import 'package:chimba_wallet/app/modules/splash/splash_page.dart';
import 'package:chimba_wallet/app/modules/staking/staking_binding.dart';
import 'package:chimba_wallet/app/modules/staking/staking_page.dart';
import 'package:chimba_wallet/app/modules/staking_dashboard/staking_dashboard_binding.dart';
import 'package:chimba_wallet/app/modules/staking_dashboard/staking_dashboard_page.dart';
import 'package:chimba_wallet/app/modules/successful_transaction/successful_transaction_binding.dart';
import 'package:chimba_wallet/app/modules/successful_transaction/successful_transaction_page.dart';
import 'package:chimba_wallet/app/modules/verifiedWallet/verified_wallet_binding.dart';
import 'package:chimba_wallet/app/modules/verifiedWallet/verified_wallet_page.dart';
import 'package:chimba_wallet/app/modules/verify_mnemonic/verify_mnemonic_binding.dart';
import 'package:chimba_wallet/app/modules/verify_mnemonic/verify_mnemonic_page.dart';
import 'package:chimba_wallet/app/modules/walletCange/wallet_change_binding.dart';
import 'package:chimba_wallet/app/modules/walletCange/wallet_change_page.dart';
import 'package:chimba_wallet/app/modules/welcome/welcome_binding.dart';
import 'package:chimba_wallet/app/modules/welcome/welcome_page.dart';
import 'package:chimba_wallet/app/routes/app_routes.dart';
import 'package:get/route_manager.dart';

import '../modules/create_wallet/create_wallet_binding.dart';
import '../modules/create_wallet/create_wallet_page.dart';
import '../modules/unstaking/unstaking_binding.dart';
import '../modules/unstaking/unstaking_page.dart';

class AppPages {
  static final List<GetPage> pages = [
    GetPage(
      name: AppRoutes.SPLASH,
      page: () => SplashPage(),
      binding: SplashBinding(),
    ),
    GetPage(
        name: AppRoutes.HOME, page: () => HomePage(), binding: HomeBinding()),
    GetPage(
        name: AppRoutes.VERIFIED_WALLET,
        page: () => VerifiedWalletPage(),
        binding: VerifiedWalletBinding()),
    GetPage(
      name: AppRoutes.CREATE_WALLET,
      page: () => CreateWalletPage(),
      binding: CreateWalletBinding(),
    ),
    GetPage(
      name: AppRoutes.IMPORT_WALLET,
      page: () => ImportWalletPage(),
      binding: ImportWalletBinding(),
    ),
    GetPage(
      name: AppRoutes.BEGINNING,
      page: () => BeginningPage(),
      binding: BeginningBinding(),
    ),
    GetPage(
      name: AppRoutes.MNEMONIC,
      page: () => MnemonicPage(),
      binding: MnemonicBinding(),
    ),
    GetPage(
      name: AppRoutes.VERIFYMNEMONIC,
      page: () => VerifyMnemonicPage(),
      binding: VerifyMnemonicBinding(),
    ),
    GetPage(
      name: AppRoutes.WELCOME,
      page: () => WelcomePage(),
      binding: WelcomeBinding(),
    ),
    GetPage(
      name: AppRoutes.IMPORT_MNEMONIC,
      page: () => ImportMnemonicPage(),
      binding: ImportMnemonicBinding(),
    ),
    GetPage(
      name: AppRoutes.NAVIGATORBAR,
      page: () => NavigatorBarPage(),
      binding: NavigatorBarBinding(),
    ),
    GetPage(
      name: AppRoutes.SETTING,
      page: () => SettingPage(),
      binding: SettingBinding(),
    ),
    GetPage(
      name: AppRoutes.BROWSER,
      page: () => BrowserPage(),
      binding: BrowserBinding(),
    ),
    GetPage(
      name: AppRoutes.STAKING_DASHBOARD,
      page: () => StakingDashboardPage(),
      binding: StakingDashboardBinding(),
    ),
    GetPage(
      name: AppRoutes.GOVERNANCE,
      page: () => GovernancePage(),
      binding: GovernanceBinding(),
    ),
    GetPage(
      name: AppRoutes.SEND,
      page: () => SendPage(),
      binding: SendBinding(),
    ),
    GetPage(
      name: AppRoutes.STAKING,
      page: () => StakingPage(),
      binding: StakingBinding(),
    ),
    GetPage(
      name: AppRoutes.UNSTAKING,
      page: () => UnstakingPage(),
      binding: UnstakingBinding(),
    ),
    GetPage(
      name: AppRoutes.REWARDS,
      page: () => RewardsPage(),
      binding: RewardsBinding(),
    ),
    GetPage(
      name: AppRoutes.ACCOUNT,
      page: () => AccountPage(),
      binding: AccountBinding(),
    ),
    GetPage(
      name: AppRoutes.BOOK,
      page: () => BookPage(),
      binding: BookBinding(),
    ),
    GetPage(
      name: AppRoutes.PROPOSAL,
      page: () => ProposalPage(),
      binding: ProposalBinding(),
    ),
    GetPage(
      name: AppRoutes.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: AppRoutes.SHOW_MNEMONIC,
      page: () => ShowMnemonicPage(),
      binding: ShowMnemonicBinding(),
    ),
    GetPage(
      name: AppRoutes.QRSCANNER,
      page: () => QrScannerPage(),
      binding: QrScannerBinding(),
    ),
    GetPage(
      name: AppRoutes.CREATEBOOK,
      page: () => CreateBookPage(),
      binding: CreateBookBinding(),
    ),
    GetPage(
      name: AppRoutes.SUCCESSFULTRANSACTION,
      page: () => SuccessfulTransactionPage(),
      binding: SuccessfulTransactionBinding(),
    ),
    GetPage(
      name: AppRoutes.FAILDTRANSACTION,
      page: () => FaildTransactionPage(),
      binding: FaildTransacctionBinding(),
    ),
    GetPage(
        name: AppRoutes.PHONE,
        page: () => PhonePage(),
        binding: PhoneBinding()),
    GetPage(name: AppRoutes.OPT, page: () => OptPage(), binding: OptBindign()),
    GetPage(
      name: AppRoutes.WALLET_CHANGE,
      page: () => WalletChangePage(),
      binding: WalletChangeBinding(),
    ),
     GetPage(
      name: AppRoutes.NOTIFICATION,
      page: () => NotificationPage(),
      binding: NotificationBinding(),
    ),
    GetPage(
      name: AppRoutes.NFTS,
      page: () => NftsPage(),
      binding: NftsBinding(),
    ),
  ];
}
