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
    var fruitOrderWeek = [Int:[FruitOrder]]()
    var todayPosition: (Int, Int)?
    
    
    let monthLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let fruitMonthTableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented.")
    }
    
    func setUI(model: MonthModel, orders: [FruitOrder]) {
        month = model.checkWeekDay()
        for order in orders {
            if let position = model.getDatePosition(from: order.dueDate) {
                let weekPos = position.0
                let dayPos = position.1
                var savedData = fruitOrderWeek[weekPos] ?? []
                print(weekPos, dayPos)
                savedData.append(order)
                fruitOrderWeek[weekPos] = savedData
            }
        }
        
        if let position = model.getDatePosition(from: Date()) {
            todayPosition = position
        }
        
        guard let blackColor = UIColor(named: Constants.FruitfruitColors.black1) else { return }
        addSubview(monthLabel)
        monthLabel.text = "\(model.year)월 \(model.month)월"
        monthLabel.font = UIFont.preferredFont(for: .subheadline, weight: .semibold)
        monthLabel.textColor = blackColor
        monthLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        monthLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        fruitMonthTableView.register(FruitWeekCell.self, forCellReuseIdentifier: FruitWeekCell.id)
        fruitMonthTableView.delegate = self
        fruitMonthTableView.dataSource = self
        addSubview(fruitMonthTableView)
        fruitMonthTableView.backgroundColor = .clear
        fruitMonthTableView.separatorStyle = .none
        fruitMonthTableView.widthAnchor.constraint(equalToConstant: 328).isActive = true
        let height = CGFloat(month.count * 40 + (month.count) * 17 + 2)
        fruitMonthTableView.heightAnchor.constraint(equalToConstant: height).isActive = true
        fruitMonthTableView.topAnchor.constraint(equalTo: monthLabel.bottomAnchor, constant: 11).isActive = true
        fruitMonthTableView.leadingAnchor.constraint(equalTo: monthLabel.leadingAnchor, constant: 7).isActive = true
        fruitMonthTableView.reloadData()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        print("TOUCHES")
    }
}

extension FruitMonthView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return month.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FruitWeekCell.id, for: indexPath) as? FruitWeekCell else { return FruitWeekCell() }
        let fruitOrders = fruitOrderWeek[indexPath.section] ?? []
        
        if let position = todayPosition {
            let weekPos = position.0
            let dayPos = position.1
            cell.setUI(model: month[indexPath.section], orders: fruitOrders, todayPos: indexPath.section == weekPos ? dayPos : nil)
        } else {
            cell.setUI(model: month[indexPath.section], orders: fruitOrders, todayPos: nil)
        }
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 0 {
            return 2
        } else if section == month.count - 1{
            return 0
        } else {
            return 17
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        footerView.backgroundColor = .clear
        return footerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("MONTHVIEWCELL")
    }
}
