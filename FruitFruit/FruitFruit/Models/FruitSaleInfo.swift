//
//  FruitSaleInfo.swift
//  FruitFruit
//
//  Created by Junyeong Park on 2022/07/19.
//

import Foundation

struct FruitSaleInfo: Codable {
    let fruitSaleId: String
    let shopName: String
    let fruitName: String
    let price: Int
    let fruitOrigin: String
    let saleDate: Date
    var place: String
    var time: Int
    
    var fruitType: FruitType {
        return fruitName.getFruitType
    }
    
    var fruitImagePrimary: String {
        return "Fruitfruit_\(convertFruit(fruit: fruitName))_Primary"
    }
    var fruitImageSecondary: String {
        return "Fruitfruit_\(convertFruit(fruit: fruitName))_Secondary"
    }
}
