//
//  Utility.swift
//  Emotolytics
//
//  Created by Chirag Vindhani on 8/8/17.
//  Copyright © 2017 Codal Systems. All rights reserved.
//

import Foundation
import UIKit
import Photos
import LocalAuthentication
import JDStatusBarNotification
import IBAnimatable
//import PullToRefreshSwift
//import SVProgressHUD
//import NVActivityIndicatorView

//let notificationsAlert = CWStatusBarNotification()

//MARK:- multiplier setting

extension NSLayoutConstraint {
    /**
     Change multiplier constraint
     
     - parameter multiplier: CGFloat
     - returns: NSLayoutConstraint
     */
    func setMultiplier(multiplier:CGFloat) -> NSLayoutConstraint {
        
        NSLayoutConstraint.deactivate([self])
        
        let newConstraint = NSLayoutConstraint(
            item: firstItem,
            attribute: firstAttribute,
            relatedBy: relation,
            toItem: secondItem,
            attribute: secondAttribute,
            multiplier: multiplier,
            constant: constant)
        
        newConstraint.priority = priority
        newConstraint.shouldBeArchived = self.shouldBeArchived
        newConstraint.identifier = self.identifier
        
        NSLayoutConstraint.activate([newConstraint])
        return newConstraint
    }
}

//MARK:- Pull To Refresh View

//func refreshDesignedView() -> PullToRefreshOption {
//    var options = PullToRefreshOption()
//    options.backgroundColor = UIColor.clear
//    options.indicatorColor = Colors.dafaultBlue.withAlphaComponent(0.8)
//    return options
//}
//
////MARK:- Load More View
//
//func loadMoreDesignedView() -> UIView {
//    let activityView = NVActivityIndicatorView.init(frame: CGRect(x: 0, y: 0, width: ScreenSize.SCREEN_WIDTH, height: 50), type: .ballTrianglePath, color: Colors.dafaultBlue.withAlphaComponent(0.8), padding: 10 )
//    activityView.backgroundColor = UIColor.white
//    return activityView
//}


//MARK:- Check Nill or not

func isVariableNotNill(varData:String?) -> String {
    if varData != nil {
        if (varData?.isEmpty)! {
            return "NA"
        }
        return varData!
    }
    return "NA"
}

//MARK:- Return Yes Or No

func isVariableYesOrNo(varFlag:Bool?) -> String {
    if varFlag != nil {
        if varFlag! {
            return "Yes"
        }
        else {
            return "No"
        }
    }
    return "NA"
}

//MARK:- IBAnimatable Methods
func animationSlideFade(inFromRight:Bool,animateView:AnimatableView)
{
    if inFromRight {
        animateView.animationType = .squeezeFade(way: .out, direction: .right)
        animateView.delay = 0.1
        animateView.autoRun = false
        
    }
    else
    {
        animateView.animationType = .squeezeFade(way: .in, direction: .right)
        animateView.delay = 0.1
        animateView.autoRun = false
    }
    animateView.layer.cornerRadius = 2
    animateView.duration = 0.5
    animateView.damping = 1.0
    animateView.velocity = 0.0
    animateView.force = 1.0
    animateView.animate(animateView.animationType)
}

//MARK: - Enable/Disable button

func enableButton(btn:UIButton)
{
    btn.isEnabled = true
    btn.alpha = 1.0
}

func disableButton(btn:UIButton)
{
    btn.isEnabled = false
    btn.alpha = 0.7
}

//MARK: - Email Validation
func isValidEmail(testStr:String) -> Bool {
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
    let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailTest.evaluate(with: testStr)
}

//MARK:- Bold String
//func getBoldString(firstString:String, secondString:String,fontSize:CGFloat) -> NSAttributedString {
//    let normalFont:UIFont = UIFont(name: CustomeFont.Lato_Regular, size: fontSize)!
//    let boldFont:UIFont = UIFont(name: CustomeFont.Lato_Heavy, size: fontSize)!
//    
//    let normalAttribute = [NSFontAttributeName:normalFont]
//    let boldAttribute = [NSFontAttributeName:boldFont]
//    
//    let staticText = NSMutableAttributedString(string:firstString, attributes:boldAttribute)
//    let responseText = NSMutableAttributedString(string:" \(secondString)", attributes:normalAttribute)
//    let combination = NSMutableAttributedString()
//    combination.append(staticText)
//    combination.append(responseText)
//    
//    return combination
//}

