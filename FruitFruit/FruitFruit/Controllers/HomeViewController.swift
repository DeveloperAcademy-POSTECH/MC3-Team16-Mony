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
    let database = Firestore.firestore()
    let fruitStatusLabel: FruitStatusLabel = {
        let statusLabel = FruitStatusLabel(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 48, height: 68))
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        return statusLabel
    }()
    
    let fruitTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
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
        fruitTableView.delegate = self
        fruitTableView.dataSource = self
        addMockOrder(fruitOrder: FruitOrder(name: "오렌지", dueDate: Date(), amount: 4, price: 500, status: "Checking", user: FruitUser(name: "박준영", nickname: "노아"), place: "C5", time: 13))
//        addMockSaleInfo(fruitInfo: FruitSaleInfo(shopName: "효곡청과", fruitName: "오렌지", price: 500, fruitOrigin: "영천", saleDate: Date(), place: "C5", time: 13))
//        addMockSaleInfo(fruitInfo: FruitSaleInfo(shopName: "효곡청과", fruitName: "복숭아", price: 600, fruitOrigin: "영천", saleDate: Date(), place: "C5", time: 14))
        fetchData()
    }
    
    // MARK: - FUNCTIONS
    
    private func fetchData() {
        fetchOrders()
        fetchInfos()
    }
    
    private func fetchOrders() {
        if let user = Storage().fruitUser {
            let detailCollectionName = "\(user.name) \(user.nickname)"
//            db.collection(Constants.FStore.Orders.collectionName).document(user.id).collection(detailCollectionName).order(by: Constants.FStore.Orders.orderField).addSnapshotListener { querySnapShot, error in
            database.collection(Constants.FStore.Orders.collectionName).document(detailCollectionName).collection(detailCollectionName).order(by: Constants.FStore.Orders.orderField).addSnapshotListener { querySnapShot, error in
                self.fruitOrders = []
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    if let documents = querySnapShot?.documents {
                        for document in documents {
                            let data = document.data()
                            do {
                                let fruitOrder: FruitOrder = try FruitOrder.decode(dictionary: data)
                                self.fruitOrders.append(fruitOrder)
                            } catch {
                                print(error)
                            }
                        }
                        DispatchQueue.main.async {
                            self.initHomeViewUI()
                            self.setHomeViewUI()
                        }
                    }
                }
            }
        }
    }
    
    private func fetchInfos() {
        if let user = Storage().fruitUser {
            database.collection(Constants.FStore.SaleInfos.collectionName).order(by: Constants.FStore.SaleInfos.orderField).addSnapshotListener { querySnapShot, error in
                self.fruitSaleInfos.removeAll()
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    if let documents = querySnapShot?.documents {
                        for document in documents {
                            let data = document.data()
                            do {
                                let fruitSaleInfo: FruitSaleInfo = try FruitSaleInfo.decode(dictionary: data)
                                self.fruitSaleInfos.append(fruitSaleInfo)
                            } catch {
                                print(error)
                            }
                        }
                        DispatchQueue.main.async {
                            self.initHomeViewUI()
                            self.setHomeViewUI()
                            self.fruitTableView.reloadData()
                        }
                    }
                }
            }
        }
    }
    
    private func initHomeViewUI() {
        homeTitleLabel.font = UIFont.preferredFont(for: .title1, weight: .bold)
        setFruitStatusLabel()
        initFruitOrderLabel()
        initFruitTableView()
    }
    
    private func initFruitTableView() {
        fruitTableView.register(FruitCell.self, forCellReuseIdentifier: FruitCell.identifier)
        view.addSubview(fruitTableView)
        fruitTableView.backgroundColor = .clear
//        fruitTableView.separatorStyle = .none
        fruitTableView.widthAnchor.constraint(equalToConstant: view.bounds.width - 48).isActive = true
        fruitTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24).isActive = true
    }
    
    private func setHomeViewUI() {
        //TODO: 주문 상태 활성화되어 있는지 체크
        if let fruitOrder = fruitOrders.first {
            let fruitStatus = fruitOrder.statusEnum
            setHomeTitleText(from: fruitStatus.makeHomeTitleText(fruit: fruitOrder.name, time: fruitOrder.time, place: fruitOrder.place))
            fruitStatusLabel.isHidden = false
            setFruitStatusLabelText(from: fruitStatus.statusLabel)
            setFruitStatusLabelImage(from: fruitStatus.getStatusImageName(fruit: fruitOrder.name))
            setFruitOrderLayout(false)
        } else {
            fruitStatusLabel.isHidden = true
            setHomeTitleText(from: Date().dayComment)
            setFruitOrderLayout(true)
        }
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
    
    @objc func tapStatusLabel() {
        print("FruitStatuLabel tapped")
//        addMockSaleInfo(fruitInfo: FruitSaleInfo(shopName: "효곡청과", fruitName: "오렌지", price: 500, fruitOrigin: "영천", saleDate: Date(), place: "C5", time: 13))
        fruitTableView.reloadData()

        //TODO: 주문 상태 확인 뷰로 네비게이션 이동하기
        //TODO: 라벨 클릭 시 일반 버튼처럼 번쩍거리는 클릭 이벤트 효과 주기
    }
    
    private func initFruitOrderLabel() {
        fruitOrderLabel.font = UIFont.preferredFont(for: .headline, weight: .bold)
        view.addSubview(fruitOrderLabel)
        fruitOrderLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24).isActive = true
    }
    
    private func setFruitOrderLayout(_ isTop: Bool) {
        let nextLabel: CGFloat = isTop ? 277 : 327
        let curLabel: CGFloat = isTop ? 327 : 277
        
        fruitOrderLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: curLabel).isActive = false
        fruitOrderLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: nextLabel).isActive = true
        
        let nextTable: CGFloat = isTop ? 309 : 359
        let curTable: CGFloat = isTop ? 359 : 309
        
        fruitTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: curTable).isActive = false
        fruitTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: nextTable).isActive = true
        
        let nextTableHeight: CGFloat = view.bounds.height - nextTable
        let curTableHeight: CGFloat = view.bounds.height - curTable
        
        fruitTableView.heightAnchor.constraint(equalToConstant: curTableHeight).isActive = false
        fruitTableView.heightAnchor.constraint(equalToConstant: nextTableHeight).isActive = true
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return fruitSaleInfos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FruitCell.identifier, for: indexPath) as! FruitCell
        let frame = CGRect(x:0, y:0, width: view.bounds.width - 48, height: 154)
        cell.setUI(frame: frame, model: fruitSaleInfos[indexPath.section])
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 154
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        40
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        footerView.backgroundColor = .clear
        return footerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(fruitSaleInfos[indexPath.section])
    }
}


