//
//  CalendarViewController.swift
//  FruitFruit
//
//  Created by Junyeong Park on 2022/07/26.
//

import UIKit
import FirebaseFirestore
import Lottie

class CalendarViewController: UIViewController, UIGestureRecognizerDelegate {
    private var fruitArrivedOrders = [FruitOrder]()
    private var validModels = [MonthModel]()
    private var validOrders = [Int : [FruitOrder]]()
    private let database = Firestore.firestore()
    private let animationView = AnimationView()
    
    let fruitMonthView: FruitMonthView = {
        let monthView = FruitMonthView()
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
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            self.initCalendarViewUI()
        }
        Task {
            do {
                self.fruitArrivedOrders = try await self.fetchData()
                self.fetchMonthData()
            } catch {
                print(error)
            }
        }
    }
    
    private func initCalendarViewUI() {
        initCalendarTableView()
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
    
    private func fetchOrders() async throws -> [FruitOrder] {
        var fruitArrivedOrders = [FruitOrder]()
        guard let user = Storage().fruitUser else { return [] }
        
        do {
            let snapShot = try await database.collection(Constants.FStore.Orders.collectionName).document(user.id).collection(Constants.FStore.Orders.collectionPath).whereField("status", isEqualTo: "Arrived").getDocuments()
            snapShot.documents.forEach { documentSnapShot in
                let data = documentSnapShot.data()
                do {
                    let fruitOrder: FruitOrder = try FruitOrder.decode(dictionary: data)
                    print(fruitOrder)
                    fruitArrivedOrders.append(fruitOrder)
                } catch {
                    print(error)
                }
            }
        } catch {
            print(error)
        }
        fruitArrivedOrders.sort(by: {$0.dueDate < $1.dueDate})
        return fruitArrivedOrders
    }

    func fetchData() async throws -> [FruitOrder] {
        var orders = [FruitOrder]()
        do {
            orders = try await self.fetchOrders()
        } catch {
            print(error)
        }
        return orders
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
