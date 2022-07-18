//
//  String+Extension.swift
//  FruitFruit
//
//  Created by Junyeong Park on 2022/07/15.
//

import UIKit

extension String {
    func getColoredText(_ text: String, _ color: UIColor) -> NSMutableAttributedString {
        let nsString = NSMutableAttributedString(string: self)
        nsString.setColorForText(textToFind: self, withColor: UIColor(named: Constants.FruitfruitColors.black) ?? UIColor.black)
        nsString.setColorForText(textToFind: text, withColor: color)
        return nsString
    }
}
