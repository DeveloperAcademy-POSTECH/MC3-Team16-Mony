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
    
    let fruitLabel: UILabel = {
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
        
        secondaryTitleLabel.text = "주문내역"
        secondaryTitleLabel.font = UIFont.preferredFont(for: .headline, weight: .bold)
        secondaryTitleLabel.textColor = UIColor(named: Constants.FruitfruitColors.gray1)
        secondaryTitleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 24).isActive = true
        secondaryTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24).isActive = true
        secondaryTitleLabel.heightAnchor.constraint(equalToConstant: 36).isActive = true
        
        fruitLabel.text = "여름오렌지"
        fruitLabel.font = UIFont.preferredFont(for: .title1, weight: .bold)
        fruitLabel.textColor = UIColor(named: Constants.FruitfruitColors.black)
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
    }
}


