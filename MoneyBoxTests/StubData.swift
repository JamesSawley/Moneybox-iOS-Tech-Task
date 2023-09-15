//
//  StubData.swift
//  MoneyBoxTests
//
//  Created by Zeynep Kara on 17.01.2022.
//

import Foundation
@testable import MoneyBox

struct StubData {
    static func read<V: Decodable>(file: String) -> Result<V, Error> {
        if let path = Bundle.main.path(forResource: file, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let result = try JSONDecoder().decode(V.self, from: data)
                return .success(result)
            } catch {
                return .failure(NSError.error(with: "stub decoding error"))
            }
        } else {
            return .failure(NSError.error(with: "no json file"))
        }
    }
}
