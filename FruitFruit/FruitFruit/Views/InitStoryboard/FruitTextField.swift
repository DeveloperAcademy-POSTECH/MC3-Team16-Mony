//
//  FruitTextField.swift
//  FruitFruit
//
//  Created by Junyeong Park on 2022/07/13.
//

import Foundation
import UIKit

class FruitTextField: UITextField {
    var bottomBorder = UIView()    
    
    lazy var heightAnchorClicked = bottomBorder.heightAnchor.constraint(equalToConstant: 2)
    lazy var heightAnchorUnclicked = bottomBorder.heightAnchor.constraint(equalToConstant: 1)
    override func awakeFromNib() {
        super.awakeFromNib()

        self.translatesAutoresizingMaskIntoConstraints = false
        
        bottomBorder = UIView.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        bottomBorder.translatesAutoresizingMaskIntoConstraints = false
        bottomBorder.backgroundColor = UIColor(named: Constants.FruitfruitColors.gray2)

        addSubview(bottomBorder)
        
        bottomBorder.topAnchor.constraint(equalTo: bottomAnchor, constant: 8).isActive = true
        bottomBorder.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        bottomBorder.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        heightAnchorUnclicked.isActive = true
    }
    
    func backgroundSet(_ isEditing: Bool) {
        if isEditing {
            bottomBorder.backgroundColor = UIColor(named: Constants.FruitfruitColors.orange1)
        } else {
            bottomBorder.backgroundColor = UIColor(named: Constants.FruitfruitColors.gray2)
        }
    }
    
    func heightSet(_ isHeightSet: Bool) {
        if isHeightSet {
            heightAnchorUnclicked.isActive = false
            heightAnchorClicked.isActive = true
        } else {
            heightAnchorClicked.isActive = false
            heightAnchorUnclicked.isActive = true
        }
    }
}
