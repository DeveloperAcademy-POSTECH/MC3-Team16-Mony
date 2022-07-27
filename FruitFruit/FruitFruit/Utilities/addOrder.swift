//
//  addOrder.swift
//  FruitFruit
//
//  Created by Junyeong Park on 2022/07/20.
//

import Foundation
import FirebaseFirestore

func addOrder(fruitOrder: FruitOrder) {
    let db = Firestore.firestore()
    guard let fruitOrderDict = fruitOrder.dictionary else { return }
    if let user = Storage().fruitUser {
        let detailCollectionName = "\(user.name) + \(user.nickname)"
        db.collection(Constants.FStore.Orders.collectionName).document(user.id).collection(detailCollectionName).addDocument(data: fruitOrderDict)
    }
}

func addMockOrder(fruitOrder: FruitOrder) {
    let db = Firestore.firestore()
    guard let fruitOrderDict = fruitOrder.dictionary else { return }
    if let user = Storage().fruitUser {
        let detailCollectionName = "\(user.name) \(user.nickname)"
        db.collection(Constants.FStore.Orders.collectionName).document(user.id).collection(detailCollectionName).addDocument(data: fruitOrderDict)
    }
}

func addMockOrder() {
    let db = Firestore.firestore()
    guard let user = Storage().fruitUser else { return }
    let firstDateComponent = DateComponents(year: 2022, month: 5, day: 11, hour: 11)
    let firstDate = Calendar.current.date(from: firstDateComponent)!
    let fruitOrder = FruitOrder(name: "여름오렌지", dueDate: firstDate, amount: 5, price: 200, status: "Arrived", user: user, place: "C5", time: 14)
    guard let fruitOrderDict = fruitOrder.dictionary else { return }
    let detailCollectionName = "\(user.name) \(user.nickname)"
    db.collection(Constants.FStore.Orders.collectionName).document(user.id).collection(detailCollectionName).addDocument(data: fruitOrderDict)
}

func addMockSaleInfo(fruitInfo: FruitSaleInfo) {
    let db = Firestore.firestore()
    guard let fruitInfoDict = fruitInfo.dictionary else { return }
    db.collection(Constants.FStore.SaleInfos.collectionName).addDocument(data: fruitInfoDict)
}
