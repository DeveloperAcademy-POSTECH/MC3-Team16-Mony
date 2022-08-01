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
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.isScrollEnabled = true
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = true
        view.contentInset = .zero
        view.backgroundColor = .clear
        view.clipsToBounds = true
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
        profile.image = UIImage(named: Constants.FruitfruitImages.Others.profile)
        profile.frame = CGRect(x:0, y:0, width: 48, height: 48)
        profile.translatesAutoresizingMaskIntoConstraints = false
        return profile
    }()
    
    let fruitQuestionMark: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let fruitQuestionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    @IBOutlet weak var homeTitleLabel: UILabel!

    
    // MARK: - LIFECYCLES
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.applyBackgroundGradient()
        initHomeViewUI()
        fetchData()
    }
    
    func fetchData() {
        fetchOrders()
        fetchInfos()
    }
        
    private func fetchOrders() {
        if let user = Storage().fruitUser {
            database.collection(Constants.FStore.Orders.collectionName).document(user.id).collection(Constants.FStore.Orders.collectionPath).addSnapshotListener { querySnapShot, error in
                self.fruitOrders = []
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    if let documents = querySnapShot?.documents {
                        for document in documents {
                            let data = document.data()
                            do {
                                let fruitOrder: FruitOrder = try FruitOrder.decode(dictionary: data)
                                if fruitOrder.dueDate >= Date() {
                                    self.fruitOrders.append(fruitOrder)
                                }
                            } catch {
                                print(error)
                            }
                        }
                        self.fruitOrders.sort(by: {$0.dueDate < $1.dueDate})
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
        //TODO: 날짜, 시간 맞춰서 뷰에 보이는 주문 가능 과일 버튼 표시하기
        //TODO: 판매 유효한 과일 -> 날짜순서대로 고르기
        database.collection(Constants.FStore.SaleInfos.collectionName).addSnapshotListener { querySnapShot, error in
            self.fruitSaleInfos.removeAll()
            if let error = error {
                print(error.localizedDescription)
            } else {
                if let documents = querySnapShot?.documents {
                    for document in documents {
                        let data = document.data()
                        do {
                            let fruitSaleInfo: FruitSaleInfo = try FruitSaleInfo.decode(dictionary: data)
                            if fruitSaleInfo.saleDate >= Date() {
                                self.fruitSaleInfos.append(fruitSaleInfo)
                            }
                        } catch {
                            print(error)
                        }
                    }
                    self.fruitSaleInfos.sort(by: {$0.saleDate < $1.saleDate})
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
    
    private func initHomeViewUI() {
        homeTitleLabel.font = UIFont.preferredFont(for: .title1, weight: .bold)
        initFruitProfile()
        initFruitStatusCollectionView()
        initFruitOrderLabel()
        initFruitInfoTableView()
        initFruitQuestion()
    }
    
    private func initFruitStatusCollectionView() {
        fruitStatusCollectionView.register(FruitStatusCell.self, forCellWithReuseIdentifier: FruitStatusCell.id)
        fruitStatusCollectionView.delegate = self
        fruitStatusCollectionView.dataSource = self
        view.addSubview(fruitStatusCollectionView)
        fruitStatusCollectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 217).isActive = true
        fruitStatusCollectionView.heightAnchor.constraint(equalToConstant: 68).isActive = true
        fruitStatusCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24).isActive = true
        fruitStatusCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    private func initFruitInfoTableView() {
        fruitInfoTableView.register(FruitCell.self, forCellReuseIdentifier: FruitCell.identifier)
        fruitInfoTableView.delegate = self
        fruitInfoTableView.dataSource = self
        view.addSubview(fruitInfoTableView)
        fruitInfoTableView.backgroundColor = .clear
        fruitInfoTableView.separatorStyle = .none
        fruitInfoTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 24).isActive = true
        fruitInfoTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24).isActive = true
        fruitInfoTableView.topAnchor.constraint(equalTo: fruitOrderLabel.bottomAnchor, constant: 20).isActive = true
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
        if fruitSaleInfos.isEmpty {
            print(fruitSaleInfos)
            fruitInfoTableView.isHidden = true
            fruitQuestionLabel.isHidden = false
            fruitQuestionMark.isHidden = false
        } else {
            fruitInfoTableView.isHidden = false
            fruitQuestionLabel.isHidden = true
            fruitQuestionMark.isHidden = true
        }
    }
    
    private func setHomeTitleText(from text: NSMutableAttributedString) {
        homeTitleLabel.text = ""
        homeTitleLabel.attributedText = text
    }
    
    private func initFruitQuestion() {
        fruitQuestionMark.text = "?"
        fruitQuestionMark.backgroundColor = .clear
        fruitQuestionMark.textColor = UIColor(named: Constants.FruitfruitColors.gray2)
        fruitQuestionMark.font = UIFont.systemFont(ofSize: 100, weight: UIFont.Weight(rawValue: 600))
//        fruitQuestionMark.font = UIFont.preferredFont(for: .largeTitle, weight: .bold)
        fruitQuestionLabel.text = "참여가능한 과일모임이 없네요"
        fruitQuestionLabel.textColor = UIColor(named: Constants.FruitfruitColors.gray1)
        fruitQuestionLabel.font = UIFont.preferredFont(for: .headline, weight: .bold)
        view.addSubview(fruitQuestionMark)
        view.addSubview(fruitQuestionLabel)
        fruitQuestionMark.topAnchor.constraint(equalTo: view.topAnchor, constant: 442).isActive = true
        fruitQuestionMark.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 174).isActive = true
        fruitQuestionMark.heightAnchor.constraint(equalToConstant: 72).isActive = true
        fruitQuestionMark.widthAnchor.constraint(equalToConstant: 55).isActive = true
        //TODO: HIFI Design -> "?" 폰트 맞추기
        fruitQuestionLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 596).isActive = true
        fruitQuestionLabel.widthAnchor.constraint(equalToConstant: 207).isActive = true
        fruitQuestionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 92).isActive = true
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
        let storyboard = UIStoryboard(name: "Setting", bundle: nil)
        let settingVC = storyboard.instantiateViewController(withIdentifier: "SettingViewController") as! SettingViewController
        let homeVC = self.navigationController
        homeVC?.pushViewController(settingVC, animated: true)
        homeVC?.isNavigationBarHidden = false
    }
    
    private func initFruitOrderLabel() {
        fruitOrderLabel.font = UIFont.preferredFont(for: .headline, weight: .bold)
        view.addSubview(fruitOrderLabel)
        fruitOrderLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24).isActive = true
        let fruitOrderLabelTop = fruitOrderLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 237)
        fruitOrderLabelTop.isActive = true
        fruitOrderLabelTop.identifier = "fruitOrderLabelTop"
    }
    
    private func setFruitOrderLayout(_ isTop: Bool) {
        view.constraints.filter{$0.identifier == "fruitOrderLabelTop"}.first?.constant = isTop ? 237 : 335
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
        return 10
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        footerView.backgroundColor = .clear
        return footerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "OrderView", bundle: nil)
        guard let orderVC = storyboard.instantiateViewController(withIdentifier: "OrderViewController") as? OrderViewController else { return }
        orderVC.fruitSaleInfo = fruitSaleInfos[indexPath.section]
        let homeVC = self.navigationController
        homeVC?.pushViewController(orderVC, animated: true)
        homeVC?.isNavigationBarHidden = false
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
        // 1. ConfrimStatusView -> 연동
        let storyboard = UIStoryboard(name: "ConfirmStatus", bundle: nil)
        guard let confirmVC = storyboard.instantiateViewController(withIdentifier: "ConfirmStatusViewController") as? ConfirmStatusViewController else { return }
        // 2. Data Binding
        confirmVC.fruitOrder = fruitOrders[indexPath.item]
        let homeVC = self.navigationController
        homeVC?.pushViewController(confirmVC, animated: true)
        homeVC?.isNavigationBarHidden = true
        
    }
}
