//
//  SheetTable.swift
//  FruitFruit
//
//  Created by 김유나 on 2022/07/20.
//

import UIKit

class SheetTable: UIView {

    let sheetRowAmount: SheetRowAmount = {
        let orderSheet = SheetRowAmount()
        orderSheet.translatesAutoresizingMaskIntoConstraints = false
        return orderSheet
    }()
    
    let sheetRowPrice: SheetRowPrice = {
        let orderSheet = SheetRowPrice()
        orderSheet.translatesAutoresizingMaskIntoConstraints = false
        return orderSheet
    }()
    
    let sheetRowPlace: SheetRowPlace = {
        let orderSheet = SheetRowPlace()
        orderSheet.translatesAutoresizingMaskIntoConstraints = false
        return orderSheet
    }()
    
    let sheetRowTime: SheetRowTime = {
        let orderSheet = SheetRowTime()
        orderSheet.translatesAutoresizingMaskIntoConstraints = false
        return orderSheet
    }()
    
    let sheetTable: UIStackView = {
        let sheetTable = UIStackView()
        sheetTable.translatesAutoresizingMaskIntoConstraints = false
        sheetTable.axis = .vertical
        sheetTable.alignment = .fill
        sheetTable.distribution = .fillEqually
        return sheetTable
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUI() {
        [sheetRowAmount, sheetRowPrice, sheetRowPlace, sheetRowTime].map {
            sheetTable.addArrangedSubview($0)
        }
        
        self.addSubview(sheetTable)
        sheetTable.topAnchor.constraint(equalTo: topAnchor, constant: 120).isActive = true
        sheetTable.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24).isActive = true
        sheetTable.heightAnchor.constraint(equalToConstant: 136).isActive = true
    }
    
}
