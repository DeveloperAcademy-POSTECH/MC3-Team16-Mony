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
    guard let user = Storage().fruitUser else { return }
    db.collection(Constants.FStore.Orders.collectionName).document(user.id).collection(Constants.FStore.Orders.collectionPath).addDocument(data: fruitOrderDict)
    let data = [Constants.FStore.Users.idField : user.id, Constants.FStore.Users.nameField : user.name, Constants.FStore.Users.nicknameField : user.nickname] as [String : Any]
    db.collection(Constants.FStore.SaleInfos.collectionName).document(fruitOrder.saleFruitId).collection(Constants.FStore.SaleInfos.collectionPath).document(user.id).setData(data)
}

func addMockSaleInfo(fruitInfo: FruitSaleInfo) {
    let db = Firestore.firestore()
    guard let fruitInfoDict = fruitInfo.dictionary else { return }
    db.collection(Constants.FStore.SaleInfos.collectionName).document(fruitInfo.fruitSaleId).setData(fruitInfoDict)
}
