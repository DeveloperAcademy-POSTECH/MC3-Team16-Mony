//
//  User.swift
//  FruitFruit
//
//  Created by Junyeong Park on 2022/07/13.
//

import Foundation

struct FruitUser: Codable {
    let id = UUID().uuidString
    var name: String
    var nickname: String
}
