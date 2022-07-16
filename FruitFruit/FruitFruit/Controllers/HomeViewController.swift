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
    
    let fruitOrderLabel: UILabel = {
        let label = UILabel()
        label.text = "참여가능한 과일팟"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    @IBOutlet weak var homeTitleLabel: UILabel!

    
    // MARK: - LIFECYCLES

    override func viewDidLoad() {
        super.viewDidLoad()
        view.applyBackgroundGradient()
        setHomeViewUI()
    }
    //TODO: delegate 선언 -> 주문 상태 유무에 따른 위치 조정
    
    // MARK: - FUNCTIONS
    
    private func setHomeViewUI() {
        homeTitleLabel.font = UIFont.preferredFont(for: .title1, weight: .bold)
        setFruitStatusLabel()
        setHomeTitleText(from: "맛있는 여름오렌지가\nC5로 오고있어요", colorText: "여름오렌지", color: UIColor(named: Constants.FruitfruitColors.orange1)!)
        setFruitStatusLabelText(from: "입금이 확인되었어요")
        setFruitStatusLabelImage(from: Constants.FruitfruitImages.Status.arrived)
        setFruitCellButton()
        setFruitOrderLabel()
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
        fruitOrderLabel.isHidden = false
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
    
    func setFruitStatusLabelImage(from text: String) {
        fruitStatusLabel.setLabelImage(from: text)
    }
    //TODO: 데이터 모델 -> 한 번에 사용 + 디폴트 값 설정하기
    
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
        fruitCellButton.isUserInteractionEnabled = true
        fruitCellButton.addTarget(self, action: #selector(tapCellButton), for: .touchUpInside)
    }
    // 버튼 테스트 용. -> UITableView의 셀로 활용하기

    @objc func tapCellButton() {
        print("TAP CELL BUTTON")
        //TODO: 주문 뷰로 네비게이션 이동하기
        //TODO: 라벨 클릭 시 일반 버튼처럼 번쩍거리는 클릭 이벤트 효과 주기
    }
    
    private func setFruitOrderLabel() {
        fruitOrderLabel.font = UIFont.preferredFont(for: .headline, weight: .bold)
        view.addSubview(fruitOrderLabel)
        fruitOrderLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24).isActive = true
        fruitOrderLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 327).isActive = true
    }
}


