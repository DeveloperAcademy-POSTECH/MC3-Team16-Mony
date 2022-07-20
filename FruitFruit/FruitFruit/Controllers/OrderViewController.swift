//
//  OrderViewController.swift
//  FruitFruit
//
//  Created by 유재훈 on 2022/07/19.
//

import UIKit

class OrderViewController: UIViewController {
    @IBOutlet var lblNumber: UILabel!
    var Number = 1
    @IBOutlet var checkOrderButton: UIButton!
    @IBAction func chekOrderbuttonOntap(_ sender: UIButton) {
        print("onCheckOrderButtonClicked")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.applyBackgroundGradient()
        lblNumber.text = String(Number) + "개"
        setCheckOrderButtonUI()


        // Do any additional setup after loading the view.
    }
    @IBAction func btnPlus(_ sender: UIButton) {
        Number += 1 
        lblNumber.text = String(Number) + "개"
    }
    @IBAction func btnMinus(_ sender: UIButton) {
        if Number - 1 <= 0 {
            return
    }
        Number -= 1
        lblNumber.text = String(Number) + "개"
    }
    //checkOrderButton.titleLabel.text = "2400원 3개 구매"

    @IBAction func gotToFruitInfoView(_ sender: UIButton) {
        
    }
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
