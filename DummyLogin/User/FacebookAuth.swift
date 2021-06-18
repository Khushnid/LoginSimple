
import FBSDKLoginKit

class FacebookAuth {
    static func isLogin() -> Bool {
        return AccessToken.current != nil
    }

    static func signOut() {
        LoginManager().logOut()
    }

    static func isValidatedWithUrl(url: NSURL) -> Bool {
        return url.scheme?.hasPrefix("fb\(Settings.appID ?? "")") ?? false && url.host == "authorize"
    }
}
