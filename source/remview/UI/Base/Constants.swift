//
//  Constants.swift
//  iService
//
//  Created by Dev on 10/11/21.
//

import Foundation
import UIKit

struct Constants {
    private init() {
        
    }
    
    //Local Action manager
    static let ACTION_EXPIRED_TOKEN = "ACTION_EXPIRED_TOKEN";
    
    // payment type
    static let  PAYMENT_TYPE_CASH = 1;
    static let  PAYMENT_TYPE_CARD = 2;
    static let  PAYMENT_TYPE_TRANSFER = 3;
    static let  DONE=1;
    static let  CANCEL=2;
    
    static let  MALE =  1;
    static let  FEMALE =  2;
    static let OTHER = 3;
    
    static let OK =  "200";
    static let ERROR =  "404";
    static let NOT_OK =  "400";
    
    static let PASSWORD_REGEX =  "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$";
    static let PVALID_EMAIL_ADDRESS_REGEX =
    "^[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,6}$";
    
   
    
    
    // IG security name
    static let IG_ACCOUNT_PRIVACY = ["Your account is private, only people you approve can see your photos and videos on Instagram. Your existing followers won't be affected","","Your account is not private. Everyone will be able to see your photos and videos on Instagram. If you are an influencer or public figure and it is acceptable to you. You can ignore this."]
    static let IG_ACTIVTY_STATUS = ["As a security precaution, it is always better not to let others know when is your last active status.","This allows accounts you follow and anyone you message to see when you were last active on Instagram apps",""]
    static let IG_STORY_SHARING = ["Restricting others to share your story is recommended as you might not know who they share the story to.","Let people share your story as messages. If you are an influencer or public figure and it is acceptable to you. You can ignore this.",""]
    static let IG_2FA = ["authentication is enabled","","Your 2FA Authentication is not enabled. Please do so to increase the security of your Instagram account"]
    
    // lK security name
    static let LK_PASSWORD_CHANGE = ["Date Changed Less than 3 months","Do practice good password changing practice.","You have not changed your password for more than 1 year. Please change it as soon as possible. You are subjecting yourself to compromise from data breaches."]
    static let LK_ACTIVE_SESSION = ["This is normal as users will log in via different devices and stay login.","You might want to check those sessions that stayed login in your Linkedin Profile.","It is quite abnormal to have more than 6 sessions stayed login in your Linkedin Profile. Please go to your Linkedin and verify. Most of us don\'t sign out when we are done using Linkedin even for temporary usage."]
    static let LK_DEVICES = ["There are %@ devices associated with this account.\nThis is usually normal as most users would have two devices like their mobile phone and laptop remembering their credentials for Linkedin. Do remove the devices in your Linkedin Settings if you do not want any devices to remember your credentials.",
                             "There are %@ devices associated with this account.\nYou might want to check the devices that remember your credentials for Linkedin.",
                             "There are %@ devices associated with this account.\nIt is quite abnormal to have more than 6 devices that remember your password for Linkedin. Please check immediately and remove the devices that you no longer own or use."]
    static let LK_2FA = ["Your 2FA authentication is enabled","","Your 2FA Authentication is not enabled. Please do so to increase the security of your Linkedin account"]
    
    static let DV_LATEST_OS = ["Your device is running the latest OS.","","Your device is running iOS version \(UIDevice.current.systemVersion). Please update to the latest version to be up to date on the patches."]
    static let DV_SECURITY_DEVICE = ["Your 2 Factor Authentication is enabled.","","Your device does not has 2 Factor Authentication enabled. This will compromise your device and data security. Please enable it."]
    
    
    // FB security name
    static let FB_2FA = ["Meta (Facebook) ask for a login code if we notice an attempted login from an unrecognized device or browser.","","Turn on your two-factor authentication to reduce risk of password leak and account takeover."]
    