//MARK:- Trim String Check
func trimmedStringfromString(string:String) -> String{
    return string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
}

//MARK:- Touch Id
func isTouchIdAvailable() -> Bool {
    let context = LAContext()
    if context.canEvaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, error: nil) {
        return true
    }
    else {
        return false;
    }
}

//MARK:- Image from Asset
func getImageFromAsset(asset: PHAsset) -> UIImage {
    let manager = PHImageManager.default()
    let option = PHImageRequestOptions()
    var thumbnail = UIImage()
    option.isSynchronous = true
    manager.requestImage(for: asset, targetSize: PHImageManagerMaximumSize, contentMode: .aspectFit, options: option, resultHandler: {(result, info)->Void in
        thumbnail = result!
    })
    return thumbnail
}

func getSizeOfImage(image:UIImage) -> Int {
    return (UIImageJPEGRepresentation(image, 1.0)?.count)!
}

////MARK:- Image to base64 string
//func getBase64StringFromImage(image:UIImage) -> String
//{
//    //return UIImageJPEGRepresentation(image, 1.0)!.base64EncodedString(options: Data.Base64EncodingOptions.lineLength64Characters)
//    
//}

//MARK:- Get image from color
func getImageWithColor(color: UIColor, size: CGSize) -> UIImage {
    //    let rect = CGRectMake(0, 0, size.width, size.height)
    let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
    UIGraphicsBeginImageContextWithOptions(size, false, 0)
    color.setFill()
    UIRectFill(rect)
    let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
    UIGraphicsEndImageContext()
    return image
}

//MARK:- User defaults
func cacheObject(object:AnyObject, forKey key:String) -> Bool {
    userDefault.set(object, forKey: key)
    return userDefault.synchronize()
}

func cachedObjectForKey(key:String) -> AnyObject? {
    return userDefault.object(forKey: key) as AnyObject?
}

func cacheBool(boolValue:Bool, forKey key:String) -> Bool {
    userDefault.set(boolValue, forKey: key)
    return userDefault.synchronize()
}

func cachedBoolForKey(key:String) -> Bool? {
    return userDefault.bool(forKey: key)
}

func cacheCustomObject(object:AnyObject, forKey key:String) -> Bool {
    userDefault.set(NSKeyedArchiver.archivedData(withRootObject: object), forKey: key)
    return userDefault.synchronize()
}

//func cachedCustomObjectForKey(key:String) -> AnyObject? {
//    if let data = UserDefaults
//        .standard.object(forKey: key) as? NSData {
//        return NSKeyedUnarchiver.unarchiveObject(with: data as Data) as AnyObject?
//        //        return NSKeyedUnarchiver.unarchiveObjectWithData(data as Data)
//    }
//    else {
//        return nil
//    }
//}

func cachedCustomObjectArray(object:Any, forKey key:String) -> Bool {
    userDefault.set(NSKeyedArchiver.archivedData(withRootObject: object), forKey: key)
    return userDefault.synchronize()
}

//func cachedCustomObjectForKeyArray(key:String) -> Any? {
//    if let data = UserDefaults
//        .standard.object(forKey: key) as? NSData {
//        return NSKeyedUnarchiver.unarchiveObject(with: data as Data) as AnyObject?
//        //        return NSKeyedUnarchiver.unarchiveObjectWithData(data as Data)
//    }
//    else {
//        return nil
//    }
//}

func removeCachedObjectForKey(key:String) -> Bool {
    userDefault.removeObject(forKey: key)
    return userDefault.synchronize()
}


//MARK: - Logout due to Session Expiration -
func logoutUserDueToSessionExpire() {
    showOkAlertWithCompletion(titleStr: AlertTitle.kAlertTitleAuthenticatioError, msgStr: AlertMessages.kAlertSessionExpired) {
        //        STVStateHolder.resetLoginState()
        //        STVStateHolder.resetLoginState()
        getTopMostViewController().dismiss(animated: true, completion: nil)
    }
}

