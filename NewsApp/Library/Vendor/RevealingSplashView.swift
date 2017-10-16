//
//  RevealingSplashView.swift
//  RevealingSplashView
//
//  Created by Chris Jimenez on 2/25/16.
//  Copyright © 2016 Chris Jimenez. All rights reserved.
//

import Foundation
import UIKit


public typealias SplashAnimatableCompletion = () -> Void
public typealias SplashAnimatableExecution = () -> Void

public enum SplashAnimationType: String{
    
    case none
    case Twitter
    case RotateOut
    case WoobleAndZoomOut
    case SwingAndZoomOut
    case PopAndZoomOut
    case SqueezeAndZoomOut
    
}

public protocol SplashAnimatable: class{
    
    /// The image view that shows the icon
    var imageView: UIImageView? { get set }
    
    var translationImageView: UIImageView? { get set }
    
    /// The animation type
    var animationType: SplashAnimationType { get set }
    
    /// The duration of the overall animation
    var duration: Double { get set }
    
    /// The delay to play the animation
    var delay: Double { get set }
    
}

/// SplashView that reveals its content and animate, like twitter
open class RevealingSplashView: UIView, SplashAnimatable{
    
    
    /// The icon image to show and reveal with
    open var iconImage: UIImage? {
        
        didSet{
            if let iconImage = self.iconImage{
                imageView?.image = iconImage
            }
        }
        
    }
    
    ///The icon color of the image, defaults to white
    open var iconColor: UIColor = UIColor.white{
        
        didSet{
            
             imageView?.tintColor = iconColor
        }
            
    }
    
    open var useCustomIconColor: Bool = false{
        
        didSet{
            
            if(useCustomIconColor == true){

                if let iconImage = self.iconImage {
                    imageView?.image = iconImage.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
                }
            }
            else{
                
                if let iconImage = self.iconImage {
                    imageView?.image = iconImage.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
                }
            }
        }
    }
    
    ///The initial size of the icon. Ideally it has to match with the size of the icon in your LaunchScreen Splash view
    open var iconInitialSize: CGSize = CGSize(width: 60, height: 60) {
        
        didSet{
            
             imageView?.frame = CGRect(x: 0, y: 0, width: iconInitialSize.width, height: iconInitialSize.height)
        }
    }
    
    /// THe image view containing the icon Image
    open var imageView: UIImageView?
    
    open var translationImageView: UIImageView?
    
    /// The type of animation to use for the. Defaults to the Twitter default animation
    open var animationType: SplashAnimationType = SplashAnimationType.Twitter
    
    /// The duration of the animation, default to 1.5 seconds
    open var duration: Double = 1.5
    
    /// The delay of the animation, default to 0.5 seconds
    open var delay: Double = 0.5
    
