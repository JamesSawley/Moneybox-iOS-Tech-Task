import Foundation

extension Double {
    
    // Since there is no currency key/value in the AccountResponse, let's assume it's just GBP.
    var currencyString: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "GBP"
        formatter.roundingMode = .halfUp
        return formatter.string(from: NSNumber(value: self)) ?? "£\(String(format: "%.2f", self))"
    }
}
