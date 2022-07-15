//
//  FruitBackground.swift
//  FruitFruit
//
//  Created by Junyeong Park on 2022/07/15.
//

import UIKit

class FruitBackground: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setBackground()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        setBackground()
    }
    
    private func setBackground() {
        self.backgroundColor = .clear
        let gradient = fetchGradient(colors: Constants.FruitfruitColors.backgroundGradient)
        self.layer.insertSublayer(gradient, at: 0)
    }
    
    private func fetchGradient(colors: [UIColor]) -> CAGradientLayer {
        let gradient = CAGradientLayer()
        gradient.colors = colors.map{ $0.cgColor }
        gradient.locations = [0, 1]
        gradient.startPoint = CGPoint(x: 0.25, y: 0.5)
        gradient.endPoint = CGPoint(x: 0.75, y: 0.5)
        gradient.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 0, b: -0.67, c: 0.67, d: 0, tx: 0.24, ty: 1))
        gradient.bounds = self.bounds.insetBy(dx: -0.5 * self.bounds.size.width, dy: -0.5 * self.bounds.size.height)
        gradient.position = self.center
        return gradient
    }
}
