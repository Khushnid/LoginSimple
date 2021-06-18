
import UIKit

public typealias FontSize = CGFloat

extension FontSize {
    //small range
    public static let sm13: CGFloat = isIPad ? 15 : 13
    public static let sm12: CGFloat = isIPad ? 14 : 12
    public static let sm11: CGFloat = isIPad ? 13 : 11
    public static let sm10: CGFloat = isIPad ? 12 : 10
    public static let sm9: CGFloat = isIPad ? 11 : 9
    public static let sm8: CGFloat = isIPad ? 10 : 8
    
    //medium range
    public static let md16: CGFloat = isIPad ? 18 : 16
    public static let md15: CGFloat = isIPad ? 17 : 15
    public static let md14: CGFloat = isIPad ? 16 : 14
   
    //large range
    public static let lg17: CGFloat = isIPad ? 19 : 17
    public static let lg18: CGFloat = isIPad ? 20 : 18
    public static let lg19: CGFloat = isIPad ? 21 : 19
    public static let lg20: CGFloat = isIPad ? 22 : 20
    public static let lg21: CGFloat = isIPad ? 23 : 21
    public static let lg24: CGFloat = isIPad ? 26 : 24
    public static let lg28: CGFloat = isIPad ? 30 : 28
}
