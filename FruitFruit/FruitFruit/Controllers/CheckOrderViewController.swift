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
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.navigationController?.navigationBar.shadowImage = nil
        setCheckOrderViewUI()
    }
    
    func setCheckOrderViewUI() {
        setTitleLabelUI("여름오렌지", UIColor(named: Constants.FruitfruitColors.orange1)!)
        setSecondaryLabelUI()
        setCheckOrderButtonUI()
    }
    
    func setTitleLabelUI(_ tintedText: String, _ tintColor: UIColor) {
        checkOrderTitleLabel.text = "여름오렌지 3개\n2,400원\n주문하시겠어요?"
        checkOrderTitleLabel.font = UIFont.preferredFont(for: .title1, weight: .bold)
    }
    
    func setSecondaryLabelUI() {
        checkOrderSecondaryLabel.text = setSecondaryText()
        checkOrderSecondaryLabel.font = UIFont.preferredFont(for: .subheadline, weight: .bold)
        checkOrderSecondaryLabel.textColor = UIColor(named: Constants.FruitfruitColors.gray1)
        //TODO: func setCheckOrderTitleText(from text: String, colorText: String, color: UIColor) 추가 - 노아 merge 후
    }
    
    func setSecondaryText() -> String {
        let secondaryText = "주문 완료 후 입금이 확인되면\n내일 " + setSecondaryTextTime(13) + setSecondaryTextPlace("C5") + " 앞에 배달됩니다"
        return secondaryText
    }
    
    func setSecondaryTextTime(_ timeInTwentyFourHour: Int) -> String {
        var timeInTwelveHour = timeInTwentyFourHour
        if timeInTwelveHour > 12 {
            timeInTwelveHour = timeInTwelveHour - 12
            return "오후 " + String(timeInTwelveHour) + "시 "
        } else {
            return "오전 " + String(timeInTwelveHour) + "시 "
        }
    }
    
    func setSecondaryTextPlace(_ place: String) -> String {
        return place
    }
    
    @IBAction func onCheckOrderButtonClicked(_ sender: UIButton) {
        print("onCheckOrderButtonClicked")
    }
    
    func setCheckOrderButtonUI() {
        let gradient = checkOrderButton.applyButtonGradient(colors: Constants.FruitfruitColors.buttonGradient)
        checkOrderButton.layer.insertSublayer(gradient, at: 0)
        checkOrderButton.setTitle("주문하기", for: .normal)
        checkOrderButton.titleLabel?.font = UIFont.preferredFont(for: .headline, weight: .semibold)
        checkOrderButton.layer.cornerRadius = 16
        checkOrderButton.layer.borderWidth = 1
        checkOrderButton.layer.borderColor = UIColor(named: Constants.FruitfruitColors.button1)?.cgColor
    }
    
    //TODO: Button 터치시 navigation
    
}
