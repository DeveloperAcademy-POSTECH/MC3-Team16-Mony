//
//  FruitCellButton.swift
//  FruitFruit
//
//  Created by Junyeong Park on 2022/07/16.
//

import UIKit

class FruitCellButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI(frame: CGRect) {
        self.backgroundColor = .clear
        self.layer.cornerRadius = 20
        let fruitCellButtonView = FruitCellButtonView(frame: frame)
        insertSubview(fruitCellButtonView, at: 0)
        //TODO: UIView -> UIImage 렌더링 -> setImage 실패 이유 알아보기 (optional)
        //TODO: 커스텀 Button -> 클릭 이벤트 모션 (Glowing) 실패 -> 유사 효과 구현하기
    }
}
