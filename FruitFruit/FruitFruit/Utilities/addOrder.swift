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
        db.collection(Constants.FStore.Orders.collectionName).document(detailCollectionName).collection(detailCollectionName).addDocument(data: fruitOrderDict)
    }
}

func addMockSaleInfo(fruitInfo: FruitSaleInfo) {
    let db = Firestore.firestore()
    guard let fruitInfoDict = fruitInfo.dictionary else { return }
    db.collection(Constants.FStore.SaleInfos.collectionName).document()
}
