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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.applyBackgroundGradient()
        lblNumber.text = String(Number) + "개"

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

}
