//
//  NSMutableAttributedString_Extension.swift
//  FruitFruit
//
//  Created by Junyeong Park on 2022/07/15.
//

import UIKit

extension NSMutableAttributedString {
        func setColorForText(textToFind: String, withColor color: UIColor) {
         let range: NSRange = self.mutableString.range(of: textToFind, options: .caseInsensitive)
          if range != nil {
              self.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
          }
        }
}
