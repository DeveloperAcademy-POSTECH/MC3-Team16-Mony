//
//  AccountRow.swift
//  FruitFruit
//
//  Created by 김유나 on 2022/07/20.
//

import UIKit

class AccountRow: UIView {
    
    let accountText: UILabel = {
        let accountText = UILabel()
        accountText.text = "카카오뱅크 303-22-201058 이정환"
        accountText.font = UIFont.preferredFont(for: .callout, weight: .semibold)
        accountText.textColor = UIColor(named: Constants.FruitfruitColors.orange1)
    }()
    
//    let accountImage: UIImage = {
//        
//    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        
    }
}
