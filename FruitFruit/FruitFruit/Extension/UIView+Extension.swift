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
        graident.startPoint = CGPoint(x: 0.5, y: 0.75)
        graident.endPoint = CGPoint(x: 0.5, y: 0.25)
        return graident
    }
    
    
    // How to use
    // 1. let gradient = button.applyButtonGraident(colors: [yourColor])
    // 2. button.layer.insertSublayer(graident, at: 0)
    // 버튼 레이어의 가장 상단부에 위치 백그라운드 컬러를 그레디언트로 주기    
    func applyBackgroundGradient() {
        let backgroundLabel = FruitBackground(frame: CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height - 547))
        backgroundLabel.tag = 1
        backgroundLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(backgroundLabel)
        backgroundLabel.widthAnchor.constraint(equalToConstant: self.bounds.width).isActive = true
        backgroundLabel.heightAnchor.constraint(equalToConstant: self.bounds.height - 547).isActive = true
        backgroundLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        backgroundLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 547).isActive = true
    }
    // How to use
    // 1. viewDidLoaded() -> self(VC).view(current view) extension func applyBackgroundGradient()
    // 2. 해당 뷰의 서브 뷰에 그레디언트 레이어가 입혀진 UILabel를 추가하기
    func applyBackgroundBlurring() {
        let backgroundLabel = FruitBackground(frame: CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height - 547))
        backgroundLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(backgroundLabel)
        backgroundLabel.widthAnchor.constraint(equalToConstant: bounds.width).isActive = true
        backgroundLabel.heightAnchor.constraint(equalToConstant: self.bounds.height - 547).isActive = true
        backgroundLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        backgroundLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: -347).isActive = true
    }
    //TODO: width, height -> 사이즈 감지 체크 + 블러링 이펙트 주기
}