//MARK: - Rechability Alert
func isInternetAvailable(show flag:Bool,Message str:String) {
    //    notificationsAlert.notificationStyle = .StatusBarNotification
    //    notificationsAlert.notificationLabelTextColor = UIColor.whiteColor()
    //    notificationsAlert.notificationLabelBackgroundColor = RGB(210, Green: 82, Blue: 86, Alpha: 1.0)
    //    notificationsAlert.notificationAnimationInStyle = .Top
    //    notificationsAlert.notificationLabelFont = UIFont(name: STVFont.ROBOTO_MEDIUM, size: 12.0)!
    //    if flag == true {
    //        notificationsAlert.notificationAnimationOutStyle = .Bottom
    //        notificationsAlert.dismissNotification()
    //    }
    //    else {
    //        notificationsAlert.displayNotificationWithMessage(str, completion: {})
    //    }
}

extension UIApplication {
    class func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
}

//MARK:- GetTopMostView
func getTopMostViewController() -> UIViewController {
    var topViewController = appDelegate.window!.rootViewController! as UIViewController?
    while (topViewController!.presentedViewController != nil) {
        topViewController = topViewController!.presentedViewController!
    }
    return topViewController!
}

//MARK:- Get View Controller by ID
func getViewControllerWithId(vcId:String, storyboard:String) -> UIViewController {
    return UIStoryboard(name: storyboard, bundle: nil).instantiateViewController(withIdentifier: vcId)
}

//MARK:- RGB
func RGB(Red:CGFloat,Green:CGFloat,Blue:CGFloat) -> UIColor {
    return UIColor.init(red: Red/255.0, green: Green/255.0, blue: Blue/255.0, alpha: 1.0)
}

//MARK:- RGB with Dynamic Alpha
func RGB(Red:CGFloat, Green:CGFloat, Blue:CGFloat, Alpha:CGFloat) -> UIColor {
    return UIColor(red: Red/255.0, green: Green/255.0, blue: Blue/255.0, alpha: Alpha)
}

//MARK:- RGB from Hex
func RGB(Hex:String) -> UIColor {
    var cString: String = Hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    //    var cString:String = Hex.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet() as NSCharacterSet).uppercaseString
    
    if (cString.hasPrefix("#")) {
        //        cString = cString.substring(from: cString)
        let index: String.Index = cString.index(cString.startIndex, offsetBy: 1)
        cString = cString.substring(from: index)
        //        cString = cString.substringFromIndex(cString.startIndex.advancedBy(1))
    }
    
    if ((cString.characters.count) != 6) {
        return UIColor.gray
    }
    
    var rgbValue:UInt32 = 0
    Scanner(string: cString).scanHexInt32(&rgbValue)
    
    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}

//MARK:- Device Token to String
func convertDeviceTokenToString(deviceToken:NSData) -> String {
    var deviceTokenStr = deviceToken.description.replacingOccurrences(of: ">", with: "", options: .caseInsensitive, range: nil)
    deviceTokenStr = deviceToken.description.replacingOccurrences(of: ">", with: "", options: .caseInsensitive, range: nil)
    deviceTokenStr = deviceToken.description.replacingOccurrences(of: ">", with: "", options: .caseInsensitive, range: nil)
    
    
    // Our API returns token in all uppercase, regardless how it was originally sent.
    // To make the two consistent, I am uppercasing the token string here.
    deviceTokenStr = deviceTokenStr.uppercased()
    return deviceTokenStr
}

//MARK:- Empty String
func isEmptyString(inputString:String?) -> Bool {
    if inputString != nil && !inputString!.isEmpty && inputString != "null" && inputString != "nil"{
        return false
    }
    return true
}

//MARK:- Action Alert

func callActionSheetCompletion(title: String, Completion:((_ index: Int) -> Void)?) {
    let alertController = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
    
    
    let callAction = UIAlertAction(title: "Call - \(title)", style: .default, handler: {(alert: UIAlertAction!) in
        if Completion != nil {
            Completion!(0)
        }
    })
    
    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {
        (alert: UIAlertAction!) in
        //        print("cancel")
    })
    
    alertController.addAction(callAction)
    alertController.addAction(cancelAction)
    getTopMostViewController().present(alertController, animated: true, completion: nil)
}

