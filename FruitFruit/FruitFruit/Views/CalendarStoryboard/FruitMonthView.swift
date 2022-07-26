//
//  FruitMonthView.swift
//  FruitFruit
//
//  Created by Junyeong Park on 2022/07/26.
//

import Foundation
import UIKit

class FruitMonthView: UIView {
    var month = [[String]]()
    let monthLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let fruitMonthTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUI(model: MonthModel) {
        guard let blackColor = UIColor(named: Constants.FruitfruitColors.black1) else { return }
        month = model.checkWeekDay()
        addSubview(monthLabel)
        monthLabel.text = "\(model.year)월 \(model.month)월"
        monthLabel.font = UIFont.preferredFont(for: .headline, weight: .semibold)
        monthLabel.textColor = blackColor
        monthLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        monthLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24).isActive = true
        fruitMonthTableView.register(FruitWeekCell.self, forCellReuseIdentifier: FruitWeekCell.id)
        fruitMonthTableView.delegate = self
        fruitMonthTableView.dataSource = self
        addSubview(fruitMonthTableView)
        fruitMonthTableView.backgroundColor = .clear
        fruitMonthTableView.separatorStyle = .none
        fruitMonthTableView.topAnchor.constraint(equalTo: monthLabel.bottomAnchor, constant: 20).isActive = true
        fruitMonthTableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        fruitMonthTableView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        fruitMonthTableView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}

extension FruitMonthView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return month.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FruitWeekCell.id, for: indexPath) as? FruitWeekCell else { return FruitWeekCell() }
        cell.setUI(model: month[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
}
