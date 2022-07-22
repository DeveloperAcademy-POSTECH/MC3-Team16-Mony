//
//  AccountRow.swift
//  FruitFruit
//
//  Created by 김유나 on 2022/07/20.
//

import UIKit

class AccountRow: UIView {
    
    let accountText: UILabel = {
        let text = UILabel()
        let underlineAttriString = NSAttributedString(string: "카카오뱅크 303-22-201058 이정환", attributes: [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue])
        text.translatesAutoresizingMaskIntoConstraints = false
        text.font = UIFont.preferredFont(for: .callout, weight: .bold)
        text.textColor = UIColor(named: Constants.FruitfruitColors.orange1)
        text.attributedText = underlineAttriString
        text.widthAnchor.constraint(equalToConstant: 247).isActive = true
        return text
    }()
    
    let accountImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: Constants.FruitfruitImages.Others.account)
        image.widthAnchor.constraint(equalToConstant: 18).isActive = true
        return image
    }()
    
    let accountRow: UIStackView = {
        let row = UIStackView()
        row.translatesAutoresizingMaskIntoConstraints = false
        row.axis = .horizontal
        return row
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        self.isUserInteractionEnabled = true
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapAccountRow))
//        self.addGestureRecognizer(tapGesture)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        accountRow.widthAnchor.constraint(equalToConstant: 270).isActive = true
        [accountText, accountImage].map {
            accountRow.addArrangedSubview($0)
        }
        
        self.addSubview(accountRow)
    }
    
//    @objc func tapAccountRow() {
//        print("tapAccountRow tapped")
//    }
}