func showActionSheetCompletion(title: String, Completion:((_ index: Int) -> Void)?) {
    let alertController = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
    
    
    let callAction = UIAlertAction(title: "Call - \(title)", style: .default, handler: {(alert: UIAlertAction!) in
        if Completion != nil {
            Completion!(0)
        }
    })
    
    let msgAction = UIAlertAction(title: "Message - \(title)", style: .default, handler: {(alert: UIAlertAction!) in
        if Completion != nil {
            Completion!(1)
        }
    })
    
    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {
        (alert: UIAlertAction!) in
        //        print("cancel")
    })
    
    alertController.addAction(callAction)
    alertController.addAction(msgAction)
    alertController.addAction(cancelAction)
    getTopMostViewController().present(alertController, animated: true, completion: nil)
}

//MARK:- Alert With OK
func showOkAlert(titleStr:String, msgStr:String) {
    let alertViewController = UIAlertController(title: titleStr, message: msgStr, preferredStyle: .alert)
    
    let okAction = UIAlertAction(title: "OK", style: .default) { (action) -> Void in
        alertViewController.dismiss(animated: true, completion: nil)
    }
    
    alertViewController.addAction(okAction)
    
    getTopMostViewController().present(alertViewController, animated: true, completion: nil)
}

//MARK:- Alert With OK and Completion handler
func showOkAlertWithCompletion(titleStr:String, msgStr:String, Completion:(() -> Void)?) {
    let alertViewController = UIAlertController(title: titleStr, message: msgStr, preferredStyle: .alert)
    
    let okAction = UIAlertAction(title: "OK", style: .default) { (action) -> Void in
        if Completion != nil {
            Completion!()
        }
    }
    let CancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) -> Void in
        
    }
    
    alertViewController.addAction(okAction)
    alertViewController.addAction(CancelAction)
    
    getTopMostViewController().present(alertViewController, animated: true, completion: nil)
}

//MARK:- Alert With OK and Cancel
func showOkCancelAlert(titleStr:String, msgStr:String) {
    let alertViewController = UIAlertController(title: titleStr, message: msgStr, preferredStyle: .alert)
    
    let okAction = UIAlertAction(title: "OK", style: .default) { (action) -> Void in
        alertViewController.dismiss(animated: true, completion: nil)
    }
    
    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) -> Void in
        alertViewController.dismiss(animated: true, completion: nil)
    }
    
    alertViewController.addAction(cancelAction)
    alertViewController.addAction(okAction)
    
    getTopMostViewController().present(alertViewController, animated: true, completion: nil)
}

//MARK:- Call Message
func callNumaber(phone: String?){
    //    var phone = self.emergencyContact[mainIndex].phoneNo?[0].phoneNumber!
    var phoneNumber = String(phone!.characters.filter { "01234567890.".characters.contains($0) })
    phoneNumber = "tel://\(phoneNumber)"
//    UIApplication.shared.openURL(URL(string: phoneNumber)!)
    UIApplication.shared.open((URL(string: phoneNumber)!), options: [:], completionHandler: nil)
}

//MARK:- Convert date from string to format

func getStringFromDateString(dateString:String, fromDateFormatter:String ,toDateFormatter:String) -> String {
    
    let dateFormatter = DateFormatter()
    //set string date format in date formatter
    dateFormatter.dateFormat = fromDateFormatter
    
    let dateFromString = dateFormatter.date(from: dateString)
    //set require date format in date formatter
    dateFormatter.dateFormat = toDateFormatter
    
    let date = dateFormatter.string(from: dateFromString!)
    return date
}//2017-05-29 19:29:00 +0000

func checkStringFromDateProperFormatted(dateString:String, fromDateFormatter:String) -> Bool {
    
    let dateFormatter = DateFormatter()
    //set string date format in date formatter
    dateFormatter.dateFormat = fromDateFormatter
    
    if dateFormatter.date(from: dateString) != nil {
        return true
    }

    return false
}

