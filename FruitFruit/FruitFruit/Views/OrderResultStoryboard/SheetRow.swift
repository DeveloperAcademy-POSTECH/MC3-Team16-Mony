//
//  SheetRow.swift
//  FruitFruit
//
//  Created by 김유나 on 2022/07/20.
//

import UIKit

class SheetRowAmount: UIView {
    
    let amountLabel: UILabel = {
        let label = UILabel()
        label.text = "개수"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(for: .subheadline, weight: .bold)
        label.textColor = UIColor(named: Constants.FruitfruitColors.gray1)
        return label
    }()
    
    let amountValue: UILabel = {
        let label = UILabel()
        label.text = "3개"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(for: .subheadline, weight: .bold)
        label.textColor = UIColor(named: Constants.FruitfruitColors.black)
        return label
    }()
    
    let amountRow: UIStackView = {
        let amountRow = UIStackView()
        amountRow.translatesAutoresizingMaskIntoConstraints = false
        amountRow.axis = .horizontal
        amountRow.alignment = .fill
        amountRow.distribution = .equalSpacing
        return amountRow
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUI() {
        amountRow.widthAnchor.constraint(equalToConstant: 294).isActive = true
        
        [amountLabel, amountValue].map {
            amountRow.addArrangedSubview($0)
        }
        
        self.addSubview(amountRow)
    }
}

class SheetRowPrice: UIView {
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.text = "금액"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(for: .subheadline, weight: .bold)
        label.textColor = UIColor(named: Constants.FruitfruitColors.gray1)
        return label
    }()
    
    let priceValue: UILabel = {
        let label = UILabel()
        label.text = "2,400원"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(for: .subheadline, weight: .bold)
        label.textColor = UIColor(named: Constants.FruitfruitColors.black)
        return label
    }()
    
    let priceRow: UIStackView = {
        let priceRow = UIStackView()
        priceRow.translatesAutoresizingMaskIntoConstraints = false
        priceRow.axis = .horizontal
        priceRow.alignment = .fill
        priceRow.distribution = .equalSpacing
        return priceRow
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUI() {
        
        priceRow.widthAnchor.constraint(equalToConstant: 294).isActive = true

        [priceLabel, priceValue].map {
            priceRow.addArrangedSubview($0)
        }
        
        self.addSubview(priceRow)
    }
}

class SheetRowPlace: UIView {
    
    private let placeLabel: UILabel = {
        let label = UILabel()
        label.text = "수령장소"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(for: .subheadline, weight: .bold)
        label.textColor = UIColor(named: Constants.FruitfruitColors.gray1)
        return label
    }()
    
    private let placeValue: UILabel = {
        let label = UILabel()
        label.text = "포스텍 C5"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(for: .subheadline, weight: .bold)
        label.textColor = UIColor(named: Constants.FruitfruitColors.black)
        return label
    }()
    
    private let placeRow: UIStackView = {
        let placeRow = UIStackView()
        placeRow.translatesAutoresizingMaskIntoConstraints = false
        placeRow.axis = .horizontal
        placeRow.alignment = .fill
        placeRow.distribution = .equalSpacing
        return placeRow
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUI() {
        placeRow.widthAnchor.constraint(equalToConstant: 294).isActive = true
        [placeLabel, placeValue].map {
            placeRow.addArrangedSubview($0)
        }
        self.addSubview(placeRow)
    }
}

class SheetRowTime: UIView {
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.text = "시간"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(for: .subheadline, weight: .bold)
        label.textColor = UIColor(named: Constants.FruitfruitColors.gray1)
        return label
    }()
    
    private let timeValue: UILabel = {
        let label = UILabel()
        label.text = "오후 1시"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(for: .subheadline, weight: .bold)
        label.textColor = UIColor(named: Constants.FruitfruitColors.black)
        return label
    }()
    
    private let timeRow: UIStackView = {
        let timeRow = UIStackView()
        timeRow.translatesAutoresizingMaskIntoConstraints = false
        timeRow.axis = .horizontal
        timeRow.alignment = .fill
        timeRow.distribution = .equalSpacing
        return timeRow
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUI() {
        timeRow.widthAnchor.constraint(equalToConstant: 294).isActive = true
        [timeLabel, timeValue].map {
            timeRow.addArrangedSubview($0)
        }
        self.addSubview(timeRow)
    }
}
