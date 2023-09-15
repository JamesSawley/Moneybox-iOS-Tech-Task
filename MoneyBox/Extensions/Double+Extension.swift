import Foundation

extension Double {
    
    // Since there is no currency key/value in the AccountResponse, let's assume it's just GBP.
    var currencyString: String {
        "£\(self)"
    }
}
