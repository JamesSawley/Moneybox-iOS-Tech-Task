import Foundation

import Networking

class DataProviderLogicMock: DataProviderLogic {
    
    // These mocks return syncronously. If we wanted we could bounce them into a `DispatchQueue.main.async`
    // block and handle the async behaviour with expectations in our unit tests.
    
    var loginReturnValue: Result<Networking.LoginResponse, Error>!
    func login(request: Networking.LoginRequest, completion: @escaping ((Result<Networking.LoginResponse, Error>) -> Void)) {
        completion(self.loginReturnValue)
    }
    
    var fetchProductsReturnValue: Result<Networking.AccountResponse, Error>!
    func fetchProducts(completion: @escaping ((Result<Networking.AccountResponse, Error>) -> Void)) {
        completion(fetchProductsReturnValue)
    }
    
    var addMoneyReturnValue: Result<Networking.OneOffPaymentResponse, Error>!
    func addMoney(request: Networking.OneOffPaymentRequest, completion: @escaping ((Result<Networking.OneOffPaymentResponse, Error>) -> Void)) {
        completion(addMoneyReturnValue)
    }
}
