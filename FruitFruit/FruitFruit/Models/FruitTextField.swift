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
    
    override func awakeFromNib() {
        super.awakeFromNib()

        self.translatesAutoresizingMaskIntoConstraints = false
        
        bottomBorder = UIView.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        bottomBorder.translatesAutoresizingMaskIntoConstraints = false
        bottomBorder.backgroundColor = UIColor.gray
        
        addSubview(bottomBorder)
        
        bottomBorder.topAnchor.constraint(equalTo: bottomAnchor, constant: 8).isActive = true
        bottomBorder.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        bottomBorder.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        bottomBorder.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
}
