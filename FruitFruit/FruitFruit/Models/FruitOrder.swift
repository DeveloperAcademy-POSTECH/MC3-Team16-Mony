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
}




// Checking -> HomeView (
// -> OrderView

// 1 입금 확인 전 2 입금 확인 완료 3 주문 완료 4 배송 완료 5 취소
