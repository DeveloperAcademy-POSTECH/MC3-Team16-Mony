//
//  FruitWeekCell.swift
//  FruitFruit
//
//  Created by Junyeong Park on 2022/07/26.
//

import Foundation
import UIKit

class FruitWeekCell: UITableViewCell, UICollectionViewDelegate {
    static let id = "FruitWeekCell"
    var weekday = [String]()
    var fruitOrderDays = [Int:FruitOrder]()
    
    let fruitWeekCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 40, height: 40)
        layout.minimumInteritemSpacing = .zero
        layout.minimumLineSpacing = 8
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.isScrollEnabled = false
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = false
        view.contentInset = .zero
        view.backgroundColor = .clear
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented.")
    }
    
    func setUI(model: [String], orders: [FruitOrder]) {
        weekday = model
        let weekdayDict = ["일":0, "월":1, "화":2, "수":3, "목":4, "금":5, "토":6]
        for order in orders {
            let day = order.dueDate.dayString
            let dayCnt = weekdayDict[day]!
            if fruitOrderDays[dayCnt] == nil {
                fruitOrderDays[dayCnt] = order
            }
            // 같은 날 더 빨리 주문 완료된 과일만 입력됨
        }
        fruitWeekCollectionView.register(FruitDayCell.self, forCellWithReuseIdentifier: FruitDayCell.id)
        fruitWeekCollectionView.delegate = self
        fruitWeekCollectionView.dataSource = self
        addSubview(fruitWeekCollectionView)
        fruitWeekCollectionView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        fruitWeekCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        fruitWeekCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        fruitWeekCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}

extension FruitWeekCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weekday.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = fruitWeekCollectionView.dequeueReusableCell(withReuseIdentifier: FruitDayCell.id, for: indexPath) as? FruitDayCell else { return FruitDayCell() }
        
        if let order = fruitOrderDays[indexPath.item] {
            cell.imagePrepare(model: order.name.getFruitType)
        } else {
            cell.prepare(model: weekday[indexPath.item])
        }
        return cell
    }
}
