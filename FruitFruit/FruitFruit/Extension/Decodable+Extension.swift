//
//  Decodable+Extension.swift
//  FruitFruit
//
//  Created by Junyeong Park on 2022/07/20.
//

import Foundation

extension Decodable {
    static func decode<T: Decodable>(dictionary: [String:Any]) throws -> T {
        let data = try JSONSerialization.data(withJSONObject: dictionary, options: [.fragmentsAllowed])
        return try JSONDecoder().decode(T.self, from: data)
    }
}
