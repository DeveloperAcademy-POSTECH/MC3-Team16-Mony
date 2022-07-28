//
//  CalendarViewController.swift
//  FruitFruit
//
//  Created by Junyeong Park on 2022/07/26.
//

import UIKit
import FirebaseFirestore
import Lottie

//TODO: 로딩 시간 -> 로티 넣기

class CalendarViewController: UIViewController, UIGestureRecognizerDelegate {
    var fruitArrivedOrders = [FruitOrder]()
    var validModels = [MonthModel]()
    var validOrders = [Int : [FruitOrder]]()
    let database = Firestore.firestore()
    let animationView = AnimationView()
    
    let fruitMonthView: FruitMonthView = {
        let monthView = FruitMonthView()
        monthView.translatesAutoresizingMaskIntoConstraints = false
        return monthView
    }()
    
    let fruitCalendarTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        initCalendarViewNavBar()
        self.playLottie()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
            self.initCalendarViewUI()
        }
    }
    
    private func initCalendarViewUI() {
        initCalendarTableView()
        fetchOrders()
        view.applyBackgroundGradient()
    }
    
    private func initCalendarViewNavBar() {
        guard let orangeColor = UIColor(named: Constants.FruitfruitColors.orange1) else { return }
        guard let blackColor = UIColor(named: Constants.FruitfruitColors.black1) else { return }
        let backButtonImage = UIImage(systemName: "chevron.left")?.withTintColor(orangeColor, renderingMode: .alwaysOriginal)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: backButtonImage, style: .done, target: self, action: #selector(popToPrevious))
        navigationItem.title = "푸릇푸릇 달력"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: blackColor, NSAttributedString.Key.font: UIFont.preferredFont(for: .headline, weight: .bold)]
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .clear
        appearance.shadowColor = .clear
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
    }
    
    @objc private func popToPrevious() {
        navigationController?.popViewController(animated: true)
    }
    
    private func fetchOrders() {
        guard let user = Storage().fruitUser else { return }
        let detailCollectionName = "\(user.name) \(user.nickname)"
        database.collection(Constants.FStore.Orders.collectionName).document(user.id).collection(detailCollectionName).whereField("status", isEqualTo: "Arrived").getDocuments { querySnapShot, error in
            self.fruitArrivedOrders = []
            if let error = error {
                print(error.localizedDescription)
            } else {
                if let documents = querySnapShot?.documents {
                    for document in documents {
                        let data = document.data()
                        do {
                            let fruitOrder: FruitOrder = try FruitOrder.decode(dictionary: data)
                            self.fruitArrivedOrders.append(fruitOrder)
                        } catch {
                            print(error)
                        }
                    }
                    self.fruitArrivedOrders.sort(by: {$0.dueDate < $1.dueDate})
                    DispatchQueue.main.async {
                        self.fetchMonthData()
                    }
                }
            }
        }
    }
    
    private func fetchMonthData() {
        // 첫 번째 달 -> MonthView 그려보기
        guard let firstMonth = fruitArrivedOrders.first else {
            validModels = Date().getValidMonthModels(from: Date(), to: Date())
            return
        }
        let firstMonthDueDate = firstMonth.dueDate
        validModels = Date().getValidMonthModels(from: firstMonthDueDate, to: Date())
        var monthIdxDict = [MonthModel:Int]()
        for model in validModels.enumerated() {
            monthIdxDict[model.element] = model.offset
        }
        for order in fruitArrivedOrders {
            let dueDate = order.dueDate
            let orderMonthModel = MonthModel(date: dueDate)
            if monthIdxDict[orderMonthModel] != nil {
                let idx = monthIdxDict[orderMonthModel]!
                var savedData = validOrders[idx] ?? []
                savedData.append(order)
                validOrders[idx] = savedData
            }
        }
        fruitCalendarTableView.reloadData()
    }
    
    private func setMonthView(model: MonthModel) {
        var validOrders = [FruitOrder]()
        for order in fruitArrivedOrders {
            if let _ = model.getDatePosition(from: order.dueDate) {
                validOrders.append(order)
            }
        }

        view.addSubview(fruitMonthView)
        let leadingMonthPadding: CGFloat = (view.bounds.width - 328) / 2
        fruitMonthView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leadingMonthPadding - 7).isActive = true
        fruitMonthView.topAnchor.constraint(equalTo: view.topAnchor, constant: 200).isActive = true
        fruitMonthView.setUI(model: model, orders: validOrders)
    }
    
    private func initCalendarTableView() {
        view.addSubview(fruitCalendarTableView)
        fruitCalendarTableView.separatorStyle = .none
        fruitCalendarTableView.delegate = self
        fruitCalendarTableView.dataSource = self
        fruitCalendarTableView.register(FruitMonthCell.self, forCellReuseIdentifier: FruitMonthCell.id)
        fruitCalendarTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        let leadingMonthPadding: CGFloat = (view.bounds.width - 328) / 2
        fruitCalendarTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leadingMonthPadding - 7).isActive = true
        fruitCalendarTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        fruitCalendarTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    private func playLottie() {
        let background = UILabel()
        background.frame = CGRect(x: 0, y: 0, width: 390, height: 844)
        background.backgroundColor = .white
//        background.layer.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
        background.tag = 0
        view.addSubview(background)
        
        animationView.frame = CGRect(x: 93, y: 315, width: 180, height: 180)
        animationView.contentMode = .scaleAspectFill
        animationView.animation = Animation.named("FruitLottie")
        animationView.play(fromFrame: 0, toFrame: 35)
        animationView.loopMode = .repeat(2)
        view.addSubview(animationView)
    }
}

extension CalendarViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return validModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FruitMonthCell.id, for: indexPath) as? FruitMonthCell else { return FruitMonthCell() }
        cell.selectionStyle = .none
        cell.setUI(model: validModels[indexPath.section], orders: validOrders[indexPath.section] ?? [])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let numOfWeek = validModels[indexPath.section].numOfWeeks
        let height = (numOfWeek + 2) * 40 + 2 + numOfWeek * 17
        return CGFloat(height)
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        footerView.backgroundColor = .clear
        return footerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 80
    }
}

