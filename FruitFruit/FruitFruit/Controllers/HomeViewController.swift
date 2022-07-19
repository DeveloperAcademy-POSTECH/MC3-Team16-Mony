//
//  HomeViewController.swift
//  FruitFruit
//
//  Created by Junyeong Park on 2022/07/15.
//

import UIKit
import FirebaseFirestore

class HomeViewController: UIViewController {
    // MARK: - PROPERTIES
    var fruitOrders = [FruitOrder]()
    var fruitSaleInfos = [FruitSaleInfo]()
    let db = Firestore.firestore()
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
        label.text = "참여가능한 과일모임"
        label.textColor = UIColor(named: Constants.FruitfruitColors.black)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    @IBOutlet weak var homeTitleLabel: UILabel!

    
    // MARK: - LIFECYCLES

    override func viewDidLoad() {
        super.viewDidLoad()
        view.applyBackgroundGradient()
        fetchData()
        initHomeViewUI()
        setHomeViewUI()
    }
    //TODO: delegate 선언 -> 주문 상태 유무에 따른 위치 조정
    
    // MARK: - FUNCTIONS
    
    private func fetchData() {
        //TODO: Firebase data -> fetch
        fetchOrders()
        fetchInfos()
    }
    
    private func fetchOrders() {
        fruitOrders.append(FruitOrder(name: "오렌지", dueDate: Date(), amount: 2, price: 300, status: "Checked", user: FruitUser(name: "박준영", nickname: "노아"), place: "C5", time: 13))
        db.collection(Constants.FStore.Orders.collectionName).document()
    }
    
    private func fetchInfos() {
        fruitSaleInfos.append(FruitSaleInfo(shopName: "효곡청과", fruitName: "오렌지", price: 300, fruitOrigin: "캘리포니아", saleDate: Date(), place: "C5", time: 13))
    }
    // viewDidLoad 등 현재 사용자 주문 정보 / 가용 과일 정보 fetch
    
    private func initHomeViewUI() {
        homeTitleLabel.font = UIFont.preferredFont(for: .title1, weight: .bold)
        setFruitStatusLabel()
        initFruitOrderLabel()
        initFruitCellButton()
    }
    
    private func setHomeViewUI() {
        if let fruitOrder = fruitOrders.first {
            let fruitStatus = fruitOrder.statusEnum
            setHomeTitleText(from: fruitStatus.homeTitleText(fruit: fruitOrder.name, time: fruitOrder.time, place: fruitOrder.place))
            fruitStatusLabel.isHidden = false
            setFruitStatusLabelText(from: fruitStatus.statusLabel)
            setFruitStatusLabelImage(from: fruitStatus.statusImageName(fruit: fruitOrder.name))
            setFruitOrderLayout(false)
        } else {
            fruitStatusLabel.isHidden = true
            setHomeTitleText(from: FruitStatus.Canceled.homeTitleText(fruit: "", time: 0, place: ""))
            setFruitOrderLayout(true)
        }
        
        //TODO: 서버 -> 주문 정보 배열값 업데이트 -> 값 변경 감지
    }
    
    func setHomeTitleText(from text: NSMutableAttributedString) {
        homeTitleLabel.text = ""
        homeTitleLabel.attributedText = text
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
    
    func setFruitStatusLabelImage(from text: String) {
        fruitStatusLabel.setLabelImage(from: text)
    }
    //TODO: 데이터 모델 -> 한 번에 사용 + 디폴트 값 설정하기
    
    @objc func tapStatusLabel() {
        print("FruitStatuLabel tapped")
        //TODO: 주문 상태 확인 뷰로 네비게이션 이동하기
        //TODO: 라벨 클릭 시 일반 버튼처럼 번쩍거리는 클릭 이벤트 효과 주기
    }
    
    private func initFruitOrderLabel() {
        fruitOrderLabel.font = UIFont.preferredFont(for: .headline, weight: .bold)
        view.addSubview(fruitOrderLabel)
        fruitOrderLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24).isActive = true
    }
    
    private func initFruitCellButton() {
        view.addSubview(fruitCellButton)
        fruitCellButton.widthAnchor.constraint(equalToConstant: view.bounds.width - 48).isActive = true
        fruitCellButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24).isActive = true
        fruitCellButton.heightAnchor.constraint(equalToConstant: 154).isActive = true
        fruitCellButton.isUserInteractionEnabled = true
        fruitCellButton.addTarget(self, action: #selector(tapCellButton), for: .touchUpInside)
    }
    // 버튼 테스트 용. -> UITableView의 셀로 활용하기

    @objc func tapCellButton() {
        print("TAP CELL BUTTON")
        //TODO: 주문 뷰로 네비게이션 이동하기
        //TODO: 라벨 클릭 시 일반 버튼처럼 번쩍거리는 클릭 이벤트 효과 주기
    }
    
    private func setFruitOrderLayout(_ isTop: Bool) {
        let nextLabel: CGFloat = isTop ? 277 : 327
        let curLabel: CGFloat = isTop ? 327 : 277
        
        fruitOrderLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: curLabel).isActive = false
        fruitOrderLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: nextLabel).isActive = true
        
        let nextButton: CGFloat = isTop ? 309 : 359
        let curButton: CGFloat = isTop ? 359 : 309
        
        fruitCellButton.topAnchor.constraint(equalTo: view.topAnchor, constant: curButton).isActive = false
        fruitCellButton.topAnchor.constraint(equalTo: view.topAnchor, constant: nextButton).isActive = true
    }
}


