
class AuthManager {
   
    static let shared = AuthManager()
    
    func isAuthenticated() -> Bool {
        
        if UserPreferences.shared.userToken != nil {
            return true
        }
        
        return false
    }
}