    static let FB_UNREG_LOGIN = ["Meta (Facebook) let you know if anyone logs in from a device or browser you don't usually use","","It is recommended to get alerts. You will be able to get notified if there are unauthorized access into your account."]
    static let FB_FRIEND_LOCKED_OUT = ["Your trusted contacts are friends you chose who can securely help if you ever have trouble accessing your account.","","This is a backup feature, in case you are logged out of your own account."]
    static let FB_FACE_RECOGNITION = ["The Face Recognition setting is no longer available and the experiences it made possible have been disabled. If your setting was turned on, we can no longer recognize you and your Template will soon be deleted.","",""]
    static let FB_LOCATION_SETTING = ["Good. Your location history is OFF.\nWhen Location History is turned off, Facebook will stop adding new information to your Location History, which you can view in your Location Settings. You may still share your precise location when you use our products. For example, Facebook may receive and store location data when you check-in, RSVP as attending an event or post photos that include location information. ","Not recommended from the privacy point of view. Unless you are an Influencer or need to use this feature to get more recommendations from Facebook.",""]
    
    static let FB_LOCATION_SERVICES = ["","Recommend to put to Never for the normal user.\n\nIf you like/need this feature, choose While Using the App. There is no need for Facebook to know where you are when you are not using the app.\n\nLocation Services is a setting on your phone or other mobile devices. You have the option to set Location Services to Always, While Using the App,  or Never.",""]
    static let FB_LOCATION_SERVICES_EXTRA = ["","\nWhen on, Location Services helps Facebook provide you with location features, including allowing you to post content that's tagged with your location, get more relevant ads, find places and Wi-Fi nearby and use Nearby Friends.\nYou can turn off Location Services at any time. When Location Services is turned off for this device, Facebook won't add new information to your Location History from this device, even if Location History is turned on.",""]
    static let FB_AD_SETTINGS = ["Great. It doesn't change the number of ads you'll see,\nThis setting controls whether Facebook can show you personalized ads on Instagram and Facebook based on data about your activity from our partners. If you turn off this setting, the ads you see may still be based on your activity on your accounts. They may also be based on information from a specific business that has shared a list of individuals or devices with Facebook, if Facebbok matched your profile to information on that list.","Not recommended from the privacy point of view. ",""]
    
    static let FB_OFF_ACTIVITY = ["• Turning this off will disconnect your future activity. It may take 48 hours until it's fully disconnected from your account.\n• Facebook will still receive activity from the businesses and organizations you visit. It may be used for measurement purposes and to make improvements to Facebook ads systems, but it will be disconnected from your account.\n• Your activity history will also be disconnected from your Facebook account. This does not currently include Oculus activity.\n• You'll still see the same number of ads. Your ad preferences and actions you take on Facebook will be used to show you relevant ads.","Go to http://facebook.com/off_facebook_activity to see the summary of your Off-Facebook Activity to decide to turn this OFF or remain ON.",""]
    static let FB_OFF_ACTIVITY_EXTRA = ["\nWhat is off-Facebook activity?\nOff-Facebook activity includes information that businesses and organizations share with Facebook about your interactions with them. Interactions are things like visiting their website or logging into their app with Facebook. Off-Facebook activity does not include customer lists that businesses use to show a unique group of customers relevant ads.\nHow did Facebook receive your activity?\n\nWhen you visit a website or use an app, these businesses or organizations can share information about your activity with Facebook by using Facebook business tools. Facebook use this activity to personalize your experience, such as showing you relevant ads. Facebook also require that businesses and organizations provide notice to people before using Facebook business tools.","\nWhat is off-Facebook activity?\n\nOff-Facebook activity includes information that businesses and organizations share with Facebook about your interactions with them. Interactions are things like visiting their website or logging into their app with Facebook. Off-Facebook activity does not include customer lists that businesses use to show a unique group of customers relevant ads.\nHow did Facebook receive your activity?\n\nWhen you visit a website or use an app, these businesses or organizations can share information about your activity with Facebook by using Facebook business tools. Facebook use this activity to personalize your experience, such as showing you relevant ads. Facebook also require that businesses and organizations provide notice to people before using Facebook business tools.",""]
    
    // TW security name
    static let TW_2FA = ["Great, you have your two-factor authentication turn on.","","Turn on your two-factor authentication to reduce risk of password leak and account takeover."]
    
    
    enum DeviceSecurityInf : String {
        
