//
//  FruitStatusLabel.swift
//  FruitFruit
//
//  Created by Junyeong Park on 2022/07/15.
//

import UIKit

class FruitStatusLabel: UIView {
    //TODO: 주문 상태별 이미지 뷰 (1). 조건에 따른 이미지 세팅 (2). 확인 안 한 경우 이미지 흔들리는 애니메이션 구현
    
    var statusLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
        setLabel()
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
        shadowLayer.shadowRadius = 10
        shadowLayer.shadowOffset = CGSize(width: 2, height: 6)
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
        borderLayer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        borderLayer.bounds = shapes.bounds
        borderLayer.position = shapes.center
        shapes.layer.insertSublayer(borderLayer, at: 0)
        shapes.layer.cornerRadius = 20
        shapes.layer.borderWidth = 1
        shapes.layer.borderColor = UIColor(red: 0.949, green: 0.957, blue: 0.965, alpha: 1).cgColor
    }
    
    private func setLabel() {
        statusLabel.font = UIFont.preferredFont(for: .subheadline, weight: .bold)
        statusLabel.textColor = UIColor(named: Constants.FruitfruitColors.gray1)
        self.addSubview(statusLabel)
        statusLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16).isActive = true
        statusLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24).isActive = true
        statusLabel.heightAnchor.constraint(equalToConstant: 36).isActive = true
    }
    
    func setLabelText(from text: String) {
        statusLabel.text = text
    }
}
