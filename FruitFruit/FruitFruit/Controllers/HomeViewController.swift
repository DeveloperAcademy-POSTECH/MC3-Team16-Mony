//
//  HomeViewController.swift
//  FruitFruit
//
//  Created by Junyeong Park on 2022/07/15.
//

import UIKit

class HomeViewController: UIViewController {
    // MARK: - PROPERTIES
    let fruitStatusLabel: FruitStatusLabel = {
        let statusLabel = FruitStatusLabel(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 48, height: 68))
        // TODO: UIScreen을 사용하지 않고 LifeCycle에서 view.bounds를 사용해서 Init하기
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        return statusLabel
    }()
    
    let fruitCellButton: FruitCellButton = {
        let cellButton = FruitCellButton(frame: CGRect(x:0, y:0, width: UIScreen.main.bounds.width - 48, height: 154))
        cellButton.translatesAutoresizingMaskIntoConstraints = false
        return cellButton
    }()
    
    @IBOutlet weak var homeTitleLabel: UILabel!

    
    // MARK: - LIFECYCLES

    override func viewDidLoad() {
        super.viewDidLoad()
        view.applyBackgroundGradient()
        setHomeViewUI()
        setHomeTitleText(from: "푸릇푸릇!\n상큼한 수요일 되세요", colorText: "푸릇푸릇!", color: UIColor(named: Constants.FruitfruitColors.orange1)!)
        setFruitStatusLabelText(from: "주문이 취소되었어요")
        setFruitCellButton()
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
        view.addSubview(fruitStatusLabel)
        fruitStatusLabel.widthAnchor.constraint(equalToConstant: view.bounds.width - 48).isActive = true
        fruitStatusLabel.heightAnchor.constraint(equalToConstant: 68).isActive = true
        fruitStatusLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24).isActive = true
        fruitStatusLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 217).isActive = true
        fruitStatusLabel.isUserInteractionEnabled = true
        let labelTapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapStatusLabel))
        fruitStatusLabel.addGestureRecognizer(labelTapGesture)
    }
    
    func setFruitStatusLabelText(from text: String) {
        fruitStatusLabel.setLabelText(from: text)
    }
    
    @objc func tapStatusLabel() {
        print("FruitStatuLabel tapped")
        //TODO: 주문 상태 확인 뷰로 네비게이션 이동하기
        //TODO: 라벨 클릭 시 일반 버튼처럼 번쩍거리는 클릭 이벤트 효과 주기
    }
    
    private func setFruitCellButton() {
        view.addSubview(fruitCellButton)
        fruitCellButton.widthAnchor.constraint(equalToConstant: view.bounds.width - 48).isActive = true
        fruitCellButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24).isActive = true
        fruitCellButton.heightAnchor.constraint(equalToConstant: 154).isActive = true
        fruitCellButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 359).isActive = true
//        fruitCellButton.isUserInteractionEnabled = true
        let cellButtonGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapCellButton))
        fruitCellButton.addGestureRecognizer(cellButtonGesture)
    }
    // 버튼 테스트 용. -> UITableView의 셀로 활용하기
    
    @objc func tapCellButton() {
        print("TAP CELL BUTTON")
        //TODO: 주문 뷰로 네비게이션 이동하기
        //TODO: 라벨 클릭 시 일반 버튼처럼 번쩍거리는 클릭 이벤트 효과 주기
    }
}


