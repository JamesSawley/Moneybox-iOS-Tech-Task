import SwiftUI
import UIKit

// This could be subclassed to provide different styles
// - PrimaryRoundedButton
// - SecondaryRoundedButton
// - etc.

class RoundedButton: UIButton {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        layer.cornerRadius = .cornerRadius
        backgroundColor = .accent
        tintColor = .white
    }
}
