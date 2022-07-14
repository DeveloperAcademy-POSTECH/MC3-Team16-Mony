//
//  UIView+Extension.swift
//  FruitFruit
//
//  Created by Junyeong Park on 2022/07/15.
//

import UIKit

extension UIView {
    
    func applyButtonGradient(colors: [UIColor]) -> CAGradientLayer {
        return self.applyButtonGradient(colors: colors, locations: nil)
    }
    
    func applyButtonGradient(colors: [UIColor], locations: [NSNumber]?) -> CAGradientLayer {
        let graident: CAGradientLayer = CAGradientLayer()
        graident.frame = self.bounds
        graident.colors = colors.map {$0.cgColor}
        graident.locations = locations
        graident.cornerRadius = 16
        return graident
    }
}
