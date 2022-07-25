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
    //TODO: contains하는 과일 종류 따라서 Enum

    var fruitName: String {
        switch self {
        case .Orange:
            return "Orange"
        case .Peach:
            return "Peach"
        case .Watermelon:
            return "Watermelon"
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
        }
    }
}
