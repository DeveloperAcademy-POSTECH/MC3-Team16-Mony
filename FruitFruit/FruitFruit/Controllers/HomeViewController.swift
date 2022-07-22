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
    
    let fruitStatusTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    let fruitInfoTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    let fruitOrderLabel: UILabel = {
        let label = UILabel()
        label.text = "참여가능한 과일모임"
        label.textColor = UIColor(named: Constants.FruitfruitColors.black1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let fruitProfile: UIImageView = {
        let profile = UIImageView()
        profile.image = UIImage(named: Constants.FruitfruitImages.profile)
        profile.frame = CGRect(x:0, y:0, width: 48, height: 48)
        profile.translatesAutoresizingMaskIntoConstraints = false
        return profile
    }()
    
    @IBOutlet weak var homeTitleLabel: UILabel!

    
    // MARK: - LIFECYCLES

    override func viewDidLoad() {
        super.viewDidLoad()
        view.applyBackgroundGradient()
        fruitStatusTableView.delegate = self
        fruitStatusTableView.dataSource = self
        fruitStatusTableView.tag = 0
        fruitInfoTableView.delegate = self
        fruitInfoTableView.dataSource = self
        fruitInfoTableView.tag = 1
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
            database.collection(Constants.FStore.Orders.collectionName).document(detailCollectionName).collection(detailCollectionName).order(by: Constants.FStore.Orders.orderField).addSnapshotListener { querySnapShot, error in

//            database.collection(Constants.FStore.Orders.collectionName).document(user.id).collection(detailCollectionName).order(by: Constants.FStore.Orders.orderField).addSnapshotListener { querySnapShot, error in
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
                            self.fruitStatusTableView.reloadData()
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
                            self.fruitInfoTableView.reloadData()
                        }
                    }
                }
            }
        }
    }
    
    private func initHomeViewUI() {
        homeTitleLabel.font = UIFont.preferredFont(for: .title1, weight: .bold)
        initFruitProfile()
        initFruitStatusTableView()
        initFruitOrderLabel()
        initFruitInfoTableView()
    }
    
    private func initFruitStatusTableView() {
        fruitStatusTableView.register(FruitStatusCell.self, forCellReuseIdentifier: FruitStatusCell.identifier)
        view.addSubview(fruitStatusTableView)
        fruitStatusTableView.backgroundColor = .clear
        fruitStatusTableView.separatorStyle = .none
        fruitStatusTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 217).isActive = true
        fruitStatusLabel.heightAnchor.constraint(equalToConstant: 68).isActive = true
    }
    
    private func initFruitInfoTableView() {
        fruitInfoTableView.register(FruitCell.self, forCellReuseIdentifier: FruitCell.identifier)
        view.addSubview(fruitInfoTableView)
        fruitInfoTableView.backgroundColor = .clear
        fruitInfoTableView.separatorStyle = .none
        fruitInfoTableView.widthAnchor.constraint(equalToConstant: view.bounds.width - 48).isActive = true
        fruitInfoTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24).isActive = true
    }
    
    private func setHomeViewUI() {
        //TODO: 주문 상태 활성화되어 있는지 체크
        if !fruitOrders.isEmpty {
            let firstFruitOrder = fruitOrders[0]
            let firstFruitStatus = firstFruitOrder.statusEnum
            let homeTitleText = firstFruitStatus.makeHomeTitleText(fruit: firstFruitOrder.name, time: firstFruitOrder.time, place: firstFruitOrder.place)
            setHomeTitleText(from: homeTitleText)
            fruitStatusTableView.isHidden = false
            setFruitOrderLayout(false)
        } else {
            fruitStatusTableView.isHidden = true
            setHomeTitleText(from: Date().dayComment)
            setFruitOrderLayout(true)
        }
    }
    
    func setHomeTitleText(from text: NSMutableAttributedString) {
        homeTitleLabel.text = ""
        homeTitleLabel.attributedText = text
    }

