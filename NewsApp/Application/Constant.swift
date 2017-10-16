//
//  NewsApp
//
//  Created by Aman Prajapati on 10/5/17.
//  Copyright © 2017 Aman Prajapati. All rights reserved.
//

import Foundation
import UIKit

let MainainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//let OnboardStoryboard: UIStoryboard = UIStoryboard(name: "Onboard", bundle: nil)


let userDefault = UserDefaults.standard
let appDelegate = UIApplication.shared.delegate! as! AppDelegate
let notificationCenter = NotificationCenter.default
var splashScreenDuration = 2
let constatLimit = 20 // This Limitation affect in whole project
let constatMyGearLimit = 200 // This Limitation affect in My Gear
let constatBigLimit = 3000

internal let kPlacesAPIKey = "AIzaSyC1rf-WYryQRhD-lcHC8WQRi3oprEskFpU"
internal let kMapsAPIKey = "AIzaSyBppMjqp2KUZmAOtw8UFbhcQCdYm1yLKWU"



struct MyUserDefault {
    static let kUDIDLogin = "Login"
    static let kUDIDLoginUser = "LoginUser"
    static let kUDIDAuthToken = "AuthToken"
    static let kChangePassword = "ChangePassword"
    static let kSetPassword = "SetPassword"
    static let kInviteUser = "InviteUser"
    static let kNotificationTrigger = "NotificationTrigger"
    static let kChangePasswordToken = "ChangePasswordToken"
    static let kSetPasswordToken = "SetPasswordToken"
    static let kUDIDPassword = "password"
    static let kUDIDDeviceId = "deviceid"
    static let kUDIDDeviceToken = "devicetoken"
    static let kCitrixCreateFolderID = "createdFolderID"
    static let kNotificationRefreshData = "notificationDataRefresh"
    static let kPermissionAsked = "PermissionAsked"
    static let kAWSAuthDetail = "AWSAuthDetail"
    static let kAllowPermission = "allowPermission"
}

//MARK:- Cell Identifier
struct CellIdentifier {
    static let kUnassignedTagCellCellIdentifier = "unassignedTagCell"
    static let kAssignedTagCellCellIdentifier = "assignedTagCell"
    static let kFilterChartCellCellIdentifier = "filterChartCell"
    static let kChartCellCellIdentifier = "chartCell"
    static let kGearDetailHeaderCellCellIdentifier = "GearDetailHeaderCell"
}

//MARK:- Segue
struct Segues {
    static let kToHomeViewControllerFromSignIn = "toHomeViewControllerFromLogin"
}
//MARK:- URLs
struct StaticURL{
    
    static let BASE_URL = "http://repairzone4.in/OLX/User/"
}

//MARK:- PATH
struct PATH{
    
    static let SIGNUP = "\(StaticURL.BASE_URL)App_Registration"
    static let LOGIN = "\(StaticURL.BASE_URL)App_login"
    static let FORGOT_PASSWORD = "\(StaticURL.BASE_URL)App_forgot_password"
}

//MARK:- Alert Titles
struct AlertTitle{
    static let kAlertTitleNoInternet = "No Internet Connection"
    static let kAlertTitleAuthenticatioError = "Authentication Error"
    static let kAlertTitleGeneralError = "Error"
    static let kAlertTitleGeneralWarning = "Warning"
    static let kAlertTitleGeneralSuccess = "Success"
    static let kAlertTitle = "Alert"
}

//MARK:- Alert
struct AlertMessages
{
    static let kAlertNoInternet = "Make sure your device is connected to internet"
    static let kAlertWebserviceError = "Something went wrong! Please try again"
    static let kAlertTouchConfiguration = "Please provide your fingerprint to next time login using touch"
    static let kAlertTouchLogin = "Authenticate using touch"
    static let kAlertTouchAuthenticationError = "There was a problem verifying your identity."
    static let kAlertDeleteTask = "Are you sure you want to delete this task?"
    static let kAlertUpdateTaskStatus = "Are you sure you want to update task status?"
    static let kAlertSessionExpired = "Your session is expired. Please login again."
}

//MARK:- Alert
struct ScreenSize {
    static let SCREEN_WIDTH: CGFloat = UIScreen.main.bounds.size.width
    static let SCREEN_HEIGHT: CGFloat = UIScreen.main.bounds.size.height
    static let SCREEN_MAX_LENGTH = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    static let SCREEM_MIN_LENGTH = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
}