        case LATEST_OS = "Latest Android";
        case SECURITY_DEVICE = "Security device";
        var message : [String] {
            switch self {
            case .LATEST_OS:
                return Constants.DV_LATEST_OS
            case .SECURITY_DEVICE:
                return Constants.DV_SECURITY_DEVICE
            }
        }
        
    }
    
    enum FacebookSecurityInf : String {
        case FACEBOOK_TWO_FACTOR_AUTHENTICATION = "Two-Factor Authentication";
        case FACEBOOK_UNRECOGNIZED_LOGIN = "Get alerts about unrecognized logins";
        case FACEBOOK_LOCKED_OUT = "Trusted contact";
        case FACEBOOK_LOCATION_SETTINGS = "Location settings";
        case FACEBOOK_LOCATION_SERVICES = "Location Services";
        case FACEBOOK_AD_SETTINGS = "Ad Settings";
        case FACEBOOK_OFF_ACTIVITY = "Off-Facebook Activity";
        case FACEBOOK_FACE_RECOGNITION = "Face Recognition";
        
        var message : [String] {
            switch self {
            case .FACEBOOK_TWO_FACTOR_AUTHENTICATION:
                return Constants.FB_2FA
            case .FACEBOOK_UNRECOGNIZED_LOGIN:
                return Constants.FB_UNREG_LOGIN
            case .FACEBOOK_LOCKED_OUT:
                return Constants.FB_FRIEND_LOCKED_OUT
            case .FACEBOOK_LOCATION_SETTINGS:
                return FB_LOCATION_SETTING
            case .FACEBOOK_LOCATION_SERVICES:
                return FB_LOCATION_SERVICES
            case .FACEBOOK_AD_SETTINGS:
                return FB_AD_SETTINGS
            case .FACEBOOK_OFF_ACTIVITY:
                return FB_OFF_ACTIVITY
            case .FACEBOOK_FACE_RECOGNITION:
                return FB_FACE_RECOGNITION
            }
        }
    }
    enum TwitterSecurityInf : String {
        case TWITTER_TWO_FACTOR_AUTHENTICATION = "Two-Factor Authentication";
        
        var message : [String] {
            switch self {
            case .TWITTER_TWO_FACTOR_AUTHENTICATION:
                return Constants.TW_2FA
            }
        }
    }
    
    enum InstagramSecurityInf : String {
        
        case INSTAGRAM_ACCOUNT_PRIVACY = "Account Privacy";
        case INSTAGRAM_ACTIVITY_STATUS = "Activity Status";
        case INSTAGRAM_STORY_SHARING = "Story Sharing";
        case INSTAGRAM_TWO_FACTOR_AUTHENTICATION = "Two-Factor Authentication";
        
        var message : [String] {
            switch self {
            case .INSTAGRAM_ACCOUNT_PRIVACY:
                return Constants.IG_ACCOUNT_PRIVACY
            case .INSTAGRAM_ACTIVITY_STATUS:
                return Constants.IG_ACTIVTY_STATUS
            case .INSTAGRAM_STORY_SHARING:
                return Constants.IG_STORY_SHARING
            case .INSTAGRAM_TWO_FACTOR_AUTHENTICATION:
                return Constants.IG_2FA
            }
        }
        
    }
    enum LinkedInSecurityInf : String {
        
        case LINKEDIN_LAST_PASSWORD_CHANGE = "Password last changed";
        case LINKEDIN_TWO_FACTOR_AUTHENTICATION = "Two-Factor Authentication ";
        case LINKEDIN_SESSION = "Active session";
        case LINKEDIN_DEVICES = "Devices";
        
        
        var message : [String] {
            switch self {
            case .LINKEDIN_LAST_PASSWORD_CHANGE:
                return Constants.LK_PASSWORD_CHANGE
            case .LINKEDIN_TWO_FACTOR_AUTHENTICATION:
                return Constants.LK_2FA
            case .LINKEDIN_SESSION:
                return Constants.LK_ACTIVE_SESSION
            case .LINKEDIN_DEVICES:
                return Constants.LK_DEVICES
            }
        }
        
    }
    
    enum remediation : Int {
        case low = 0
        case medium = 1
        case high = 2
    }
    enum ActivityType : String {
        case game = "game"
        case video = "video"
        case article = "article"
    }
    
}