func getDateFromString(dateString:String, fromDateFormatter:String ) -> NSDate {
    let dateFormatter = DateFormatter()
    //set string date format in date formatter
    dateFormatter.dateFormat = fromDateFormatter
    
    let dateFromString = dateFormatter.date(from: dateString)
    if dateFromString != nil {
        return dateFromString! as NSDate
    }
    else {
        return NSDate()
    }
}



func getFromattedStringFromDate(date:NSDate, toDateFormatter:String ) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = toDateFormatter
    return dateFormatter.string(from: date as Date)
}

func decomposedComponentsFromDate(date:NSDate) -> (fullMonth:String, dayOfMonth:String, dayOfWeekFull:String, time12Hour:String) {
    let dateFormatter = DateFormatter()
    
    dateFormatter.dateFormat = StaticDateFormatter.FORMATTER_MMM
    let fullMonth = dateFormatter.string(from: date as Date)
    
    dateFormatter.dateFormat = StaticDateFormatter.FORMATTER_DD
    let dayOfMonth = dateFormatter.string(from: date as Date)
    
    dateFormatter.dateFormat = StaticDateFormatter.FORMATTER_EEEE
    let dayOfWeekFull = dateFormatter.string(from: date as Date)
    
    dateFormatter.dateFormat = StaticDateFormatter.FORMATTER__HH_MM_A
    let time12Hour = dateFormatter.string(from: date as Date)
    
    return (fullMonth, dayOfMonth, dayOfWeekFull, time12Hour)
}

//MARK:- Check Date isToday,isTomorrow,yesterday

func getYesterdayOrTodayOrTomorrowOrDateStringFromDate(dateString:String , fromFormat:String) -> String {
    let date = getDateFromString(dateString: dateString, fromDateFormatter: fromFormat)
    
    if NSCalendar.current.isDateInYesterday(date as Date) {
        return "YESTERDAY"
    }
    else if NSCalendar.current.isDateInToday(date as Date) {
        return "TODAY"
    }
    else if NSCalendar.current.isDateInTomorrow(date as Date) {
        return "TOMORROW"
    }
    else
    {
        return dateString
    }
}

func attatchIconToString(mainString:String,wordAfterYouWantToPutIcon selectedWord:String, imageName:String) -> NSMutableAttributedString  {
    
    let attachment = NSTextAttachment()
    attachment.image = UIImage(named: imageName)
    
    let attachmentString = NSAttributedString(attachment: attachment)
    let separatedArray = mainString.components(separatedBy: selectedWord)
    
    let firstString = separatedArray.first
    let secondString = separatedArray.last
    
    let newString = NSMutableAttributedString(string: firstString!)
    newString.append(NSMutableAttributedString(string: " \(selectedWord) "))
    newString.append(attachmentString)
    newString.append(NSMutableAttributedString(string: secondString!))
    
    return newString
    
}

func isErrorMessageKeyValueNil(str: String?) -> String? {
    if str != nil {
        return str!
    }
    else {
        return nil
    }
}

func showStatusBarAlert(Str:String,Duration:Double) {
    JDStatusBarNotification.show(withStatus: Str, dismissAfter: Duration, styleName: "failure")
}

func setupFailureCustomStylesStatusAlert() {
    JDStatusBarNotification.setDefaultStyle{ (style) -> JDStatusBarStyle! in
        style?.barColor              = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        style?.textColor             = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
//        style?.font                  = UIFont.init(name: CustomeFont.Lato_Regular, size: 12)
        style?.textShadow            = nil
        style?.animationType         = .bounce
        return style
    }
}

func globalButton(image: String) -> UIButton {
    let Button = UIButton()
    Button.titleLabel?.adjustsFontSizeToFitWidth = true
    Button.titleLabel?.minimumScaleFactor = 0.3;
    Button.frame = CGRect(x:0,y:0,width:(40/414)*ScreenSize.SCREEN_WIDTH,height:(22/736)*ScreenSize.SCREEN_HEIGHT)
    Button.layer.cornerRadius = 2
    Button.layer.masksToBounds = true
    Button.setImage(UIImage.init(named: image), for: .normal)
    Button.imageView?.contentMode = UIViewContentMode.scaleAspectFit
    Button.contentVerticalAlignment = UIControlContentVerticalAlignment.center
    return Button
    //    btn.addTarget(self, action: #selector(rightButtonClick(_:)), for: .touchUpInside)
}

