import Foundation

import Networking

final class UserProvider {
    typealias User = LoginResponse.User

    static var user: User?
}
