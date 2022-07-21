//
//  FruitName.swift
//  FruitFruit
//
//  Created by Junyeong Park on 2022/07/21.
//

import Foundation

enum FruitName: String {
    case Orange = "오렌지"
    case Peach = "복숭아"

    var fruitName: String {
        switch self {
            
        case .Orange:
            return "Orange"
        case .Peach:
            return "Peach"
        }
    }
}
