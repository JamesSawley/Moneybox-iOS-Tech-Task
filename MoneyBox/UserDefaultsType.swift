import Foundation

protocol UserDefaultsType {
    func string(forKey defaultName: String) -> String?
    func set(_ value: Any?, forKey defaultName: String)
}
extension UserDefaults: UserDefaultsType {}
