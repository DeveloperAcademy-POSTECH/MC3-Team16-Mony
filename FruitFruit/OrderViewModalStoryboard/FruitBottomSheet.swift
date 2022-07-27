//
//  FruitBottomSheet.swift
//  FruitFruit
//
//  Created by 유재훈 on 2022/07/27.
//

import UIKit

class FruitBottomSheet: UIView {
    let lbl: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let minusButton: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        backgroundColor = .white
        layer.cornerRadius = 40
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        clipsToBounds = true
        self.addSubview(lbl)
        self.addSubview(minusButton)
        lbl.topAnchor.constraint(equalTo: self.topAnchor, constant: 30).isActive = true
        lbl.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40).isActive = true
        lbl.text = "a"
        setMinus()
    }
    
    private func setMinus() {
        minusButton.addTarget(self, action: #selector(minus), for: .touchUpInside)
    }
    
    @objc private func minus() {
        let value = Int(lbl.text!)!
        if value - 1 == 0 {
            return
        }
        lbl.text = String(value - 1)
    }
    
}
