//
//  CheckOrderViewController.swift
//  FruitFruit
//
//  Created by 김유나 on 2022/07/15.
//

import UIKit

class CheckOrderViewController: UIViewController {
    
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
        //TODO: 과일 종류 받아오는 코드 추가
        let fruit = "여름오렌지"
        return fruit
    }
    
    private func setTitleAmount() -> String {
        //TODO: 과일 개수 받아오는 코드 추가
        let amount = 3
        return String(amount)
    }
    
    private func setTitleCost() -> String {
        //TODO: 과일 가격 받아오는 or 계산하는 코드 추가 (일단은 받아오는 코드)
        let cost = 2400
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
        //TODO: 과일 배부 시간 받아오는 코드 추가
        var hour = 13
        if hour > 12 {
            hour = hour - 12
            return "오후 " + String(hour) + "시 "
        } else {
            return "오전 " + String(hour) + "시 "
        }
    }
    
    private func setSecondaryTextPlace() -> String {
        //TODO: 과일 배부 장소 받아오는 코드 추가
        let place = "C5"
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
