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
    
    let fruitWeekCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 40, height: 40)
        layout.minimumInteritemSpacing = .zero
        layout.minimumLineSpacing = .zero
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
    
    func setUI(model: [String]) {
        print(model)
        frame.size = CGSize(width: 280, height: 40)
        weekday = model
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
        cell.prepare(model: weekday[indexPath.item])
        return cell
    }
}