//MARK:- Platform
struct Platform{
    static var isSimulator: Bool{
        return TARGET_OS_SIMULATOR != 0
    }
}

//MARK:- Device Type
struct DeviceType{
    static let IS_IPHONE_4_OR_LESS = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH < 568.0
    static let IS_IPHONE_5 = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 568.0
    static let IS_IPHONE_6 = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 667.0
    static let IS_IPHONE_6P = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 736.0
    static let IS_IPAD = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 1024.0
    static let IS_IPAD_PRO = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 1366.0
}

//MARK:- Device iOS Version
struct iOSVersion{
    static let SYS_VERSION_FLOAT = (UIDevice.current.systemVersion as NSString).floatValue
    static let iOS7 = (iOSVersion.SYS_VERSION_FLOAT >= 7.0 && iOSVersion.SYS_VERSION_FLOAT < 8.0)
    static let iOS8 = (iOSVersion.SYS_VERSION_FLOAT >= 8.0 && iOSVersion.SYS_VERSION_FLOAT < 9.0)
    static let iOS9 = (iOSVersion.SYS_VERSION_FLOAT >= 9.0 && iOSVersion.SYS_VERSION_FLOAT < 10.0)
    static let iOS10 = (iOSVersion.SYS_VERSION_FLOAT >= 10.0 && iOSVersion.SYS_VERSION_FLOAT < 11.0)
}

//MARK:- DateFormatter
struct StaticDateFormatter {
    static let FORMATTER_YYYY_MM_DD = "yyyy-MM-dd"
    static let FORMATTER_DD_MMM_YYYY = "dd MMM yyyy"
    static let FORMATTER_DD_MMMM_YYYY = "dd MMMM yyyy"
    static let FORMATTER_DD_MMM_YYYY_HH_MM = "dd MMM yyyy HH:mm"
    static let FORMATTER_YYYY_MM_DD_T_HH_MM_SS_SSS = "yyyy-MM-dd'T'HH:mm:ss.SSSX"
    static let FORMATTER_YYYY_MM_DD_T_HH_MM_SS_Z = "yyyy-MM-dd'T'HH:mm:ssZ"
    static let FORMATTER_YYYY_MM_DD_HH_MM_SS_Z = "yyyy-MM-dd HH:mm:ss Z"
    static let FORMATTER_MMM = "MMM"
    static let FORMATTER_DD = "dd"
    static let FORMATTER_EEEE = "EEEE"
    static let FORMATTER__HH_MM_A = "HH:mm a"
    static let FORMATTER__HH_MM_AP = "hh:mm a"
    static let FORMATTER__HH_MM_SS_A = "hh:mm:ss a"
    static let FORMATTER_MMM_DD_YYYY = "MMMM dd, yyyy"
    static let FORMATTER_DD_MM_YYYY = "MM/dd/yyyy"
    //static let FORMATTER_MM_DD_YYYY = "dd/MM/yyyy"
    static let FORMATTER_MM_DD_YYYY_SPACE = "MM / dd / yyyy"
    static let FORMATTER_HH_MM = "h:mm"
    static let FORMATTER_HH_MM_AP = "hh:mm a"
    static let FORMATTER_MM_DD_YYYY_SPACE_WITH_TIME = "MM / dd / yyyy HH:mm a"
    static let FORMATTER_DD_MM_YYYY_TIME = "MM/dd/yyyy hh:mm a"
    static let FORMATTER_MMM_DD = "MMM dd"
    static let FORMATTER_MM_DD_YYYY = "MM-dd-yyyy"
    static let FORMATTER_EEEE_MMM_DD_YYYY = "EEEE, MMMM dd, yyyy"
    static let FORMATTER_MMM_YYYY = "MMMM, yyyy"
    static let FORMATTER_YYYY = "yyyy"
    static let FORMATTER_H_A = "h a"
}

//MARK:- Application Font

struct CustomeFont {
    static let AvenirNext_Regular = "AvenirNext-Regular"
    static let VarelaRound_Regular = "VarelaRound-Regular" //VarelaRound-Regular.ttf
}

//MARK:- Application Enums

public enum DateTimeFor:Int, Description_Enum_protocol{
    case day = 0
    case week = 1
    case month = 2
    case year = 3
    case next = 4
    case previous = 5
    