//    private func setFruitStatusLabel() {
//        view.addSubview(fruitStatusLabel)
//        fruitStatusLabel.widthAnchor.constraint(equalToConstant: view.bounds.width - 48).isActive = true
//        fruitStatusLabel.heightAnchor.constraint(equalToConstant: 68).isActive = true
//        fruitStatusLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24).isActive = true
//        fruitStatusLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 217).isActive = true
//        fruitStatusLabel.isUserInteractionEnabled = true
//        let labelTapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapStatusLabel))
//        fruitStatusLabel.addGestureRecognizer(labelTapGesture)
//    }

//    func setFruitStatusLabelText(from text: String) {
//        fruitStatusLabel.setLabelText(from: text)
//    }
//
//    func setFruitStatusLabelImage(from text: String) {
//        fruitStatusLabel.setLabelImage(from: text)
//    }
    
//    @objc func tapStatusLabel() {
//        print("FruitStatuLabel tapped")
//
//        //TODO: 주문 상태 확인 뷰로 네비게이션 이동하기
//        //TODO: 라벨 클릭 시 일반 버튼처럼 번쩍거리는 클릭 이벤트 효과 주기
//    }
    
    private func initFruitProfile() {
        view.addSubview(fruitProfile)
        fruitProfile.topAnchor.constraint(equalTo: view.topAnchor, constant: 125).isActive = true
        fruitProfile.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -26).isActive = true
        fruitProfile.isUserInteractionEnabled = true
        let profileTapGesture = UITapGestureRecognizer(target: self, action: #selector(tapFruitProfile))
        fruitProfile.addGestureRecognizer(profileTapGesture)
    }
    
    @objc func tapFruitProfile() {
        print("FruitfruitLabel tapped")
    }
    
    private func initFruitOrderLabel() {
        fruitOrderLabel.font = UIFont.preferredFont(for: .headline, weight: .bold)
        view.addSubview(fruitOrderLabel)
        fruitOrderLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24).isActive = true
    }
    
    private func setFruitOrderLayout(_ isTop: Bool) {
        let nextLabel: CGFloat = isTop ? 277 : 335
        let curLabel: CGFloat = isTop ? 335 : 277
        
        fruitOrderLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: curLabel).isActive = false
        fruitOrderLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: nextLabel).isActive = true
        
        let nextTable: CGFloat = isTop ? 309 : 377
        let curTable: CGFloat = isTop ? 377 : 309
        
        fruitInfoTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: curTable).isActive = false
        fruitInfoTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: nextTable).isActive = true
        
        let nextTableHeight: CGFloat = view.bounds.height - nextTable
        let curTableHeight: CGFloat = view.bounds.height - curTable
        
        fruitInfoTableView.heightAnchor.constraint(equalToConstant: curTableHeight).isActive = false
        fruitInfoTableView.heightAnchor.constraint(equalToConstant: nextTableHeight).isActive = true
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView.tag == 0 {
            return fruitOrders.count
        } else {
            return fruitSaleInfos.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView.tag == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: FruitStatusCell.identifier, for: indexPath) as! FruitStatusCell
            let frame = fruitOrders.count == 1 ? CGRect(x: 0, y:0, width: view.bounds.width - 48, height: 68) : CGRect(x: 0, y:0, width: 208, height: 68)
            cell.frame = frame
            cell.setUI(model: fruitOrders[indexPath.section])
            cell.selectionStyle = .none
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: FruitCell.identifier, for: indexPath) as! FruitCell
            let frame = CGRect(x:0, y:0, width: view.bounds.width - 48, height: 154)
            cell.setUI(frame: frame, model: fruitSaleInfos[indexPath.section])
            cell.selectionStyle = .none
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView.tag == 1 {
            return 154
        }
        return 68
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if tableView.tag == 1 {
            return 40
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if tableView.tag == 1 {
            let footerView = UIView()
            footerView.backgroundColor = .clear
            return footerView
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(fruitSaleInfos[indexPath.section])
        //TODO: FruitOrderView로 navigation prepare
    }
}


