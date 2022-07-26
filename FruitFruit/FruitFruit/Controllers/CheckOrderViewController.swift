//
//  CheckOrderViewController.swift
//  FruitFruit
//
//  Created by 김유나 on 2022/07/15.
//

import UIKit

class CheckOrderViewController: UIViewController {
    
    //TODO: 데이터 바인딩
    var saleInfo = FruitSaleInfo(shopName: "효곡청과", fruitName: "여름오렌지", price: 800, fruitOrigin: "캘리포니아", saleDate: Date(), place: "포스텍 C5", time: 13)
    var orderInfo = FruitOrder(name: "여름오렌지", dueDate: Date(), amount: 3, price: 800, status: "Checking", user: FruitUser(name: "김유나", nickname: "진저"), place: "포스텍 C5", time: 13)
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var secondaryTitleLabel: UILabel!
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var orderButton: UIButton!
    
    @IBAction func onOrderButtonClicked(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "OrderResult", bundle: nil)
        let homeVC = storyboard.instantiateViewController(withIdentifier: "OrderResultViewController") as! OrderResultViewController
        let initVC = self.navigationController
        initVC?.pushViewController(homeVC, animated: true)
        initVC?.isNavigationBarHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundView.applyBackgroundGradient()
        setCheckOrderViewUI()
        navigationBar.shadowImage = UIImage()
    }
    
}

extension CheckOrderViewController {
    
    private func setCheckOrderViewUI() {
        setTitleLabelUI(from: setTitleText(), colorText: setTitleFruit(), color: UIColor(named: Constants.FruitfruitColors.orange1)!)
        setSecondaryLabelUI()
        setCheckOrderButtonUI()
    }
    
    private func setTitleLabelUI(from text: String, colorText: String, color: UIColor) {
        let nsString = text.getColoredText(colorText, color)
        titleLabel.text = ""
        titleLabel.attributedText = nsString
        titleLabel.font = UIFont.preferredFont(for: .title1, weight: .bold)
    }
    
    private func setTitleText() -> String {
        return setTitleFruit() + " " + setTitleAmount() + "개\n" + setTitleCost() + "원\n주문하시겠어요?"
    }
    
    private func setTitleFruit() -> String {
        let fruit = saleInfo.fruitName
        return fruit
    }
    
    private func setTitleAmount() -> String {
        let amount = orderInfo.amount
        return String(amount)
    }
    
    private func setTitleCost() -> String {
        let cost = orderInfo.totalPrice
        let share: String
        let remainder: String
        let result: String
        
        if cost >= 1000 {
            share = String(cost / 1000)
            remainder = String(cost % 1000)
            result = share + "," + remainder
        } else {
            result = String(cost)
        }
        
        return result
    }
    
    private func setSecondaryLabelUI() {
        secondaryTitleLabel.text = setSecondaryText()
        secondaryTitleLabel.font = UIFont.preferredFont(for: .subheadline, weight: .bold)
        secondaryTitleLabel.textColor = UIColor(named: Constants.FruitfruitColors.gray1)
    }
    
    private func setSecondaryText() -> String {
        return "주문 완료 후 입금이 확인되면\n내일 " + setSecondaryTextTime() + setSecondaryTextPlace() + " 앞에 배달됩니다"
    }
    
    private func setSecondaryTextTime() -> String {
        var hour = orderInfo.time
        if hour > 12 {
            hour = hour - 12
            return "오후 " + String(hour) + "시 "
        } else {
            return "오전 " + String(hour) + "시 "
        }
    }
    
    private func setSecondaryTextPlace() -> String {
        let place = orderInfo.place
        return place
    }
    
    private func setCheckOrderButtonUI() {
        orderButton.setTitle("주문하기", for: .normal)
        DispatchQueue.main.async {
            self.orderButton.titleLabel?.font = UIFont.preferredFont(for: .headline, weight: .bold)
        }
        let gradient = orderButton.applyButtonGradient(colors: Constants.FruitfruitColors.buttonGradient)
        orderButton.layer.insertSublayer(gradient, at: 0)
        orderButton.layer.cornerRadius = 16
        orderButton.layer.borderWidth = 1
        orderButton.layer.borderColor = UIColor(named: Constants.FruitfruitColors.button1)?.cgColor
    }
    
}
