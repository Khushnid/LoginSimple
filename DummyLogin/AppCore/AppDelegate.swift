
import UIKit
import Firebase
import GoogleSignIn
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
        
        // MARK:  for Kokoa login
        KakaoSDKCommon.initSDK(appKey: ConstantsAPIKey.KOKAOTALK_KEY)
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        if AuthManager.shared.isAuthenticated() {
            window?.rootViewController = UINavigationController(rootViewController: HomeScreenController())
        } else {
            window?.rootViewController = UINavigationController(rootViewController: LoginScreenController())
        }
        
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
        
        let googleDidHandle = GIDSignIn.sharedInstance().handle(url)
        
        if (AuthApi.isKakaoTalkLoginUrl(url)) {
            return AuthController.handleOpenUrl(url: url)
        } else {
            return googleDidHandle
        }
  
    }
}

