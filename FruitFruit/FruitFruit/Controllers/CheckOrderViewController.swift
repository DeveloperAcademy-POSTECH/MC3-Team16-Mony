//
//  CheckOrderViewController.swift
//  FruitFruit
//
//  Created by 김유나 on 2022/07/15.
//

import UIKit
import Lottie

class CheckOrderViewController: UIViewController, UIGestureRecognizerDelegate {
    
    var fruitOrder = FruitOrder(saleFruitId: "fruitUserId", name: "여름오렌지", dueDate: Date(), amount: 3, price: 800, status: "Checking", user: Storage().fruitUser!, place: "포스텍 C5", time: 13)
    
    let animationView = AnimationView()
    var isOrderCompleted: Bool = false
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var secondaryTitleLabel: UILabel!
    @IBOutlet weak var orderButton: UIButton!
    
    @IBAction func onOrderButtonClicked(_ sender: UIButton) {
        if isOrderCompleted == true {
            orderButton.isUserInteractionEnabled = false
        } else {
            isOrderCompleted = true
            playLottie()
            addOrder(fruitOrder: fruitOrder)
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
                self.navigateToOrderResultView()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundView.applyBackgroundGradient()
        setCheckOrderViewUI()
    }
}

extension CheckOrderViewController {
    
    private func setCheckOrderViewUI() {
        checkOrderNavBar()
        setTitleLabelUI(from: setTitleText(), colorText: setTitleFruit(), color: UIColor(named: fruitOrder.fruitType.fruitColorName)!)
        setSecondaryLabelUI()
        setCheckOrderButtonUI()
    }
    
    private func checkOrderNavBar() {
        guard let orangeColor = UIColor(named: Constants.FruitfruitColors.orange1) else { return }
        guard let blackColor = UIColor(named: Constants.FruitfruitColors.black1) else { return }
        let backButtonImage = UIImage(systemName: "chevron.left")?.withTintColor(orangeColor, renderingMode: .alwaysOriginal)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: backButtonImage, style: .done, target: self, action: #selector(popToPrevious))
        
        navigationItem.title = "주문하기"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: blackColor, NSAttributedString.Key.font: UIFont.preferredFont(for: .headline, weight: .bold)]
        
        let exitButtonImage = UIImage(systemName: "xmark")?.withTintColor(orangeColor, renderingMode: .alwaysOriginal)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: exitButtonImage, style: .done, target: self, action: #selector(exitProcess))
    }
    
    @objc private func popToPrevious() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func exitProcess() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    private func setTitleLabelUI(from text: String, colorText: String, color: UIColor) {
        let nsString = text.getColoredText(colorText, color)
        titleLabel.text = ""
        titleLabel.attributedText = nsString
        titleLabel.font = UIFont.preferredFont(for: .title1, weight: .bold)
    }
    
    private func setTitleText() -> String {
        return setTitleFruit() + " " + setTitleAmount() + "개\n" + setTotalPriceToString(price: fruitOrder.totalPrice) + "원\n주문하시겠어요?"
    }
    
    private func setTitleFruit() -> String {
        let fruit = fruitOrder.name
        return fruit
    }
    
    private func setTitleAmount() -> String {
        let amount = fruitOrder.amount
        return String(amount)
    }
    
    private func setTotalPriceToString(price: Int) -> String {
        let result: String
        let numberFormatter = NumberFormatter()
        
        numberFormatter.numberStyle = .decimal
        result = numberFormatter.string(from: NSNumber(value: price))!
        return result
    }
    
    private func setSecondaryLabelUI() {
        guard let grayColor = UIColor(named: Constants.FruitfruitColors.gray0) else { return }
        secondaryTitleLabel.text = setSecondaryText()
        secondaryTitleLabel.font = UIFont.preferredFont(for: .subheadline, weight: .bold)
        secondaryTitleLabel.textColor = grayColor
    }
    
    private func setSecondaryText() -> String {
        return "주문 완료 후 입금이 확인되면\n내일 " + setSecondaryTextTime() + setSecondaryTextPlace() + " 앞에 배달됩니다"
    }
    
    private func setSecondaryTextTime() -> String {
        var hour = fruitOrder.time
        if hour > 12 {
            hour = hour - 12
            return "오후 " + String(hour) + "시 "
        } else {
            return "오전 " + String(hour) + "시 "
        }
    }
    
    private func setSecondaryTextPlace() -> String {
        let place = fruitOrder.place
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
    
    private func playLottie() {
        let background = UILabel()
        background.frame = CGRect(x: 0, y: 0, width: 390, height: 844)
        background.layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.96).cgColor
        view.addSubview(background)
        
        animationView.frame = CGRect(x: 93, y: 315, width: 180, height: 180)
        animationView.contentMode = .scaleAspectFill
        animationView.animation = Animation.named("FruitLottie")
        animationView.play(fromFrame: 0, toFrame: 35)
        animationView.loopMode = .repeat(2)
        view.addSubview(animationView)
    }
    
    private func navigateToOrderResultView() {
        let storyboard = UIStoryboard(name: "OrderResult", bundle: nil)
        let orderResultVC = storyboard.instantiateViewController(withIdentifier: "OrderResultViewController") as! OrderResultViewController
        let initVC = self.navigationController
        orderResultVC.fruitOrder = fruitOrder
        initVC?.pushViewController(orderResultVC, animated: true)
        initVC?.isNavigationBarHidden = true
    }
    
}
