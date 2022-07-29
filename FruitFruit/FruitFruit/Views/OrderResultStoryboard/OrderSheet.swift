//
//  OrderSheet.swift
//  FruitFruit
//
//  Created by 김유나 on 2022/07/20.
//

import UIKit

class OrderSheet: UIView {
    
    let secondaryTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var fruitLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let sheetTable: SheetTable = {
        let sheetTable = SheetTable()
        sheetTable.translatesAutoresizingMaskIntoConstraints = false
        return sheetTable
    }()
    
    let account: AccountRow = {
        let accountRow = AccountRow()
        accountRow.translatesAutoresizingMaskIntoConstraints = false
        return accountRow
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        setBackground()
        setLabels()
        setSheetTable()
        setDivider()
        setAccount()
    }
    
    func prepare(orderInfo: FruitOrder) {
        secondaryTitleLabel.text = orderInfo.statusEnum == .Canceled ? "주문 취소 내역" : "주문내역"
        
        fruitLabel.text = orderInfo.name
        fruitLabel.textColor = UIColor(named: orderInfo.statusEnum == .Canceled ? Constants.FruitfruitColors.gray1 : Constants.FruitfruitColors.black1)
        
        sheetTable.sheetRowAmount.value.text = String(orderInfo.amount) + "개"
        sheetTable.sheetRowAmount.value.textColor = UIColor(named: orderInfo.statusEnum == .Canceled ? Constants.FruitfruitColors.gray1 : Constants.FruitfruitColors.black1)
        
        sheetTable.sheetRowPrice.value.text = setTotalPriceToString(price: orderInfo.totalPrice)
        sheetTable.sheetRowPrice.value.textColor = UIColor(named: orderInfo.statusEnum == .Canceled ? Constants.FruitfruitColors.gray1 : Constants.FruitfruitColors.black1)
        
        sheetTable.sheetRowPlace.value.text = orderInfo.place
        sheetTable.sheetRowPlace.value.textColor = UIColor(named: orderInfo.statusEnum == .Canceled ? Constants.FruitfruitColors.gray1 : Constants.FruitfruitColors.black1)
        
        sheetTable.sheetRowTime.value.text = setTimeToString(time: orderInfo.time)
        sheetTable.sheetRowTime.value.textColor = UIColor(named: orderInfo.statusEnum == .Canceled ? Constants.FruitfruitColors.gray1 : Constants.FruitfruitColors.black1)
        
        account.accountText.textColor = UIColor(named: orderInfo.statusEnum == .Checking ? Constants.FruitfruitColors.orange1 : Constants.FruitfruitColors.gray1)
        account.accountImage.tintColor = UIColor(named: orderInfo.statusEnum == .Checking ? Constants.FruitfruitColors.orange1 : Constants.FruitfruitColors.gray1)
        
    }

}

extension OrderSheet {
    
    private func setBackground() {
        self.backgroundColor = .clear
        setShadow()
        setBorder()
    }
    
    private func setShadow() {
        let shadows = UIView()
        shadows.frame = self.frame
        shadows.clipsToBounds = false
        self.addSubview(shadows)
        
        let shadowPath = UIBezierPath(roundedRect: shadows.bounds, cornerRadius: 20)
        let shadowLayer = CALayer()
        shadowLayer.shadowPath = shadowPath.cgPath
        shadowLayer.shadowColor = UIColor(named: Constants.FruitfruitColors.gray2)?.cgColor
        shadowLayer.shadowOpacity = 1
        shadowLayer.shadowRadius = 20
        shadowLayer.shadowOffset = CGSize(width: 0, height: 4)
        shadowLayer.bounds = shadows.bounds
        shadowLayer.position = shadows.center
        shadows.layer.addSublayer(shadowLayer)
    }
    
    private func setBorder() {
        let shapes = UIView()
        shapes.frame = self.frame
        shapes.clipsToBounds = true
        self.addSubview(shapes)
        
        let borderLayer = CALayer()
        borderLayer.backgroundColor = UIColor.white.cgColor
        borderLayer.bounds = shapes.bounds
        borderLayer.position = shapes.center
        shapes.layer.insertSublayer(borderLayer, at: 0)
        shapes.layer.cornerRadius = 25
        shapes.layer.borderWidth = 1
        shapes.layer.borderColor = UIColor(named: Constants.FruitfruitColors.gray2)?.cgColor
    }
    
    private func setLabels() {
        self.addSubview(secondaryTitleLabel)
        self.addSubview(fruitLabel)
        
        secondaryTitleLabel.font = UIFont.preferredFont(for: .headline, weight: .bold)
        secondaryTitleLabel.textColor = UIColor(named: Constants.FruitfruitColors.gray1)
        secondaryTitleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 24).isActive = true
        secondaryTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24).isActive = true
        secondaryTitleLabel.heightAnchor.constraint(equalToConstant: 36).isActive = true
        
        fruitLabel.font = UIFont.preferredFont(for: .title1, weight: .bold)
        fruitLabel.topAnchor.constraint(equalTo: topAnchor, constant: 70).isActive = true
        fruitLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24).isActive = true
        fruitLabel.heightAnchor.constraint(equalToConstant: 36).isActive = true
    }
    
    private func setSheetTable() {
        self.addSubview(sheetTable)
    }
    
    private func setDivider() {
        let divider: CGRect = CGRect(x: 24, y: 288, width: 294, height: 1)
        let dividerView = UIView(frame: divider)
        self.addSubview(dividerView)
        dividerView.backgroundColor = UIColor(named: Constants.FruitfruitColors.gray2)
    }
    
    private func setAccount() {
        self.addSubview(account)
        account.topAnchor.constraint(equalTo: topAnchor, constant: 319).isActive = true
        account.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 34).isActive = true
        account.widthAnchor.constraint(equalToConstant: 270).isActive = true
        account.heightAnchor.constraint(equalToConstant: 21).isActive = true
    }
    
    private func setTotalPriceToString(price: Int) -> String {
        let result: String
        let numberFormatter = NumberFormatter()
        
        numberFormatter.numberStyle = .decimal
        result = numberFormatter.string(from: NSNumber(value: price))!
        return result + "원"
    }
    
    private func setTimeToString(time: Int) -> String {
        var hour: Int
        
        if time > 12 {
            hour = time - 12
            return "오후 " + String(hour) + "시 "
        } else {
            return "오전 " + String(time) + "시 "
        }
    }
    
}
