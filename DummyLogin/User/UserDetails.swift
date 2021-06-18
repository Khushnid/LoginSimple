
import Foundation

class UserPreferences {
    public static let shared: UserPreferences = UserPreferences()
    fileprivate let defaults = UserDefaults.standard

    var userToken: String? {
        get { return defaults.string(forKey: UserKeys.userToken) }
        set { defaults.setValue(newValue, forKey: UserKeys.userToken) }
    }
    
    var userPhone: String? {
        get { return defaults.string(forKey: UserKeys.userPhone) }
        set { defaults.setValue(newValue, forKey: UserKeys.userPhone) }
    }
    
    var userName: String? {
        get { return defaults.string(forKey: UserKeys.userName) }
        set { defaults.setValue(newValue, forKey: UserKeys.userName) }
    }
}
