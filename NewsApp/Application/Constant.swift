//
//  NewsApp
//
//  Created by Aman Prajapati on 10/5/17.
//  Copyright © 2017 Aman Prajapati. All rights reserved.
//

import Foundation
import UIKit

let MainainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)


let userDefault = UserDefaults.standard
let appDelegate = UIApplication.shared.delegate! as! AppDelegate
let notificationCenter = NotificationCenter.default
var splashScreenDuration = 2
let constatLimit = 20 // This Limitation affect in whole project
let constatMyGearLimit = 200 // This Limitation affect in My Gear
let constatBigLimit = 3000
let tableviewTopSpace:CGFloat = 15
let localizedShared = LocalizeHelper.sharedLocalSystem()

internal let kPlacesAPIKey = "AIzaSyC1rf-WYryQRhD-lcHC8WQRi3oprEskFpU"
internal let kMapsAPIKey = "AIzaSyBppMjqp2KUZmAOtw8UFbhcQCdYm1yLKWU"
let kGoogleClientID = "380014634110-9fturiakagp8plh0eegkmnfiqofpmudg.apps.googleusercontent.com"
let kFaceBookId = "1802162386751124"

let placeholdeImage = UIImage(named: "placeholderImage")

struct MyUserDefault {
    
    static let USER_ADDRESS = "address"
    static let USER_EMAIL = "email"
    static let USER_FIRSTNAME = "fierstname"
    static let USER_ID = "user_id"
    static let USER_ROLE_ID = "role_id"
    static let USER_STATUS = "status"
    static let USER_PHONE = "phone_number'"
    static let SOCIAL_LOGIN = "social_login"
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
    static let kToChangePasswordFromHome = "toChangePasswordViewControllerFromHome"
    static let kFlashDetail = "toFlashDetailScreen"
    static let kListDetail = "toListDetailScreen"
    static let kJobDetail = "toJobDetail"
    static let categoryView = "toCategorySelectionViewControllerFromHome"
    static let postjobView = "toPostJobViewController"
    static let kToCategoryFromJobPost = "toCategorySelectionFromJobPost"
    static let kToReviewListingScreen = "toReviewListingScreen"
    static let ktoSubmitListingView = "toSubmitListingView"
    static let kToGiveReviewViewController = "toGiveReviewViewController"
    static let kToEditProfile = "toEditProfileViewControllerFromHome"
}

//MARK:- Storyboard ID
struct StoryBoardId {
    static let loginView = "loginViewStoryBoardID"
    static let homeNavigation = "HomeNavigationController"
}

//MARK:- URLs
struct StaticURL{
    
    static let BASE_URL = "http://repairzone4.in/B2C/"
    static let IMAGE_URL = "http://repairzone4.in/B2C/files/"
}

//MARK:- PATH
struct PATH{
    
    static let SIGNUP = "\(StaticURL.BASE_URL)User/App_Registration"
    static let LOGIN = "\(StaticURL.BASE_URL)User/App_login"
    static let FORGOT_PASSWORD = "\(StaticURL.BASE_URL)User/App_forgot_password"
    static let RESET_PASSWORD = "\(StaticURL.BASE_URL)User/App_ChangePassword"
    static let EDIT_PROFILE = "\(StaticURL.BASE_URL)User/App_EditProfile"
    static let SOCIAL_LOGIN = "\(StaticURL.BASE_URL)User/App_CheckSocialLogin"
    
    static let FLASH = "\(StaticURL.BASE_URL)FlashTab/App_FlashTabData"
    static let LIST = "\(StaticURL.BASE_URL)ListTab/App_ListTabData"
    static let BULLETIN = "\(StaticURL.BASE_URL)BulletinTab/App_BulletinTabData"
    static let MEDIA = "\(StaticURL.BASE_URL)MediaTab/App_MediaTabData"
    static let JOB = "\(StaticURL.BASE_URL)Job/App_Get_Job"
    static let CATEGORY = "\(StaticURL.BASE_URL)Category/App_GetCategoryRegion"
    static let POSTJOB = "\(StaticURL.BASE_URL)Job/App_Add_Job"
    static let REVIEW_LIST = "\(StaticURL.BASE_URL)ListTab/App_Get_Review"
    static let SUBMIT_REVIEW = "\(StaticURL.BASE_URL)ListTab/App_Add_Review_Rating"
    static let LIST_DETAIL = "\(StaticURL.BASE_URL)ListTab/App_One_List"
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

struct StroryBoardIdentifier {
    static let landingScreenIdentifier = "loginscreen"
    static let categoryViewController = "categorySelectionViewController"
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

enum headerEnum: String {
   
    case eFlash = "flash"
    case eRegion = "region"
    case eListing = "listing"
    case eMedia = "mediad"
    case eBulletin = "bulletin"
    case eJob = "job"
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
