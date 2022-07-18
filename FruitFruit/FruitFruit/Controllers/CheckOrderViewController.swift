//
//  CheckOrderViewController.swift
//  FruitFruit
//
//  Created by 김유나 on 2022/07/15.
//

import UIKit

class CheckOrderViewController: UIViewController {
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var checkOrderTitleLabel: UILabel!
    @IBOutlet weak var checkOrderSecondaryLabel: UILabel!
    @IBOutlet weak var checkOrderButton: UIButton!
    
    @IBAction func onCheckOrderButtonClicked(_ sender: UIButton) {
        //TODO: Navigation 코드 추가
        print("onCheckOrderButtonClicked")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // self.navigationController?.navigationBar.shadowImage = nil
        backgroundView.applyBackgroundGradient()
        setCheckOrderViewUI()
    }

}

extension CheckOrderViewController {
    private func setCheckOrderViewUI() {
        setTitleTextUI(from: setTitleText(), colorText: setTitleFruit(), color: UIColor(named: Constants.FruitfruitColors.orange1)!)
        setSecondaryLabelUI()
        setCheckOrderButtonUI()
    }
    
    private func setTitleTextUI(from text: String, colorText: String, color: UIColor) {
        let nsString = text.getColoredText(colorText, color)
        checkOrderTitleLabel.text = ""
        checkOrderTitleLabel.attributedText = nsString
        checkOrderTitleLabel.font = UIFont.preferredFont(for: .title1, weight: .bold)
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
        //TODO: 100원 단위로 구분하는 쉼표 추가 (2400 -> 2,400)
        let cost = 2400
        return String(cost)
    }
    
    private func setSecondaryLabelUI() {
        checkOrderSecondaryLabel.text = setSecondaryText()
        checkOrderSecondaryLabel.font = UIFont.preferredFont(for: .subheadline, weight: .bold)
        checkOrderSecondaryLabel.textColor = UIColor(named: Constants.FruitfruitColors.gray1)
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
        let gradient = checkOrderButton.applyButtonGradient(colors: Constants.FruitfruitColors.buttonGradient)
        checkOrderButton.layer.insertSublayer(gradient, at: 0)
        checkOrderButton.setTitle("주문하기", for: .normal)
        checkOrderButton.titleLabel?.font = UIFont.preferredFont(for: .headline, weight: .semibold)
        checkOrderButton.layer.cornerRadius = 16
        checkOrderButton.layer.borderWidth = 1
        checkOrderButton.layer.borderColor = UIColor(named: Constants.FruitfruitColors.button1)?.cgColor
    }
}
