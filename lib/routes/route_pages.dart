import 'package:adescrow_app/routes/routes.dart';
import 'package:adescrow_app/views/auth/fa_verify_screen/fa_verify_screen.dart';
import 'package:get/get.dart';

import '../backend/backend_utils/network_check/no_internet_screen.dart';
import '../bindings/add_new_escrow_screen_binding.dart';
import '../bindings/buyer_payment_screen_binding.dart';
import '../bindings/conversation_binding.dart';
import '../bindings/current_balance_screen_binding.dart';
import '../bindings/dashboard_screen_binding.dart';
import '../bindings/email_verify_screen_binding.dart';
import '../bindings/forgot_otp_screen_binding.dart';
import '../bindings/login_screen_binding.dart';
import '../bindings/onboard_screen_binding.dart';
import '../bindings/register_screen_binding.dart';
import '../bindings/splash_screen_binding.dart';
import '../bindings/welcome_screen_binding.dart';
import '../views/auth/forgot_password_otp_screen/forgot_password_otp_screen.dart';
import '../views/auth/kyc_form_screen/kyc_form_screen.dart';
import '../views/auth/login_screen/login_screen.dart';
import '../views/auth/register_otp_screen/register_otp_screen.dart';
import '../views/auth/register_screen/register_screen.dart';
import '../views/auth/reset_pass_screen/reset_pass_screen.dart';
import '../views/before_auth/onboard_screen/onboard_screen.dart';
import '../views/before_auth/splash_screen/splash_screen.dart';
import '../views/before_auth/welcome_screen/welcome_screen.dart';
import '../views/dashboard/dashboard_screen.dart';
import '../views/dashboard/my_escrow_screens/add_new_escrow_preview_screen/add_new_escrow_preview_screen.dart';
import '../views/dashboard/my_escrow_screens/add_new_escrow_screen/add_new_escrow_screen.dart';
import '../views/dashboard/my_escrow_screens/buyer_payment_manual_screen/buyer_payment_manual_screen.dart';
import '../views/dashboard/my_escrow_screens/buyer_payment_manual_screen/buyer_payment_tatum_screen.dart';
import '../views/dashboard/my_escrow_screens/buyer_payment_screen/buyer_payment_screen.dart';
import '../views/dashboard/my_escrow_screens/conversation_screen/conversation_screen.dart';
import '../views/dashboard/my_escrow_screens/escrow_manual_screen/escrow_manual_screen.dart';
import '../views/dashboard/my_escrow_screens/escrow_manual_screen/escrow_tatum_screen.dart';
import '../views/dashboard/my_wallets_screens/add_money_screen/add_money_manual_screen.dart';
import '../views/dashboard/my_wallets_screens/add_money_screen/add_money_preview_screen.dart';
import '../views/dashboard/my_wallets_screens/add_money_screen/add_money_screen.dart';
import '../views/dashboard/my_wallets_screens/add_money_screen/add_money_tatum_screen.dart';
import '../views/dashboard/my_wallets_screens/current_balance_screen/current_balance_screen.dart';
import '../views/dashboard/my_wallets_screens/money_exchange_screen/money_exchange_preview_screen.dart';
import '../views/dashboard/my_wallets_screens/money_exchange_screen/money_exchange_screen.dart';
import '../views/dashboard/my_wallets_screens/money_out_screen/money_out_manual_screen.dart';
import '../views/dashboard/my_wallets_screens/money_out_screen/money_out_preview_screen.dart';
import '../views/dashboard/my_wallets_screens/money_out_screen/money_out_screen.dart';
import '../views/dashboard/my_wallets_screens/transactions_screen/transaction_tatum_screen.dart';
import '../views/dashboard/my_wallets_screens/transactions_screen/transactions_screen.dart';
import '../views/dashboard/notification_screen/notification_screen.dart';
import '../views/dashboard/profiles_screens/change_pass_screen/change_pass_screen.dart';
import '../views/dashboard/profiles_screens/fa_security_screen/fa_security_screen.dart';
import '../views/dashboard/profiles_screens/update_profile_screen/update_profile_screen.dart';


