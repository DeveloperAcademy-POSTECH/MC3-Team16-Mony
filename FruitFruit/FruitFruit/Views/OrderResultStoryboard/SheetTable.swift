//
//  SheetTable.swift
//  FruitFruit
//
//  Created by 김유나 on 2022/07/20.
//

import UIKit

class SheetTable: UIView {
    //TODO: OrderView or DB에서 전달 받은 데이터 배치

    let sheetRowAmount: SheetRow = {
        let sheet = SheetRow()
        sheet.translatesAutoresizingMaskIntoConstraints = false
        sheet.label.text = "개수"
        return sheet
    }()
    
    let sheetRowPrice: SheetRow = {
        let sheet = SheetRow()
        sheet.translatesAutoresizingMaskIntoConstraints = false
        sheet.label.text = "금액"
        return sheet
    }()
    
    let sheetRowPlace: SheetRow = {
        let sheet = SheetRow()
        sheet.translatesAutoresizingMaskIntoConstraints = false
        sheet.label.text = "수령장소"
        return sheet
    }()
    
    let sheetRowTime: SheetRow = {
        let sheet = SheetRow()
        sheet.translatesAutoresizingMaskIntoConstraints = false
        sheet.label.text = "시간"
        return sheet
    }()
    
    let sheetTable: UIStackView = {
        let table = UIStackView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.axis = .vertical
        table.alignment = .fill
        table.distribution = .fillEqually
        return table
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
