import SwiftUI
import UIKit

// TODO: Use Swiftgen to provide type safety
// https://github.com/SwiftGen/SwiftGen

// Custom colours taken from https://www.moneyboxapp.com/android-the-moneybox-app-dark-theme/

extension UIColor {
    static let accent = UIColor(named: "AccentColor")
    static let background = UIColor(named: "Background")
    static let grey = UIColor(named: "GreyColor")
}

extension Color {
    static let accent = Color("AccentColor")
    static let background = Color("Background")
    static let grey = Color("GreyColor")
}
