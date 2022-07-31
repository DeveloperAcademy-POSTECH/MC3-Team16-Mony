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
        } else if self.contains("바나나") {
            return FruitType.Banana
        } else if self.contains("포도") {
            return FruitType.Grape
        } else if self.contains("사과") {
            return FruitType.Apple
        } else if self.contains("파인애플") {
            return FruitType.Pineapple
        } else if self.contains("자두") {
            return FruitType.Plum
        } else {
            return FruitType.Orange
        }
    }
    
    var isLastConsonantLetter: Bool {
        guard let text = self.last else { return false }
        guard let firstChar = text.unicodeScalars.first?.value, 0xAC00...0xD7A3 ~= firstChar else { return false }
        
        let value = (firstChar - 0xAC00) % 28
        
        guard value > 0 else { return false }
        
        return true
        // true -> 종성 있음
        // false -> 종성 없음
    }
}
