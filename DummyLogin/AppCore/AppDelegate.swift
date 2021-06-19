
import UIKit
import Firebase
import GoogleSignIn
import FBSDKCoreKit
import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        // MARK:  For google Login
        FirebaseApp.configure()
        GIDSignIn.sharedInstance().clientID = ConstantsAPIKey.GOOGLE_KEY
        
        ApplicationDelegate.shared.application(
            application,
            didFinishLaunchingWithOptions: launchOptions
        )
        
        // MARK:  for Kokoa login
        KakaoSDKCommon.initSDK(appKey: ConstantsAPIKey.KOKAOTALK_KEY)
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        ApplicationDelegate.shared.application(
            application,
            didFinishLaunchingWithOptions: launchOptions
        )
        
        if AuthManager.shared.isAuthenticated() {
            window?.rootViewController = UINavigationController(rootViewController: HomeScreenController())
        } else {
            window?.rootViewController = UINavigationController(rootViewController: LoginScreenController())
        }
        
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
        
        let googleDidHandle = GIDSignIn.sharedInstance().handle(url)
        
        //        let facebookHandle = ApplicationDelegate.shared.application(
        //            app,
        //            open: url,
        //            sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
        //            annotation: options[UIApplication.OpenURLOptionsKey.annotation]
        //        )
        
        if (AuthApi.isKakaoTalkLoginUrl(url)) {
            return AuthController.handleOpenUrl(url: url)
        } else {
            return googleDidHandle
        }
  
    }
}

