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

// 이미지 컨트롤 -> "어떤" 과일인지 이 원소가 fruitName으로 가지고 있기 때문 <-> 어떤 이미지를 보여줄지는 뷰에서 결정하기 때문

// 1. 여러 개의 과일 중 오렌지 선택 -> 2. 어떤 뷰? (홈뷰/주문뷰인지) -> 프라이머리/세컨더리 이미지 두 개.
// 뷰 컨트롤러에서 직접 호출해야하고 핸들링해야 함. 코드상으로
// FruitSaleInfo -> VC return computed -> "s/p"
// VC -> orange -> secondary

//
