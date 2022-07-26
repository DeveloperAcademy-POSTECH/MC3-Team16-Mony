//
//  OrderViewController.swift
//  FruitFruit
//
//  Created by 유재훈 on 2022/07/19.
//

import UIKit

class OrderViewController: UIViewController {
    @IBOutlet var checkOrderButton: UIButton!
    @IBOutlet var TimeView: UIView!
    @IBOutlet var LocationView: UIView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCheckOrderButtonUI()
        TimeView.backgroundColor = .white
        TimeView.layer.shadowOpacity = 1
        TimeView.layer.shadowColor = UIColor(red: 0.917, green: 0.813, blue: 0.737, alpha: 0.3).cgColor
        TimeView.layer.shadowOffset = CGSize(width: 0, height: 0)
        TimeView.layer.shadowRadius = 20
        TimeView.layer.masksToBounds = false
        
        view.addSubview(TimeView)
        
        self.view = view
        view.applyBackgroundGradient()
        
    
        
    }
    
    @IBAction func chekOrderbuttonOntap(_ sender: UIButton) {
        print("onCheckOrderButtonClicked")
    }
    //checkOrderButton.titleLabel.text = "2400원 3개 구매"

    private func setCheckOrderButtonUI() {
        let gradient = checkOrderButton.applyButtonGradient(colors: Constants.FruitfruitColors.buttonGradient)
        checkOrderButton.layer.insertSublayer(gradient, at: 0)
        checkOrderButton.setTitle("주문하기", for: .normal)
        checkOrderButton.titleLabel?.font = UIFont.preferredFont(for: .headline, weight: .semibold)
        checkOrderButton.layer.cornerRadius = 16
        checkOrderButton.layer.borderWidth = 1
        checkOrderButton.layer.borderColor = UIColor(named: Constants.FruitfruitColors.button1)?.cgColor
    }
    
}