func globalButton(string: String) -> UIButton {
    let Button = UIButton()
    Button.titleLabel?.adjustsFontSizeToFitWidth = true
    Button.titleLabel?.minimumScaleFactor = 0.3;
    Button.frame = CGRect(x:0,y:0,width:(90/414)*ScreenSize.SCREEN_WIDTH,height:(30/736)*ScreenSize.SCREEN_HEIGHT)
    Button.layer.cornerRadius = 2
    Button.layer.masksToBounds = true
    //Button.setImage(UIImage.init(named: image), for: .normal)
    Button.setTitle(string, for: .normal)
    Button.titleLabel?.font = UIFont.init(name: CustomeFont.AvenirNext_Regular, size: 15)
    Button.imageView?.contentMode = UIViewContentMode.scaleAspectFit
    Button.contentVerticalAlignment = UIControlContentVerticalAlignment.center
    Button.contentHorizontalAlignment = .right
    return Button
    //    btn.addTarget(self, action: #selector(rightButtonClick(_:)), for: .touchUpInside)
}

func addLeftButton(string: String) -> UIButton {
    let Button = UIButton()
    Button.titleLabel?.adjustsFontSizeToFitWidth = true
    Button.titleLabel?.minimumScaleFactor = 0.3;
    Button.frame = CGRect(x:0,y:0,width:(90/414)*ScreenSize.SCREEN_WIDTH,height:(30/736)*ScreenSize.SCREEN_HEIGHT)
    Button.layer.cornerRadius = 2
    Button.layer.masksToBounds = true
    //Button.setImage(UIImage.init(named: image), for: .normal)
    Button.setTitle(string, for: .normal)
    Button.titleLabel?.font = UIFont.init(name: CustomeFont.AvenirNext_Regular, size: 15)
    Button.imageView?.contentMode = UIViewContentMode.scaleAspectFit
    Button.contentVerticalAlignment = UIControlContentVerticalAlignment.center
    Button.contentHorizontalAlignment = .left
    return Button
    //    btn.addTarget(self, action: #selector(rightButtonClick(_:)), for: .touchUpInside)
}

//Add letter spacing
func addTextSpacing(value: CGFloat, string: String) -> NSMutableAttributedString {
    let attributedString = NSMutableAttributedString(string: string)
    attributedString.addAttribute(NSKernAttributeName, value: value, range: NSRange(location: 0, length: attributedString.length - 1))
    return attributedString
}

//MARK:- Get Date Formatter
func getDateFormatter(format: String) -> DateFormatter {
    let formatter = DateFormatter()
    formatter.dateFormat = format
    return formatter
}

//MARK:- Get Formatted Date
func getFormattedDate(format: String, date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = format
    return formatter.string(from: date)
}

func SplitStringByCharacter(string: String, character: String) -> [String] {
    let splitString = string
    let splitArray = splitString.components(separatedBy: character)
    return splitArray
}

func getFirstCharacterOfString(string: String) -> String {
    return "\(string.characters.first!)"
}

func format(phoneNumber sourcePhoneNumber: String) -> String? {
    /*
     // Remove any character that is not a number
     //    let numbersOnly = sourcePhoneNumber.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
     //    let s = "5554446677"
     let numbersOnly = sourcePhoneNumber.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
     let length = numbersOnly.characters.count
     let hasLeadingOne = numbersOnly.hasPrefix("1")
     
     // Check for supported phone number length
     guard length == 7 || length == 10 || (length == 11 && hasLeadingOne) else {
     return nil
     }
     
     let hasAreaCode = (length >= 10)
     var sourceIndex = 0
     
     // Leading 1
     var leadingOne = ""
     if hasLeadingOne {
     leadingOne = "1 "
     sourceIndex += 1
     }
     
     // Area code
     var areaCode = ""
     if hasAreaCode {
     let areaCodeLength = 3
     guard let areaCodeSubstring = numbersOnly.characters.substring(start: sourceIndex, offsetBy: areaCodeLength) else {
     return nil
     }
     areaCode = String(format: "(%@) ", areaCodeSubstring)
     sourceIndex += areaCodeLength
     }
     
     // Prefix, 3 characters
     let prefixLength = 3
     guard let prefix = numbersOnly.characters.substring(start: sourceIndex, offsetBy: prefixLength) else {
     return nil
     }
     sourceIndex += prefixLength
     
     // Suffix, 4 characters
     let suffixLength = 4
     guard let suffix = numbersOnly.characters.substring(start: sourceIndex, offsetBy: suffixLength) else {
     return nil
     }
     print("\(leadingOne + areaCode + prefix + "-" + suffix)")
     return leadingOne + areaCode + prefix + "-" + suffix
     */
    let formattedString = NSMutableString(string: sourcePhoneNumber)
    formattedString.insert("-", at: 0)
    formattedString.insert("-", at: 4)
//    formattedString.insert("", at: 9)
    return "\(formattedString)"
}

