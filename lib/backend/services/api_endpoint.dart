import 'package:adescrow_app/extensions/custom_extensions.dart';


class ApiEndpoint {

  // Urls ******

  static const String mainDomain = "https://jaame.autside.app";

 

  static const String baseUrl = "$mainDomain/api/v1";

  static String appSettingsURL = '/app-settings'.addBaseURl();
  static String languageURL = '/app-settings/languages'.addBaseURl();

  static String loginURL = '/user/login'.addBaseURl();
  static String forgotSendOTPURL = '/user/forgot/password/send/otp'.addBaseURl();
  static String forgotVerifyOTPURL = '/user/forgot/password/verify'.addBaseURl();
  static String resetPasswordURL = '/user/forgot/password/reset'.addBaseURl();

  /*signup section*/
  static String registrationURL = '/user/register'.addBaseURl();
  static String emailVerificationURL = '/user/email/otp/verify'.addBaseURl();
  static String signUpResendOtpURL = '/user/email/resend/code'.addBaseURl();
  static String kycFieldsURL = '/user/kyc/input-fields'.addBaseURl();
  static String kycSubmitURL = '/user/kyc/submit'.addBaseURl();

  // dashboard
  static String logOutURL = '/user/logout'.addBaseURl();
  static String deleteURL = '/user/profile/delete/account'.addBaseURl();

  static String dashboardURL = '/user/dashboard'.addBaseURl();
  static String notificationURL = '/user/user-notification'.addBaseURl();
  static String profileURL = '/user/profile'.addBaseURl();
  static String profileUpdateURL = '/user/profile/update'.addBaseURl();
  static String profileTypeUpdateURL = '/user/profile/type/update'.addBaseURl();
  static String changePasswordURL = '/user/profile/password/update'.addBaseURl();
  
  static String faFetchURL = '/user/profile/google-2fa'.addBaseURl();
  static String faStatusUpdateURL = '/user/profile/google-2fa/status/update'.addBaseURl();
  static String faVerifyURL = '/user/verify/google-2fa'.addBaseURl();

  static String addMoneyIndexURL = '/user/add-money/index'.addBaseURl();
  static String addMoneySubmitURL = '/user/add-money/submit'.addBaseURl();
  static String addMoneyManualConfirmURL = '/user/add-money/manual/payment/confirmed'.addBaseURl();

  static String addMoneyTatumURL = '/add-money/payment/crypto/address'.addBaseURl();
  static String escrowTatumURL = '/my-escrow/payment/crypto/address'.addBaseURl();
  static String escrowTatumURL2 = '/api-escrow-action/payment/crypto/address'.addBaseURl();


  static String moneyOutIndexURL = '/user/money-out/index'.addBaseURl();
  static String moneyOutSubmitURL = '/user/money-out/submit'.addBaseURl();
  static String moneyOutConfirmURL = '/user/money-out/manual/confirmed'.addBaseURl();

  static String moneyExchangeURL = '/user/money-exchange'.addBaseURl();
  static String moneyExchangeSubmitURL = '/user/money-exchange/submit'.addBaseURl();


  static String escrowIndexURL = '/user/my-escrow/index'.addBaseURl();
  static String escrowCreateURL = '/user/my-escrow/create'.addBaseURl();
  static String escrowUserCheckURL = '/user/my-escrow/user-check?userCheck='.addBaseURl();
  static String escrowSubmitURL = '/user/my-escrow/submit'.addBaseURl();
  static String escrowConfirmURL = '/user/my-escrow/confirm-escrow'.addBaseURl();
  static String escrowManualSubmitURL = '/user/my-escrow/manual/payment/confirmed'.addBaseURl();

  static String buyerPaymentIndexURL = '/user/api-escrow-action/payment/approval-pending/'.addBaseURl();
  static String buyerPaymentSubmitURL = '/user/api-escrow-action/escrow/payment/approval-submit/'.addBaseURl();
  static String buyerPaymentManualConfirmURL = '/user/api-escrow-action/approval-pending/manual/confirm'.addBaseURl();


  static String conversationURL = '/user/api-escrow-action/conversation'.addBaseURl();
  static String messageSendURL = '/user/api-escrow-action/message/send'.addBaseURl();
  static String disputeURL = '/user/api-escrow-action/dispute-payment'.addBaseURl();
  static String releasePaymentURL = '/user/api-escrow-action/release-payment'.addBaseURl();
  static String requestPaymentURL = '/user/api-escrow-action/release-request'.addBaseURl();


  static String allTransactionsURL = '/user/all-transactions'.addBaseURl();
}