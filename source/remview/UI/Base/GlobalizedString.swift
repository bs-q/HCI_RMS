//
//  GlobalizedString.swift
//  iService
//
//  Created by Dev on 10/11/21.
//

import Foundation
struct GlobalizedString {

    private init() {
    }
    static let loadingMsg = "loading_msg";
    static let confirmOk = "confirm_ok";
    static let continueMsg = "continue";
    static let error = "error";

    /**
     Login screen
     */
    static let loginLoginTitle = "login_login_title";
    static let loginPhoneHint = "login_phone_hint";
    static let loginPasswordHint = "login_password_hint";
    static let loginButtonLogin = "login_button_login";
    static let loginRegisterFirst = "login_regsiter_first";
    static let loginRegisterLast = "login_regsiter_last";
    static let loginAlertPhoneInvalid = "login_alert_phone_invalid";
    static let loginAlertPasswordInvalid = "login_alert_password_invalid";
    static let loginAccountError = "login_account_error";

    /**
     Register screen
     */
    static let registerRegisterTitle = "register_register_title";
    static let inputPhoneNumber = "input_phone_number";
    static let sendOtpNumber = "send_OTP_number";
    static let createNewAccount = "create_new_account";
    static let back = "back";
    static let registerPhoneInvalid = "register_phone_invalid";

    /**
    Validate screen
    */
    static let validateOtpError = "validate_otp_error";
    static let otpCode = "otp_code";
    static let pleaseInputOtpCode = "please_input_otp_code";
    static let validateNow = "validate_now";
    static let resentOtpCode = "resent_otp_code";
    public static let otpCodeResent = "otp_code_resent";
    static let notInputOtpCode = "not_input_otp_code";
    static let createAccountSuccess = "create_account_success";

    /**
     Create new account screen	
     */
    static let inputName = "input_name"
    static let inputEmail = "input_email";
    static let inputPhone = "input_phone";
    static let inputPassword = "input_password";
    static let acceptTerm = "accept_term";
    static let invalidInputName = "invalid_input_name";
    static let invalidInputEmail = "invalid_input_email";
    static let invalidInputPhone = "invalid_input_phone";
    static let invalidInputPwd = "invalid_input_pwd";
    static let invalidAcceptTerm = "invalid_accept_term";
    static let phoneNumberUsed = "phone_number_used";
    static let createAccountApiError = "create_account_api_error";

    /**
     Main screen
      */
    static let homeTabItemTitle = "home_tab_item_title";
    static let activityTabItemTitle = "activity_tab_item_title";
    static let newsTabItemTitle = "news_tab_item_title";
    static let accountTabItemTitle = "account_tab_item_title";
    
    /**
     Home screen
     */
    
    /**
     Activity screen
     */
    static let cash = "cash";
    static let card = "card";
    static let done = "done";
    static let transfer = "transfer";
    static let activityScreenTitle = "activity_screen_title";
    /**
     Details screen
     */
    static let detailsScreenTitle = "details_screen_title";
    static let contractInfo = "contact_info";
    static let contractId = "contract_id";
    static let startDate = "start_date";
    static let endDate = "end_date";
    static let payment = "payment";
    static let serviceList = "service_list";
    static let receipt = "receipt";
    static let transportFee = "transport_fee";
    static let discount = "discount";
    static let total = "total";
    static let rating = "rating";
    static let veryGood = "very_good";
    static let good = "good";
    
    /**
     Account screen
     */
    static let accountInformation = "account_information";
    static let logout = "logout";
    static let information = "information";

    /**
     Account info screen
     */
     static let changeInfo = "change_info";
     static let phoneNumber = "phone_number";
     static let sex = "sex";
     static let birthDay = "birthday";
     static let email = "email";
     static let notUpdate = "not_update";
     static let male = "male";
     static let female = "female";
    
     /**
      Edit info screen
      */
     static let editInfo = "edit_info";
     static let currentPassword = "current_password";
     static let newPassword = "new_password";
     static let invalidInputCurrentPwd = "invalid_input_current_pwd";
     static let other = "other";
     static let confirm = "confirm";
    static let wrongPassword = "wrong_password";
    static let uploadImageError = "upload_image_error";
    
    // choose service screen
    static let chooseServiceMsg = "choose_service_message";
    static let maximumServiceMsg = "maximum_service_message";
    
}