func checkEnglishPhoneNumberFormat(string: String?, str: String?, txtFieldPhoneNumber: UITextField) -> Bool{
    
    if string == ""{ //BackSpace
        
        return true
        
    }
//    else if str!.characters.count < 3{
//        
//        if str!.characters.count == 1{
//            
//            txtFieldPhoneNumber.text = "("
//        }
//        
//    }
    else if str!.characters.count == 4{
        
        txtFieldPhoneNumber.text = txtFieldPhoneNumber.text! + "-"
        
    }else if str!.characters.count == 8{
        
        txtFieldPhoneNumber.text = txtFieldPhoneNumber.text! + "-"
        
    }else if str!.characters.count > 12{
        
        return false
    }
    
    return true
}

public func parseJSONString(JSON: String) -> Any? {
    let data = JSON.data(using: String.Encoding.utf8, allowLossyConversion: true)
    if let data = data {
        let parsedJSON: Any?
        do {
            parsedJSON = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments)
        } catch let _ {
//            print(error)
            parsedJSON = nil
        }
        return parsedJSON
    }
    
    return nil
}

//MARK: - font as per device of uilabel

func setLableTextAsPerDevice ( lbl:UILabel? ) {
    if lbl != nil {
        lbl?.font = UIFont.init(name: (lbl?.font.fontName)!, size: ((lbl?.font.pointSize)!/414.0 * ScreenSize.SCREEN_WIDTH) )
    }
    
}

//MARK:- Check Status active / inactive based on retrun boolean
func checkActiveStatus(str:String) -> Bool {
    if str == "active" {
        return true
    }
    return false
}
//MARK:- Seconds to hours and Minutes
func secondsToHoursMinutesSeconds (seconds : Int) -> (Int, Int, Int) {
    return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
}

func secondsToMinutes(seconds : Int) -> Int {
    return (seconds % 3600) / 60
}

//MARK:- Meters To Miles
func metersToMiles(meters:Float) -> Float {
    
    let distanceMeters = Measurement(value: Double(meters), unit: UnitLength.kilometers)
    
//    let distanceMiles = distanceMeters.converted(to: UnitLength.miles)
    return round(Float(distanceMeters.converted(to: UnitLength.miles).value), toDecimalPlaces: 2)
}

// Convert from kilometers to miles (Double)
func kilometersToMiles(speedInMPH:Float) ->Float {
    let speedInKPH:Float = Float(speedInMPH / 1.60934)
    let roundedSpeed = round(speedInKPH, toDecimalPlaces: 2)
    return roundedSpeed as Float
}

//Meters to Feet
func metersToFeet(meters:Float)->Float {
    let elevatioMeters = Measurement(value: Double(meters), unit: UnitLength.meters)

    return round(Float(elevatioMeters.converted(to: UnitLength.feet).value), toDecimalPlaces: 2)
}

func round(_ value: Float, toDecimalPlaces places: Int) -> Float {
    let divisor = pow(10.0, Float(places))
    return round(value * divisor) / divisor
}

