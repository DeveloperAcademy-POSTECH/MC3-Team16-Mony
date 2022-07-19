//
//  FruitSaleInfo.swift
//  FruitFruit
//
//  Created by Junyeong Park on 2022/07/19.
//

import Foundation

struct FruitSaleInfo: Codable {
    let shopName: String
    let fruitName: String
    let price: Int
    let fruitOrigin: String
    let saleDate: Date
    var place: String
    var time: Int
    
    var fruitImagePrimary: String {
        return "Fruitfruit_\(fruitName)_Primary"
    }
    var fruitImageSecondary: String {
        return "Fruitfruit_\(fruitName)_Secondary"
    }
}
