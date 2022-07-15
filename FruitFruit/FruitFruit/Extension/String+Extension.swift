//
//  String+Extension.swift
//  FruitFruit
//
//  Created by Junyeong Park on 2022/07/15.
//

import UIKit

extension String {
    func getColoredText(_ text: String, _ color: UIColor) -> NSMutableAttributedString {
        var nsString = NSMutableAttributedString(string: self)
        nsString.setColorForText(textToFind: text, withColor: color)
        return nsString
    }
}
