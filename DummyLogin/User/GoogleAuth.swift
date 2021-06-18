
import GoogleSignIn

class GoogleAuth {

    static func getInstance() -> GIDSignIn {
        return GIDSignIn.sharedInstance()
    }

    static func isLogin() -> Bool {
        GIDSignIn.sharedInstance()?.currentUser != nil ? true : false
    }

    static func signOut() {
        getInstance().signOut()
    }

    static func isValidatedWithUrl(url: NSURL) -> Bool {
        return ((url.scheme?.hasPrefix(Bundle.main.bundleIdentifier!)) != nil) || ((url.scheme?.hasPrefix("com.googleusercontent.apps.")) != nil)
    }
}
