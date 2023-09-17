//
//  MoneyBoxUITests.swift
//  MoneyBoxUITests
//
//  Created by James Sawley on 17/09/2023.
//

import XCTest

let app = XCUIApplication()

final class MoneyBoxUITests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
    }

    // If I were to be doing this properly I'd have different test cases to test different user journeys
    // Since this app is very simple let's just create one simple smoke test that gives some confidence that
    // the app loads accounts.
    //
    // Ideally for performance reasons this would be run off the network, but for the purposes of this I won't stub
    // the api.
    
    func test_userCanLogInAndRetrieveAccounts() throws {
        app.launchArguments = ["-uiTesting"]
        app.launch()

        XCTAssertTrue(Launch.screen.exists)
        
        XCTAssertTrue(Login.screen.waitForExistence(timeout: 2))
        
        // This would be more representative of what the user is doing if we used the software keyboard
        // and hit the buttons, but for speed let's just type it like this.
        Login.emailField.tap()
        Login.emailField.typeText("test+ios2@moneyboxapp.com")
        Login.passwordField.tap()
        Login.passwordField.typeText("P455word12")
        Keyboard.doneButton.tap()
        Login.loginButton.tap()
        
        XCTAssertTrue(Accounts.planValue.waitForExistence(timeout: 5))
    }
}

enum Launch {
    static let screen = app.otherElements["LaunchAnimation"].firstMatch
}
enum Login {
    static let screen = app.otherElements["Login"].firstMatch
    static let emailField = screen.textFields["emailField"].firstMatch
    static let passwordField = screen.secureTextFields["passwordField"].firstMatch
    static let loginButton = screen.buttons["loginButton"].firstMatch
}
enum Accounts {
    // It turns out that SwiftUI iOS 13 accessibility has some major bugs. Assigning an identifier
    // to a view also assigns the identifier to all the view's children.
    //
    // Working around the problem...
//    static let screen = app.otherElements["Accounts"].firstMatch
    
    static let planValue = app.staticTexts["Plan Value"].firstMatch
}
enum Keyboard {
    private static let keyboard = app.keyboards.firstMatch
    static let doneButton = keyboard.buttons["done"].firstMatch
}
