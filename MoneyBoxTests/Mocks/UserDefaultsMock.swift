import Foundation

@testable import MoneyBox

class UserDefaultsMock: UserDefaultsType {
    private var values = [String: Any]()
    
    func string(forKey defaultName: String) -> String? {
        values[defaultName] as? String
    }
    
    func set(_ value: Any?, forKey defaultName: String) {
        values[defaultName] = value
    }
}
