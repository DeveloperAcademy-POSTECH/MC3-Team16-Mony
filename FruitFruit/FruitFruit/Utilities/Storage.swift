//
//  Storage.swift
//  FruitFruit
//
//  Created by Junyeong Park on 2022/07/19.
//

import Foundation

struct Storage {
    let defaults = UserDefaults.standard
    
    var fruitUser: FruitUser? {
        if let fruitUser = defaults.object(forKey: "FruitUser") as? FruitUser {
            return fruitUser
        } else {
            return nil
        }
    }
}
