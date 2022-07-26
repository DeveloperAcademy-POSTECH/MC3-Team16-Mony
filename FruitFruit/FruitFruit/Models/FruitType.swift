//
//  FruitName.swift
//  FruitFruit
//
//  Created by Junyeong Park on 2022/07/21.
//

import Foundation

enum FruitType: String {
    case Orange = "오렌지"
    case Peach = "복숭아"
    case Watermelon = "수박"
    case Banana = "바나나"

    var fruitName: String {
        switch self {
        case .Orange:
            return "Orange"
        case .Peach:
            return "Peach"
        case .Watermelon:
            return "Watermelon"
        case .Banana:
            return "Banana"
        }
    }
    
    var fruitSecondary: String {
        switch self {
        case .Orange:
            return Constants.FruitfruitImages.Fruits.orangeSecondary
        case .Peach:
            return Constants.FruitfruitImages.Fruits.peachSecondary
        case .Watermelon:
            return Constants.FruitfruitImages.Fruits.watermelonSecondary
        case .Banana:
            return Constants.FruitfruitImages.Fruits.bananaSecondary
        }
    }
    
    var fruitColorName: String {
        switch self {
        case .Orange:
            return Constants.FruitfruitColors.orange1
        case .Peach:
            return Constants.FruitfruitColors.peach
        case .Watermelon:
            return Constants.FruitfruitColors.watermelon
        case .Banana:
            return Constants.FruitfruitColors.banana
        }
    }
}