class RoutePageList {
  static var list = [
    GetPage(
      name: Routes.noInternetScreen,
      page: () => const NoInternetScreen(),
    ),

    GetPage(
      name: Routes.splashScreen,
      page: () => const SplashScreen(),
      binding: SplashBinding(),
    ),

    GetPage(
      name: Routes.onboardScreen,
      page: () => const OnboardScreen(),
      binding: OnboardBinding(),
    ),

    GetPage(
      name: Routes.welcomeScreen,
      page: () => WelcomeScreen(),
      binding: WelcomeBinding(),
    ),

    GetPage(
      name: Routes.loginScreen,
      page: () => const LoginScreen(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: Routes.faVerifyScreen,
      page: () => const FAVerifyScreen(),
    ),
    GetPage(
      name: Routes.forgotOTPScreen,
      page: () => const ForgotPasswordOTPScreen(),
      binding: ForgotOTPBinding()
    ),
    GetPage(
      name: Routes.resetPassScreen,
      page: () => const ResetPassScreen(),
    ),

    GetPage(
      name: Routes.registerScreen,
      page: () => const RegisterScreen(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: Routes.registerOTPScreen,
      page: () => const RegisterOTPScreen(),
      binding: EmailVerifyBinding()
    ),
    GetPage(
      name: Routes.kycFormScreen,
      page: () => KYCFormScreen(),
      // binding: KYCBinding()
    ),



    GetPage(
      name: Routes.dashboardScreen,
      page: () => const DashboardScreen(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: Routes.notificationScreen,
      page: () => const NotificationScreen(),
    ),

    GetPage(
      name: Routes.conversationScreen,
      page: () => ConversationScreen(),
      binding: ConversationBinding()
    ),
    GetPage(
      name: Routes.addNewEscrowScreen,
      page: () => const AddNewEscrowScreen(),
      binding: AddNewEscrowBinding()
    ),
    GetPage(
      name: Routes.addNewEscrowPreviewScreen,
      page: () => const AddNewEscrowPreviewScreen(),
    ),
    GetPage(
      name: Routes.escrowManualScreen,
      page: () => EscrowManualScreen(),
    ),
    GetPage(
      name: Routes.escrowTatumScreen,
      page: () => EscrowTatumScreen(),
    ),
    GetPage(
      name: Routes.buyerPaymentScreen,
      page: () => const BuyerPaymentScreen(),
      binding: BuyerPaymentBinding()
    ),
    GetPage(
      name: Routes.buyerPaymentManualScreen,
      page: () => BuyerPaymentManualScreen(),
    ),
    GetPage(
      name: Routes.buyerPaymentTatumScreen,
      page: () => BuyerPaymentTatumScreen(),
    ),


    GetPage(
      name: Routes.currentBalanceScreen,
      page: () => CurrentBalanceScreen(),
      binding: CurrentBalanceBinding(),
    ),

    GetPage(
      name: Routes.addMoneyScreen,
      page: () => const AddMoneyScreen(),
    ),
    GetPage(
      name: Routes.addMoneyManualScreen,
      page: () => AddMoneyManualScreen(),
    ),
    GetPage(
      name: Routes.addMoneyTatumScreen,
      page: () => AddMoneyTatumScreen(),
    ),
    GetPage(
      name: Routes.addMoneyScreenPreview,
      page: () => const AddMoneyPreviewScreen(),
    ),

    GetPage(
      name: Routes.moneyOutScreen,
      page: () => const MoneyOutScreen(),
    ),
    GetPage(
      name: Routes.moneyOutScreenPreview,
      page: () => const MoneyOutPreviewScreen(),
    ),
    GetPage(
      name: Routes.moneyOutManualScreen,
      page: () => MoneyOutManualScreen(),
    ),

    GetPage(
      name: Routes.moneyExchangeScreen,
      page: () => const MoneyExchangeScreen(),
    ),
    GetPage(
      name: Routes.moneyExchangeScreenPreview,
      page: () => const MoneyExchangePreviewScreen(),
    ),

    GetPage(
      name: Routes.transactionsScreen,
      page: () => const TransactionsScreen(),
    ),

    GetPage(
      name: Routes.updateProfileScreen,
      page: () => const UpdateProfileScreen(),
    ),
    GetPage(
      name: Routes.changePasswordScreen,
      page: () => const ChangePassScreen(),
    ),
    GetPage(
      name: Routes.faSecurityScreen,
      page: () => const FASecurityScreen(),
    ),
    GetPage(
      name: Routes.transactionsScreen,
      page: () => const TransactionsScreen(),
    ),
    GetPage(
      name: Routes.transactionsTatumScreen,
      page: () => TransactionTatumScreen(),
    ),
  ];
}
