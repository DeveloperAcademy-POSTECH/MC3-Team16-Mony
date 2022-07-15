//
//  HomeViewController.swift
//  FruitFruit
//
//  Created by Junyeong Park on 2022/07/15.
//

import UIKit

class HomeViewController: UIViewController {
    // MARK: - PROPERTIES
    let fruitStautsLabel: FruitStatusLabel = {
        let statusLabel = FruitStatusLabel(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 48, height: 68))
        // TODO: UIScreen을 사용하지 않고 LifeCycle에서 view.bounds를 사용해서 Init하기
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        return statusLabel
    }()
    
    @IBOutlet weak var homeTitleLabel: UILabel!

    
    // MARK: - LIFECYCLES

    override func viewDidLoad() {
        super.viewDidLoad()
        view.applyBackgroundGradient()
        setHomeViewUI()
        setHomeTitleText(from: "푸릇푸릇!\n상큼한 수요일 되세요", colorText: "푸릇푸릇!", color: UIColor(named: Constants.FruitfruitColors.orange1)!)
        setFruitStatusLabelText(from: "주문이 취소되었어요")
    }
    
    // MARK: - FUNCTIONS
    
    private func setHomeViewUI() {
        homeTitleLabel.font = UIFont.preferredFont(for: .title1, weight: .bold)
        setFruitStatusLabel()
    }
    
    func setHomeTitleText(from text: String) {
        homeTitleLabel.text = text
    }
    
    func setHomeTitleText(from text: String, colorText: String, color: UIColor) {
        let nsString = text.getColoredText(colorText, color)
        homeTitleLabel.text = ""
        homeTitleLabel.attributedText = nsString
    }
    
    private func setFruitStatusLabel() {
        fruitStautsLabel.frame = CGRect(x: 0, y: 0, width: view.bounds.width - 48, height: 68)
        view.addSubview(fruitStautsLabel)
        fruitStautsLabel.widthAnchor.constraint(equalToConstant: view.bounds.width - 48).isActive = true
        fruitStautsLabel.heightAnchor.constraint(equalToConstant: 68).isActive = true
        fruitStautsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24).isActive = true
        fruitStautsLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 217).isActive = true
        fruitStautsLabel.isUserInteractionEnabled = true
        let labelTapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapStatusLabel))
        fruitStautsLabel.addGestureRecognizer(labelTapGesture)
    }
    
    func setFruitStatusLabelText(from text: String) {
        fruitStautsLabel.setLabelText(from: text)
    }
    
    @objc func tapStatusLabel() {
        print("FruitStatuLabel tapped")
        //TODO: 주문 상태 확인 뷰로 네비게이션 이동하기
    }
}


