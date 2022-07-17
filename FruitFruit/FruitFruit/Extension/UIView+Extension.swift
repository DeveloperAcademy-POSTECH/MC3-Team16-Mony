//
//  UIView+Extension.swift
//  FruitFruit
//
//  Created by Junyeong Park on 2022/07/15.
//

import UIKit

extension UIView {
    
    func applyButtonGradient(colors: [UIColor]) -> CAGradientLayer {
        return self.applyButtonGradient(colors: colors, locations: [0, 1])
    }
    
    func applyButtonGradient(colors: [UIColor], locations: [NSNumber]?) -> CAGradientLayer {
        let graident: CAGradientLayer = CAGradientLayer()
        graident.frame = self.bounds
        graident.colors = colors.map {$0.cgColor}
        graident.locations = locations
        graident.cornerRadius = 16
        graident.startPoint = CGPoint(x: 0.25, y: 0.5)
        graident.endPoint = CGPoint(x: 0.75, y: 0.5)
        return graident
    }
    // How to use
    // 1. let gradient = button.applyButtonGraident(colors: [yourColor])
    // 2. button.layer.insertSublayer(graident, at: 0)
    // 버튼 레이어의 가장 상단부에 위치 백그라운드 컬러를 그레디언트로 주기
}