    var description: String {
        switch self {
        case .day: return "day"
        case .week : return "week"
        case .month: return "month"
        case .year : return "year"
        case .next : return "next"
        case .previous: return "previous"
        }
    }
}


public enum PickDropType:String{
    case OnePickupOneDropoff = "one_pickup_one_dropoff"
    case TwoPickupOneDropoff = "two_pickup_one_dropoff"
    case OnePickupTwoDropoff = "one_pickup_two_dropoff"
}

public enum NavigationColor{
    case Default
}

extension NavigationColor {
    var value: UIColor {
        get {
            switch self {
            case .Default:
                return UIColor.blue
            }
        }
    }
}

protocol Description_Enum_protocol {
    var description: String { get }
}

protocol Int_Enum_protocol {
    var Index: Int { get }
}

protocol Color_Enum_protocol {
    var color: UIColor { get }
}

public enum activityType: Int, Description_Enum_protocol{
    case Practice = 0
    case Game = 1
    case Scrimmage = 2
    case Outside_of_Game = 3
    
    var description: String {
        switch self {
        case .Practice: return "Practice"
        case .Game: return "Game"
        case .Scrimmage : return "Scrimmage"
        case .Outside_of_Game: return "Outside of Game"
        }
    }
}

public enum ampm: Int, Description_Enum_protocol {
    case am = 0
    case pm = 1
    
    var description: String {
        switch self {
        case .am: return "AM"
        case .pm: return "PM"
        }
    }
}

public enum locationType: Int, Description_Enum_protocol{
    case Indoor = 0
    case Outdoor = 1
    
    var description: String {
        switch self {
        case .Indoor: return "Indoor"
        case .Outdoor: return "Outdoor"
        }
    }
}

public enum locationSurface: Int, Description_Enum_protocol{
    case Grass = 0
    case Turf = 1
    case Pavement = 2
    case Wood = 3
    case Clay = 4
    case Ice = 5
    case Mat = 6
    
    var description: String {
        switch self {
        case .Grass: return "Grass"
        case .Turf: return "Turf"
        case .Pavement: return "Pavement"
        case .Wood: return "Wood"
        case .Clay: return "Clay"
        case .Ice: return "Ice"
        case .Mat: return "Mat"
        }
    }
}

public enum breathingStatus: Int, Description_Enum_protocol{
    case Normal = 0
    case Abnormal = 1
    case Elevated = 2
    
    var description: String {
        switch self {
        case .Normal: return "Normal"
        case .Abnormal: return "Abnormal"
        case .Elevated: return "Elevated"
        }
    }
}

public enum pulseStatus: Int, Description_Enum_protocol{
    case Normal = 0
    case Abnormal = 1
    case Elevated = 2
    case Low = 3
    
    var description: String {
        switch self {
        case .Normal: return "Normal"
        case .Abnormal: return "Abnormal"
        case .Elevated: return "Elevated"
        case .Low: return "Low"
        }
    }
}

public enum participationStatus: Int, Description_Enum_protocol{
    case ClearToPractice = 0
    case ClearToPlay = 1
    case CannotPlay = 2
    
    var description: String {
        switch self {
        case .ClearToPractice: return "Cleared to practice"
        case .ClearToPlay: return "Clear to Play"
        case .CannotPlay: return "Cannot Play"
        }
    }
}

public enum referToList: Int, Description_Enum_protocol{
    case Physcian = 0
    case NotReferred = 1
    
    var description: String {
        switch self {
        case .Physcian: return "Physician"
        case .NotReferred: return "Not Referred"
        }
    }
}

public enum referList: Int, Description_Enum_protocol{
    case Physcian = 0
    case NotReferred = 1
    
    var description: String {
        switch self {
        case .Physcian: return "Physcian"
        case .NotReferred: return "Not Referred"
        }
    }
}

enum FILE_FORMAT:Int, Description_Enum_protocol{
    case pdf = 0
    case image = 1
    
    var description: String {
        switch self {
        case .pdf: return "application/pdf"
        case .image: return "image/jpeg"
        }
    }
}

enum MyError: Error {
    case FoundNil(String)
}

//MARK:- Application extention


extension String {
    
    func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSFontAttributeName: font]
        let size = self.size(attributes: fontAttributes)
        return size.width
    }
    
    func heightOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSFontAttributeName: font]
        let size = self.size(attributes: fontAttributes)
        return size.height
    }
}
