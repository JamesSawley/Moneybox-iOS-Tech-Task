import UIKit

// This isn't particularly re-usable, but since we don't need a text field elsewhere in the app
// this is OK for now.
//
// Probably we should split the style elements of the text field with the functional aspects.

// TODO: Add show/hide functionality for secure text entry

class LoginTextField: UITextField {
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        CGRectInset(bounds, 16, 16)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        CGRectInset(bounds, 16, 16)
    }
    
    func configure(with type: LoginFieldType) {
        tag = type.rawValue
        
        accessibilityIdentifier = type.accessibilityIdentifier
        backgroundColor = .grey
        font = .preferredFont(forTextStyle: .body)
        isSecureTextEntry = type.isSecureTextEntry
        returnKeyType = type.returnKeyType
        
        layer.borderWidth = 2
        layer.cornerRadius = .cornerRadius
        
        updateForEditing()
    }
    
    func updateForEditing() {
        let borderColor: UIColor? = isEditing ? .accent : .systemGray
        layer.borderColor = borderColor?.cgColor
    }
}
