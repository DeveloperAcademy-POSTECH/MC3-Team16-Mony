//
//  FruitCell.swift
//  FruitFruit
//
//  Created by Junyeong Park on 2022/07/16.
//

import UIKit

class FruitCell: UITableViewCell {
    static let identifier = "FruitCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented.")
    }
    
    func setUI(frame: CGRect, model: FruitSaleInfo) {
        self.textLabel?.text = model.fruitName
        self.backgroundColor = .clear
        self.layer.cornerRadius = 20
        let fruitCellButtonView = FruitCellButtonView(frame: CGRect(x:0, y:0, width: frame.width, height: frame.height))
        fruitCellButtonView.setUI(model)
        fruitCellButtonView.isUserInteractionEnabled = false
        let _ = self.subviews.map { $0.removeFromSuperview() }
        insertSubview(fruitCellButtonView, at: 0)
        //TODO: 커스텀 Button -> 클릭 이벤트 모션 (Glowing) 실패 -> 유사 효과 구현하기
    }
}

//TODO: 테이블 뷰 사용 셀 커스텀하기

