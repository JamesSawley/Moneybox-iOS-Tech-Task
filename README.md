
# Moneybox iOS Technical Challenge

The project was compiled on Xcode 14.3.1 with Swift 5.8.1.

Since Moneybox supports iOS 13+ I thought it would be fun to create a hybrid UIKit/SwiftUI project. I have experience writing UIKit layouts in code and using storyboard so I have demonstrated both:

* LaunchAnimationController; UIKit with code
* LoginViewController; UIKit with storyboard
* Accounts/AccountDetails; SwiftUI

## Architecture

The app is written using MVVM+C design pattern. Instead of using SwiftUI for navigation within the accounts screens, the [`AccountsCoordinator`](./MoneyBox/Accounts/AccountsCoordinator.swift) is responsible for presenting the SwiftUI views.

## Optional features
Here are some features that weren't included in the brief:
* The app supports dynamic fonts throughout, including a dynamic layout on the accounts screen depending on the user's preferred font selection.
* At launch, the Moneybox logo animates from it's position on the launch screen to it's final position on the accounts screen. 
* The user can log out of their account from the Accounts screen.
* The product interest rate and annual limit (if applicable) are visible from the account details screen.
* The user is logged out after 5 minutes when their token is invalidated.
* In addition to the required unit tests, a simple UI test covers the app launch and login journey.

## Additional features
If I were to dedicate more time to this project, I would:
* Re-write the networking layer to be model agnostic, with a layer of business services in the app handling the communications between the app and the networking module. 
* Use Swift concurrency async/await instead of completion handlers throughout.
* Introduce a base localizable strings file that includes all of the copy.
* Use [SwiftGen](https://github.com/SwiftGen/SwiftGen) for generating type safe strings and images.
* Show error messages to the user when the Account API throws errors.
* Thoroughly test the app using Voiceover, and fix any accessibility bugs.
* Add [Fastlane](https://fastlane.tools) to build/test/deploy.
* Integrate with a CI provider (preferably [Bitrise](https://bitrise.io)) to automate test/deploy of builds.

---

## The Brief

To create a 'light' version of the Moneybox app that will allow existing users to login and check their account balance, as well as viewing their Moneybox savings. 
- To fork this repository to your private repository and implement the solution.
 
### The app should have
- A login screen to allow existing users to sign in
- A screen to show the accounts the user holds, e.g. ISA, GIA
- A screen to show some details of the account, including a simple button to add money to its moneybox.
- The button will add a fixed amount of £10. It should use the `POST /oneoffpayments` endpoint provided, and the account's Moneybox amount would be updated.

A prototype wireframe of all 3 screens is provided as a guideline. You are free to provide additional information if you wish.
![](wireframe.png)

### What we are looking for
 - **Showcase what you can do. It can be a refined UI, or enhanced UX, or use of specific design patterns in the code, or anything that can make the project stand out.**
 - Demonstration of coding style, conventions and patterns.
 - A tidy code organisation.
 - Use of autolayout (preferably UIKit).
 - Implementation of unit tests.
 - Any accessibility feature would be a bonus.
 - The application must run on iOS 13 or later.
 - Any 3rd party library should be integrated using Swift Package Manager.

### API Usage
The Networking methods and Models for requests and responses are ready-made in the Networking module of the project.

#### Base URL & Test User
The base URL for the moneybox sandbox environment is `https://api-test02.moneyboxapp.com/`. </br>
You can log in using the following user:

|  Username          | Password         |
| ------------- | ------------- |
| test+ios2@moneyboxapp.com  | P455word12  |

#### Authentication
You should obtain a bearer token from the Login response, and attach it as an Authorization header for the endpoints. Helper methods in the API/Base folder should be used for that.
(Note: The BearerToken has a sliding expiration of 5 mins).

| Key  |  Value  |
| ------------- | ------------- |
| Authorization |  Bearer TsMWRkbrcu3NGrpf84gi2+pg0iOMVymyKklmkY0oI84= |

#### API Call Hint

```
let dataProvider = DataProvider()
dataProvider.login(request: request, completion: completion)
```
request: Initialize your request model </br>
Completion: Handle your API success and failure cases

## Unit Tests
The MoneyBoxTests folder includes stubbed data to easily mock the responses needed for unit testing

#### Usage Hint
You can create a DataProviderMock class via inject DataProviderLogic protocol </br>
You can mock response in Login.json file like this:
```
StubData.read(file: "Login", callback: completion)
```

### How to Submit your solution:
 - To share your Github repository with the user valerio-bettini.
 - (Optional) Provide a readme in markdown which outlines your solution.

## Good luck!
