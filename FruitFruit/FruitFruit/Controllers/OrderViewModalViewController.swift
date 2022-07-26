//
//  OrderViewModalViewController.swift
//  FruitFruit
//
//  Created by 유재훈 on 2022/07/26.
//

import UIKit

class OrderViewModalViewController: UIViewController {
        
    @IBOutlet var lblNumber: UILabel!
    var Number = 1
    @IBOutlet var checkOrderButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       lblNumber.text = String(Number) + "개"
        setCheckOrderButtonUI()
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
    @IBAction func chekOrderbuttonOntap(_ sender: UIButton) {
        print("onCheckOrderButtonClicked")
        
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
