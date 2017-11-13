//
//  MainViewController.swift
//  LGSideMenuControllerDemo
//

class MainViewController: LGSideMenuController {
    
    private var type: UInt?
    
    func setup(type: UInt) {
        self.type = type
        
        // -----
        
        if (self.storyboard != nil) {
            // Left and Right view controllers is set in storyboard
            // Use custom segues with class "LGSideMenuSegue" and identifiers "left" and "right"
            
            // Sizes and styles is set in storybord
            // You can also find there all other properties
            
            // LGSideMenuController fully customizable from storyboard
        }
        else {
            leftViewController = CategorySelectionViewController()
            rightViewController = CategorySelectionViewController()
            
            leftViewWidth = 250.0;
            leftViewBackgroundImage = UIImage(named: "imageLeft")
            leftViewBackgroundColor = UIColor(red: 0.5, green: 0.65, blue: 0.5, alpha: 0.95)
            rootViewCoverColorForLeftView = UIColor(red: 0.0, green: 1.0, blue: 0.0, alpha: 0.05)
            
            rightViewWidth = 250.0;
            rightViewBackgroundImage = UIImage(named: "imageRight")
            rightViewBackgroundColor = UIColor(red: 0.65, green: 0.5, blue: 0.65, alpha: 0.95)
            rootViewCoverColorForRightView = UIColor(red: 1.0, green: 0.0, blue: 1.0, alpha: 0.05)
        }
        
        
        let greenCoverColor = UIColor(red: 0.0, green: 0.1, blue: 0.0, alpha: 0.3)
        let purpleCoverColor = UIColor(red: 0.1, green: 0.0, blue: 0.1, alpha: 0.3)
        
        
        leftViewPresentationStyle = .slideAbove
        rootViewCoverColorForLeftView = greenCoverColor
        
        rightViewPresentationStyle = .slideAbove
        rootViewCoverColorForRightView = purpleCoverColor
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setup(type: 0)

    }
    
    override func leftViewWillLayoutSubviews(with size: CGSize) {
        super.leftViewWillLayoutSubviews(with: size)
        
        if !isLeftViewStatusBarHidden {
            leftView?.frame = CGRect(x: 0.0, y: 20.0, width: size.width, height: size.height - 20.0)
        }
    }
    
    override func rightViewWillLayoutSubviews(with size: CGSize) {
        super.rightViewWillLayoutSubviews(with: size)
        
        if (!isRightViewStatusBarHidden ||
            (rightViewAlwaysVisibleOptions.contains(.onPadLandscape) &&
                UI_USER_INTERFACE_IDIOM() == .pad &&
                UIInterfaceOrientationIsLandscape(UIApplication.shared.statusBarOrientation))) {
            rightView?.frame = CGRect(x: 0.0, y: 20.0, width: size.width, height: size.height - 20.0)
        }
    }
    
    override var isLeftViewStatusBarHidden: Bool {
        get {
            if (type == 8) {
                return UIInterfaceOrientationIsLandscape(UIApplication.shared.statusBarOrientation) && UI_USER_INTERFACE_IDIOM() == .phone
            }
            
            return super.isLeftViewStatusBarHidden
        }
        
        set {
            super.isLeftViewStatusBarHidden = newValue
        }
    }
    
    override var isRightViewStatusBarHidden: Bool {
        get {
            if (type == 8) {
                return UIInterfaceOrientationIsLandscape(UIApplication.shared.statusBarOrientation) && UI_USER_INTERFACE_IDIOM() == .phone
            }
            
            return super.isRightViewStatusBarHidden
        }
        
        set {
            super.isRightViewStatusBarHidden = newValue
        }
    }
    
    deinit {
        print("MainViewController deinitialized")
    }
    
}
