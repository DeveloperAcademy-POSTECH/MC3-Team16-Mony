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
}
