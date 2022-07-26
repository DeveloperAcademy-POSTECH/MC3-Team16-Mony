//
//  CalendarViewController.swift
//  FruitFruit
//
//  Created by Junyeong Park on 2022/07/26.
//

import UIKit
import FirebaseFirestore

class CalendarViewController: UIViewController, UIGestureRecognizerDelegate {
    var fruitArrivedOrders = [FruitOrder]()
    let database = Firestore.firestore()

    override func viewDidLoad() {
        super.viewDidLoad()
        initCalendarViewUI()
    }
    
    private func initCalendarViewUI() {
        initCalendarViewNavBar()
        fetchOrders()
    }
    
    private func initCalendarViewNavBar() {
        guard let orangeColor = UIColor(named: Constants.FruitfruitColors.orange1) else { return }
        guard let blackColor = UIColor(named: Constants.FruitfruitColors.black1) else { return }
        let backButtonImage = UIImage(systemName: "chevron.left")?.withTintColor(orangeColor, renderingMode: .alwaysOriginal)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: backButtonImage, style: .done, target: self, action: #selector(popToPrevious))
        navigationItem.title = "푸릇푸릇 달력"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: blackColor, NSAttributedString.Key.font: UIFont.preferredFont(for: .headline, weight: .bold)]
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    @objc private func popToPrevious() {
        navigationController?.popViewController(animated: true)
    }
    
    private func fetchOrders() {
        guard let user = Storage().fruitUser else { return }
        let detailCollectionName = "\(user.name) \(user.nickname)"
        database.collection(Constants.FStore.Orders.collectionName).document(user.id).collection(detailCollectionName).whereField("status", isEqualTo: "Arrived").getDocuments { querySnapShot, error in
            // addSnapShotListener -> 네비게이션 클릭 시점 문서만 불러오기
            self.fruitArrivedOrders = []
            if let error = error {
                print(error.localizedDescription)
            } else {
                if let documents = querySnapShot?.documents {
                    for document in documents {
                        let data = document.data()
                        do {
                            let fruitOrder: FruitOrder = try FruitOrder.decode(dictionary: data)
                            self.fruitArrivedOrders.append(fruitOrder)
                        } catch {
                            print(error)
                        }
                    }
                    DispatchQueue.main.async {
                        //TODO: 달력 UI에 데이터 세팅하기
                        self.setCalendarUI()
                    }
                }
            }
        }
    }
    
    private func setCalendarUI() {
        for order in fruitArrivedOrders {
            print(order.name)
            print(order.status)
        }
    }
}