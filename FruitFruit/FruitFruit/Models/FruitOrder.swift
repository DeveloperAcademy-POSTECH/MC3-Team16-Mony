//
//  FruitOrder.swift
//  FruitFruit
//
//  Created by Junyeong Park on 2022/07/19.
//

import Foundation

struct FruitOrder: Codable {
    let name: String
    let dueDate: Date
    //TODO: dueDate가 해당 주문 상태 라벨을 보여주는 기준
    let amount: Int
    let price: Int
    let status: String
    let user: FruitUser
    var place: String
    var time: Int
    
    var statusEnum: FruitStatus {
        return FruitStatus(rawValue: status) ?? FruitStatus.Canceled
    }
    
    var fruitType: FruitType {
        return name.getFruitType
    }
    
    var totalPrice: Int {
        return price * amount
    }
    
    var twelveHourClock: String {
        if time > 12 {
            return "오후 \(time - 12)시"
        } else if time == 12 {
            return "정오"
        } else {
            return "오전 \(time)시"
        }
    }
}
