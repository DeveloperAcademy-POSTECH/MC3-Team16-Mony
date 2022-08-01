//
//  SheetRow.swift
//  FruitFruit
//
//  Created by 김유나 on 2022/07/20.
//

import UIKit

class SheetRow: UIView {
    
    var label: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(for: .subheadline, weight: .bold)
        return label
    }()
    
    var value: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(for: .subheadline, weight: .bold)
        return label
    }()
    
    let row: UIStackView = {
        let row = UIStackView()
        row.translatesAutoresizingMaskIntoConstraints = false
        row.axis = .horizontal
        row.alignment = .fill
        row.distribution = .equalSpacing
        return row
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUI() {
        row.widthAnchor.constraint(equalToConstant: 294).isActive = true
        [label, value].map {
            row.addArrangedSubview($0)
        }
        self.addSubview(row)
    }
}
