//
//  convertFruit.swift
//  FruitFruit
//
//  Created by Junyeong Park on 2022/07/19.
//

import Foundation

func convertFruit(fruit: String) -> String {
    switch fruit {
    case "오렌지": return "Orange"
    case "복숭아": return "Peach"
    case "수박": return "Watermelon"
    default: return "푸릇푸릇"
    }
}
