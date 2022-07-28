//
//  FruitMonthCell.swift
//  FruitFruit
//
//  Created by Junyeong Park on 2022/07/27.
//

import Foundation
import UIKit

class FruitMonthCell: UITableViewCell {
    static let id = "FruitMonthCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented.")
    }
    
    func setUI(model: MonthModel, orders: [FruitOrder]) {
        backgroundColor = .clear
        let fruitMonthView = FruitMonthView()
        fruitMonthView.setUI(model: model, orders: orders)
        let _ = subviews.map{ $0.removeFromSuperview() }
        insertSubview(fruitMonthView, at: 0)
    }    
}
