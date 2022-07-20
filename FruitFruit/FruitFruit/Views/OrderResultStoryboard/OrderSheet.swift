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
    
    let amountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let amountValue: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let data = ["개수", "3개"]
    
    let label1: UILabel = {
        let label = UILabel()
        
        label.text = "label1"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let label2: UILabel = {
        let label = UILabel()
        
        label.text = "label2"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let label3: UILabel = {
        let label = UILabel()
        
        label.text = "label3"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let label4: UILabel = {
        let label = UILabel()
        
        label.text = "label4"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let label5: UILabel = {
        let label = UILabel()
        
        label.text = "label5"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let label6: UILabel = {
        let label = UILabel()
        
        label.text = "label6"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let horizontalView: UIStackView = {
        let horizontalView = UIStackView()
        
        horizontalView.translatesAutoresizingMaskIntoConstraints = false
        horizontalView.axis = .horizontal
        horizontalView.alignment = .fill
        horizontalView.distribution = .equalSpacing
        
        return horizontalView
    }()
    
    let horizontalView2: UIStackView = {
        let horizontalView = UIStackView()
        
        horizontalView.translatesAutoresizingMaskIntoConstraints = false
        horizontalView.axis = .horizontal
        horizontalView.alignment = .fill
        horizontalView.distribution = .equalSpacing
        
        return horizontalView
    }()
    
    let horizontalView3: UIStackView = {
        let horizontalView = UIStackView()
        
        horizontalView.translatesAutoresizingMaskIntoConstraints = false
        horizontalView.axis = .horizontal
        horizontalView.alignment = .fill
        horizontalView.distribution = .equalSpacing
        
        return horizontalView
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        
        return stackView
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
        
        [label1, label2].map {
            horizontalView.addArrangedSubview($0)
        }
        
        [label3, label4].map {
            horizontalView2.addArrangedSubview($0)
        }
        
        [label5, label6].map {
            horizontalView3.addArrangedSubview($0)
        }
        
        [horizontalView, horizontalView2, horizontalView3].map {
            stackView.addArrangedSubview($0)
        }
        
        self.addSubview(stackView)
        stackView.topAnchor.constraint(equalTo: topAnchor, constant: 116).isActive = true
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: 136).isActive = true
        stackView.widthAnchor.constraint(equalToConstant: 294).isActive = true
        
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
    
}
