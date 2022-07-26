//
//  Storage.swift
//  FruitFruit
//
//  Created by Junyeong Park on 2022/07/19.
//

import Foundation

struct Storage {
    static let userDefaults = UserDefaults.standard
    
    func setFruitUser(fruitUser: FruitUser) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(fruitUser) {
            UserDefaults.standard.setValue(encoded, forKey: "FruitUser")
        }
    }
    
    var fruitUser: FruitUser? {
//        return FruitUser(name: "박준영", nickname: "노아")
        if let savedData = Storage.userDefaults.object(forKey: "FruitUser") as? Data {
            let decoder = JSONDecoder()
            if let fruitUser = try? decoder.decode(FruitUser.self, from: savedData) {
                return fruitUser
            }
        }
        return nil
    }
}
