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
        nsString.setColorForText(textToFind: self, withColor: UIColor(named: Constants.FruitfruitColors.black1) ?? UIColor.black)
        nsString.setColorForText(textToFind: text, withColor: color)
        return nsString
    }
    
    var getFruitType: FruitType {
        if self.contains("오렌지") {
            return FruitType.Orange
        } else if self.contains("복숭아") {
            return FruitType.Peach
        } else if self.contains("수박") {
            return FruitType.Watermelon
        } else {
            return FruitType.Orange
        }
    }
}
