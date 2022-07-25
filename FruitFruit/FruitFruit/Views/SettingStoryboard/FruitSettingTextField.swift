//
//  FruitSettingTextField.swift
//  FruitFruit
//
//  Created by Junyeong Park on 2022/07/25.
//

import UIKit

class FruitSettingTextField: UITextField {
    let bottomBorder: UIView = {
        let border = UIView.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        border.translatesAutoresizingMaskIntoConstraints = false
        return border
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        guard let orangeColor = UIColor(named: Constants.FruitfruitColors.orange1) else { return }
        guard let blackColor = UIColor(named: Constants.FruitfruitColors.black1) else { return }
        textColor = blackColor
        tintColor = orangeColor
        setBottomBorder()
    }
    
    private func setBottomBorder() {
        addSubview(bottomBorder)
        bottomBorder.topAnchor.constraint(equalTo: bottomAnchor, constant: 3).isActive = true
        bottomBorder.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        bottomBorder.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        bottomBorder.heightAnchor.constraint(equalToConstant: 2).isActive = true
    }
}
