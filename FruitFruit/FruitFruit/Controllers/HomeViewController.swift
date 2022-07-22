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
    
    let fruitStatusCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 204, height: 68)
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.isScrollEnabled = true
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = true
        view.contentInset = .zero
        view.backgroundColor = .clear
        view.clipsToBounds = true
        view.register(FruitStatusCell.self, forCellWithReuseIdentifier: FruitStatusCell.id)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
        fruitStatusCollectionView.delegate = self
        fruitStatusCollectionView.dataSource = self
        fruitInfoTableView.delegate = self
        fruitInfoTableView.dataSource = self
        initHomeViewUI()
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
                        let layout = UICollectionViewFlowLayout()
                        layout.scrollDirection = .horizontal

                        if self.fruitOrders.count == 1 {
                            layout.itemSize = CGSize(width: self.view.bounds.width - 48, height: 68)
                        } else {
                            layout.itemSize = CGSize(width: 204, height: 68)
                        }
                        self.fruitStatusCollectionView.collectionViewLayout = layout
                        DispatchQueue.main.async {
                            self.setHomeViewUI()
                            if !self.fruitOrders.isEmpty {
                                self.fruitStatusCollectionView.reloadData()
                            }
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
                            self.setHomeViewUI()
                            if !self.fruitSaleInfos.isEmpty {
                                self.fruitInfoTableView.reloadData()
                            }
                        }
                    }
                }
            }
        }
    }
    
    private func initHomeViewUI() {
        homeTitleLabel.font = UIFont.preferredFont(for: .title1, weight: .bold)
        initFruitProfile()
        initFruitStatusCollectionView()
        initFruitOrderLabel()
        initFruitInfoTableView()
    }
    
    private func initFruitStatusCollectionView() {
        view.addSubview(fruitStatusCollectionView)
        fruitStatusCollectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 217).isActive = true
        fruitStatusCollectionView.heightAnchor.constraint(equalToConstant: 68).isActive = true
        fruitStatusCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24).isActive = true
        fruitStatusCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
    }
    
    private func initFruitInfoTableView() {
        fruitInfoTableView.register(FruitCell.self, forCellReuseIdentifier: FruitCell.identifier)
        view.addSubview(fruitInfoTableView)
        fruitInfoTableView.backgroundColor = .clear
        fruitInfoTableView.separatorStyle = .none
        fruitInfoTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 24).isActive = true
        fruitInfoTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24).isActive = true
        fruitInfoTableView.topAnchor.constraint(equalTo: fruitOrderLabel.bottomAnchor, constant: 10).isActive = true
        fruitInfoTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    private func setHomeViewUI() {
        //TODO: 주문 상태 활성화되어 있는지 체크
        if !fruitOrders.isEmpty {
            let firstFruitOrder = fruitOrders[0]
            let firstFruitStatus = firstFruitOrder.statusEnum
            let homeTitleText = firstFruitStatus.makeHomeTitleText(fruit: firstFruitOrder.name, time: firstFruitOrder.time, place: firstFruitOrder.place)
            setHomeTitleText(from: homeTitleText)
            setFruitOrderLayout(false)
            fruitStatusCollectionView.isHidden = false
        } else {
            fruitStatusCollectionView.isHidden = true
            setHomeTitleText(from: Date().dayComment)
            setFruitOrderLayout(true)
        }
    }
    
    func setHomeTitleText(from text: NSMutableAttributedString) {
        homeTitleLabel.text = ""
        homeTitleLabel.attributedText = text
    }
    
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
        addMockOrder(fruitOrder: FruitOrder(name: "복숭아", dueDate: Date(), amount: 3, price: 400, status: "Checking", user: FruitUser(name: "박준영", nickname: "노아"), place: "C5", time: 15))
    }
    
    private func initFruitOrderLabel() {
        fruitOrderLabel.font = UIFont.preferredFont(for: .headline, weight: .bold)
        view.addSubview(fruitOrderLabel)
        fruitOrderLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24).isActive = true
        let fruitOrderLabelTop = fruitOrderLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 277)
        fruitOrderLabelTop.isActive = true
        fruitOrderLabelTop.identifier = "fruitOrderLabelTop"
    }
    
    private func setFruitOrderLayout(_ isTop: Bool) {
        
        for constraint in self.view.constraints {
            if constraint.identifier == "fruitOrderLabelTop" {
                constraint.constant = isTop ? 277 : 335
            }
        }
        
        UIView.animate(withDuration: 0.8, delay: 0.0, options: .curveEaseInOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
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
        return 40
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        footerView.backgroundColor = .clear
        return footerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(fruitSaleInfos[indexPath.section])
        //TODO: FruitOrderView로 navigation prepare
    }
}

extension HomeViewController: UICollectionViewDelegate {
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fruitOrders.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = fruitStatusCollectionView.dequeueReusableCell(withReuseIdentifier: FruitStatusCell.id, for: indexPath) as! FruitStatusCell
        cell.prepare(model: fruitOrders[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(fruitOrders[indexPath.item])
    }
}


