//
//  Storage.swift
//  FruitFruit
//
//  Created by Junyeong Park on 2022/07/19.
//

import Foundation

struct Storage {
    static let defaults = UserDefaults.standard
    
    var fruitUser: FruitUser? {
        return FruitUser(name: "박준영", nickname: "노아")
//        if let savedData = Storage.defaults.object(forKey: "FruitUser") as? Data {
//            let decoder = JSONDecoder()
//            if let fruitUser = try? decoder.decode(FruitUser.self, from: savedData) {
//                return fruitUser
//            }
//        }
    }
}