//MARK:- Pull To Refresh
extension UIView {
    
//    //MARK:- Pull To Refresh View
//    
//    func refreshDesignedView() -> PullToRefreshOption {
//        var options = PullToRefreshOption()
//        options.backgroundColor = UIColor.clear
//        options.indicatorColor = Colors.dafaultBlue.withAlphaComponent(0.8)
//        return options
//    }
//    
//    //MARK:- Load More View
//    
//    func loadMoreDesignedView() -> UIView {
//        let activityView = NVActivityIndicatorView.init(frame: CGRect(x: 0, y: 0, width: ScreenSize.SCREEN_WIDTH, height: 50), type: .ballTrianglePath, color: Colors.dafaultBlue.withAlphaComponent(0.8), padding: 10 )
//        activityView.backgroundColor = UIColor.clear
//        return activityView
//    }
}


//MARK:- Merge Two Array
extension Array where Element : Equatable{
    
    public mutating func mergeElements<C : Collection>(newElements: C) where C.Generator.Element == Element{
        _ = newElements.filter({!self.contains($0)})
        self.append(contentsOf: newElements)
    }
}

//MARK:- Date Conversion
extension Date {
    
    static func generateDates(startDate :Date?, addbyUnit:Calendar.Component, value : Int) -> [Date]
    {
        let calendar = Calendar.current
        var datesArray: [Date] =  [Date] ()
        
        for i in 0 ... value {
            if let newDate = calendar.date(byAdding: addbyUnit, value: i + 1, to: startDate!) {
                datesArray.append(newDate)
            }
        }
        
        return datesArray
    }

    static func ISOStringFromDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.init(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone.init(abbreviation: "GMT")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        
        return dateFormatter.string(from: date).appending("Z")
    }
    
    static func ISOStringFromDateStartTime(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.init(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone.init(abbreviation: "GMT")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'00:00:00.SSS"
        
        return dateFormatter.string(from: date).appending("Z")
    }
    
    static func ISOStringFromDateEndTime(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.init(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone.init(abbreviation: "GMT")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'23:59:59.SSS"
        
        return dateFormatter.string(from: date).appending("Z")
    }
    
    static func dateFromISOString(string: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.init(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone.init(abbreviation: "\(String(describing: TimeZone.current.abbreviation()))")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        return dateFormatter.date(from: string)!
    }
}



func DateStringStartDay() -> String{
    return Date.ISOStringFromDateStartTime(date: (Calendar.current.date(byAdding: .day, value: 0, to: Date())!))
}

func DateStringStartDay(withDate:Date) -> String{
    return Date.ISOStringFromDateStartTime(date: (Calendar.current.date(byAdding: .day, value: 0, to: withDate)!))
}

func DateStringEndDay(withDate:Date) -> String{
    return Date.ISOStringFromDateEndTime(date: (Calendar.current.date(byAdding: .day, value: 0, to: withDate)!))
}

func DateStringEndDay() -> String{
    return Date.ISOStringFromDateEndTime(date: (Calendar.current.date(byAdding: .day, value: 0, to: Date())!))
}

func DateStringNow() -> String{
    return Date.ISOStringFromDate(date: (Calendar.current.date(byAdding: .day, value: 0, to: Date())!))
}

func DateStringBeforeWeek() -> String{
    return Date.ISOStringFromDate(date: (Calendar.current.date(byAdding: .day, value: -7, to: Date())!))
}

func DateStringBeforeMonth() -> String{
    return Date.ISOStringFromDate(date: (Calendar.current.date(byAdding: .month, value: -1, to: Date())!))
}

func DateStringBeforeYear() -> String{
    return Date.ISOStringFromDate(date: (Calendar.current.date(byAdding: .year, value: -1, to: Date())!))
}


func findMaximumNumber(data:[Any]) -> NSNumber {
    return data.max(by: { (no1, no2) -> Bool in let n1:NSNumber = no1 as! NSNumber; let n2:NSNumber = no2 as! NSNumber; return n1.intValue < n2.intValue }) as! NSNumber
}

func findMaximumNumberInFloat(data:[Any]) -> Float {
    return data.max(by: { (no1, no2) -> Bool in let n1:Float = no1 as! Float; let n2:Float = no2 as! Float; return n1 < n2 }) as! Float
}
//Array extension find all values are same
extension Array where Element : Equatable {
    func allEqual() -> Bool {
        if let firstElem = first {
            return !dropFirst().contains { $0 != firstElem }
        }
        return true
    }
}