    /**
     Default constructor of the class
     
     - parameter iconImage:       The Icon image to show the animation
     - parameter iconInitialSize: The initial size of the icon image
     - parameter backgroundColor: The background color of the image, ideally this should match your Splash view
     
     - returns: The created RevealingSplashViewObject
     */
    public init(iconImage: UIImage, iconInitialSize:CGSize, backgroundColor: UIColor)
    {
        //Sets the initial values of the image view and icon view
        self.imageView = UIImageView()
        self.translationImageView = UIImageView()
        self.iconImage = iconImage
        self.iconInitialSize = iconInitialSize
        //Inits the view to the size of the screen
        super.init(frame: UIScreen.main.bounds)
        
        imageView?.image = iconImage
        imageView?.tintColor = iconColor
        //Set the initial size and position
        imageView?.frame = CGRect(x: 0, y: 0, width: iconInitialSize.width, height: iconInitialSize.height)
        //Sets the content mode and set it to be centered
        imageView?.contentMode = UIViewContentMode.scaleAspectFit
        imageView?.center = self.center
        
        //Adds the icon to the view
        self.addSubview(imageView!)
        
        //Sets the background color
        self.backgroundColor = backgroundColor
        
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - Protool extension to define the basic functionality for the SplashAnimatable
public extension SplashAnimatable where Self: UIView {
    
    /**
     Starts the animation depending on the type
     */
    public func startAnimation(_ completion: SplashAnimatableCompletion? = nil)
    {
        switch animationType{
        case .none:
            playNoneAnimation(completion)
            
        case .Twitter:
            playTwitterAnimation(completion)
            
        case .RotateOut:
            playRotateOutAnimation(completion)
            
        case .WoobleAndZoomOut:
            playWoobleAnimation(completion)
            
        case .SwingAndZoomOut:
            playSwingAnimation(completion)
            
        case.PopAndZoomOut:
            playPopAnimation(completion)
            
        case.SqueezeAndZoomOut:
            playSqueezeAnimation(completion)
        }
        
    }
    
    /**
     Plays the twitter animation
     */
    public func playNoneAnimation(_ completion: SplashAnimatableCompletion? = nil)
    {
        
        if let _ = self.imageView {
            
            //Define the shink and grow duration based on the duration parameter
            let shrinkDuration: TimeInterval = duration * 0.3
            
            //Plays the shrink animation
            UIView.animate(withDuration: shrinkDuration, delay: delay, usingSpringWithDamping: 0.7, initialSpringVelocity: 10, options: UIViewAnimationOptions(), animations: {
                

            }, completion: { finished in
                completion!()
            })
        }
    }
    
    
    /**
     Plays the twitter animation
     */
    public func playTwitterAnimation(_ completion: SplashAnimatableCompletion? = nil)
    {
        
        if let imageView = self.imageView {
            
            //Define the shink and grow duration based on the duration parameter
            let shrinkDuration: TimeInterval = duration * 0.3
            
            //Plays the shrink animation
            UIView.animate(withDuration: shrinkDuration, delay: delay, usingSpringWithDamping: 0.7, initialSpringVelocity: 10, options: UIViewAnimationOptions(), animations: {
                //Shrinks the image
                let scaleTransform: CGAffineTransform = CGAffineTransform(scaleX: 0.75,y: 0.75)
                imageView.transform = scaleTransform
                
                //When animation completes, grow the image
            }, completion: { finished in
                
                self.playZoomOutAnimation(completion)
            })
        }
    }
    
    
    /**
     Plays the twitter animation
     */
    public func playSqueezeAnimation(_ completion: SplashAnimatableCompletion? = nil)
    {
        
        if let imageView = self.imageView {
            
            //Define the shink and grow duration based on the duration parameter
            let shrinkDuration: TimeInterval = duration * 0.5
            
            //Plays the shrink animation
            UIView.animate(withDuration: shrinkDuration, delay: delay/3, usingSpringWithDamping: 10, initialSpringVelocity: 10, options: UIViewAnimationOptions(), animations: {
                //Shrinks the image
                let scaleTransform: CGAffineTransform = CGAffineTransform(scaleX: 0.30,y: 0.30)
                imageView.transform = scaleTransform
                
                //When animation completes, grow the image
            }, completion: { finished in
                
                self.playZoomOutAnimation(completion)
            })
        }
    }
    
    /**
     Plays the rotate out animation
     
     - parameter completion: when the animation completes
     */
    public func playRotateOutAnimation(_ completion: SplashAnimatableCompletion? = nil)
    {
        if let imageView = self.imageView{
            
            /**
             Sets the animation with duration delay and completion
             
             - returns:
             */
            UIView.animate(withDuration: duration, delay: delay, usingSpringWithDamping: 0.5, initialSpringVelocity: 3, options: UIViewAnimationOptions(), animations: {
                
                //Sets a simple rotate
                let rotateTranform = CGAffineTransform(rotationAngle: CGFloat(Double.pi * 0.99))
                //Mix the rotation with the zoom out animation
                imageView.transform = rotateTranform.concatenating(self.getZoomOutTranform())
                //Removes the animation
                self.alpha = 0
                
            }, completion: { finished in
                
                self.removeFromSuperview()
                
                completion?()
            })
            
        }
    }
    
    /**
     Plays a wobble animtion and then zoom out
     
     - parameter completion: completion
     */
    public func playWoobleAnimation(_ completion: SplashAnimatableCompletion? = nil) {
        
        if let imageView = self.imageView{
            
            let woobleForce = 0.5
            
            animateLayer({
                let rotation = CAKeyframeAnimation(keyPath: "transform.rotation")
                rotation.values = [0, 0.3 * woobleForce, -0.3 * woobleForce, 0.3 * woobleForce, 0]
                rotation.keyTimes = [0, 0.2, 0.4, 0.6, 0.8, 1]
                rotation.isAdditive = true
                
                let positionX = CAKeyframeAnimation(keyPath: "position.x")
                positionX.values = [0, 30 * woobleForce, -30 * woobleForce, 30 * woobleForce, 0]
                positionX.keyTimes = [0, 0.2, 0.4, 0.6, 0.8, 1]
                positionX.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
                positionX.isAdditive = true
                
                let animationGroup = CAAnimationGroup()
                animationGroup.animations = [rotation, positionX]
                animationGroup.duration = CFTimeInterval(self.duration/2)
                animationGroup.beginTime = CACurrentMediaTime() + CFTimeInterval(self.delay/2)
                animationGroup.repeatCount = 2
                imageView.layer.add(animationGroup, forKey: "wobble")
            }, completion: {
                
                self.playZoomOutAnimation(completion)
            })
            
        }
    }
    
    /**
     Plays the swing animation and zoom out
     
     - parameter completion: completion
     */
    public func playSwingAnimation(_ completion: SplashAnimatableCompletion? = nil)
    {
        if let imageView = self.imageView{
            
            let swingForce = 0.8
            
            animateLayer({
                
                let animation = CAKeyframeAnimation(keyPath: "transform.rotation")
                animation.values = [0, 0.3 * swingForce, -0.3 * swingForce, 0.3 * swingForce, 0]
                animation.keyTimes = [0, 0.2, 0.4, 0.6, 0.8, 1]
                animation.duration = CFTimeInterval(self.duration/2)
                animation.isAdditive = true
                animation.repeatCount = 2
                animation.beginTime = CACurrentMediaTime() + CFTimeInterval(self.delay/3)
                imageView.layer.add(animation, forKey: "swing")
                
            }, completion: {
                self.playZoomOutAnimation(completion)
            })
        }
    }
    
    
    /**
     Plays the pop animation with completion
     
     - parameter completion: completion
     */
    public func playPopAnimation(_ completion: SplashAnimatableCompletion? = nil)
    {
        if let imageView = self.imageView{
            
            let popForce = 0.5
            
            animateLayer({
                let animation = CAKeyframeAnimation(keyPath: "transform.scale")
                animation.values = [0, 0.2 * popForce, -0.2 * popForce, 0.2 * popForce, 0]
                //animation.keyTimes = [0, 0.3, 0.6, 0.9,  1]
                animation.keyTimes = [0, 0.2, 0.4, 0.6, 0.8,  1]
                animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
                animation.duration = CFTimeInterval(self.duration/2)
                animation.isAdditive = true
                animation.repeatCount = 2
                animation.beginTime = CACurrentMediaTime() + CFTimeInterval(self.delay/2)
                imageView.layer.add(animation, forKey: "pop")
            }, completion: {
                self.playZoomOutAnimation(completion)
                self.playZoomOutAnimationTranslation(completion)
            })
        }
        
//        if let imageView = self.translationImageView {
//            
//            let popForce = 0.5
//            
//            animateLayer({
//                let animation = CAKeyframeAnimation(keyPath: "transform.scale")
//                animation.values = [0, 0.2 * popForce, -0.2 * popForce, 0.2 * popForce, 0]
//                //animation.keyTimes = [0, 0.3, 0.6, 0.9,  1]
//                animation.keyTimes = [0, 0.2, 0.4, 0.6, 0.8,  1]
//                animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
//                animation.duration = CFTimeInterval(self.duration/2)
//                animation.isAdditive = true
//                animation.repeatCount = 2
//                animation.beginTime = CACurrentMediaTime() + CFTimeInterval(self.delay/2)
//                //imageView.layer.add(animation, forKey: "pop")
//            }, completion: {
//                self.playZoomOutAnimationTranslation(completion)
//            })
//        }
    }
    
    /**
     Plays the zoom out animation with completion
     
     - parameter completion: completion667*
     */
    public func playZoomOutAnimation(_ completion: SplashAnimatableCompletion? = nil)
    {
        if let imageView =  imageView
        {
            let growDuration: TimeInterval =  1
            
            UIView.animate(withDuration: growDuration, animations:{
                self.alpha = 0
                imageView.alpha = 1
                imageView.transform = self.getZoomOutTranform()
                
                //When animation completes remote self from super view
            }, completion: { finished in
                
                //self.removeFromSuperview()
                
                //completion?()
            })
        }
    }
    
    public func playZoomOutAnimationTranslation(_ completion: SplashAnimatableCompletion? = nil)
    {
        if let imageView =  translationImageView
        {
            let growDuration: TimeInterval =  1.5
            
            UIView.animate(withDuration: growDuration, animations:{
                self.alpha = 0
                imageView.alpha = 1
                imageView.transform = self.getZoomOutTranformTranslation()
                
                //When animation completes remote self from super view
            }, completion: { finished in
                
                self.removeFromSuperview()
                
                completion?()
            })
        }
    }
    
    
    
    /**
     Retuns the default zoom out transform to be use mixed with other transform
     
     - returns: ZoomOut fransfork
     */
    fileprivate func getZoomOutTranform() -> CGAffineTransform
    {
        var zoomOutTranform: CGAffineTransform = CGAffineTransform(scaleX: 1, y: 1)
        if DeviceType.IS_IPHONE_5 {
            zoomOutTranform = zoomOutTranform.translatedBy(x: 0, y: ((-245/736)*ScreenSize.SCREEN_HEIGHT))
        }
        else if DeviceType.IS_IPHONE_6 {
            zoomOutTranform = zoomOutTranform.translatedBy(x: 0, y: ((-249/736)*ScreenSize.SCREEN_HEIGHT))
        }
        else {
            zoomOutTranform = zoomOutTranform.translatedBy(x: 0, y: ((-251/736)*ScreenSize.SCREEN_HEIGHT))
        }
        return zoomOutTranform
    }
    fileprivate func getZoomOutTranformTranslation() -> CGAffineTransform
    {
        var zoomOutTranform: CGAffineTransform = CGAffineTransform(scaleX: 1, y: 1)
        if DeviceType.IS_IPHONE_5 {
            zoomOutTranform = zoomOutTranform.translatedBy(x: 0, y: ((-245/736)*ScreenSize.SCREEN_HEIGHT))
        }
        else if DeviceType.IS_IPHONE_6 {
            zoomOutTranform = zoomOutTranform.translatedBy(x: 0, y: ((-249/736)*ScreenSize.SCREEN_HEIGHT))
        }
        else {
            zoomOutTranform = zoomOutTranform.translatedBy(x: 0, y: ((-251/736)*ScreenSize.SCREEN_HEIGHT))
        }
        return zoomOutTranform
    }
    
    public func getZoomInTranform() -> CGAffineTransform
    {
        var zoomOutTranform: CGAffineTransform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        zoomOutTranform = zoomOutTranform.translatedBy(x: 0, y: 0)
        return zoomOutTranform
    }
    
    
    // MARK: - Private
    fileprivate func animateLayer(_ animation: SplashAnimatableExecution, completion: SplashAnimatableCompletion? = nil) {
        
        CATransaction.begin()
        if let completion = completion {
            CATransaction.setCompletionBlock { completion() }
        }
        animation()
        CATransaction.commit()
    }
    
    
    
}

