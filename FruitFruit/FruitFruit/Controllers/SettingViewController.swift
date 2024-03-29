//
//  SettingViewController.swift
//  FruitFruit
//
//  Created by Junyeong Park on 2022/07/25.
//

import UIKit
import FirebaseFirestore

class SettingViewController: UIViewController, UIGestureRecognizerDelegate {
    
    let database = Firestore.firestore()
    var isProfileEditing: Bool = false
    private var validWeekString = [[String]]()
    private var fruitArrivedOrders = [Int:[FruitOrder]]()
    private var todayPos: (Int, Int)?
    
    let fruitProfile: UIImageView = {
        let profile = UIImageView()
        profile.image = UIImage(named: Constants.FruitfruitImages.Others.profile)
        profile.translatesAutoresizingMaskIntoConstraints = false
        return profile
    }()
    
    let fruitNicknameTextField: FruitSettingTextField = {
        let textField = FruitSettingTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let fruitNameTextField: FruitSettingTextField = {
        let textField = FruitSettingTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let fruitDivider: UIView = {
        let divider = UIView.init(frame: CGRect(x:0, y:0, width: 0, height: 0))
        divider.translatesAutoresizingMaskIntoConstraints = false
        return divider
    }()
    
    let fruitCalendarLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let fruitCalendarContainer: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let fruitCalendarButton: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let fruitWeekCalendar: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initSettingViewUI()
        Task {
            do {
                self.fruitArrivedOrders = try await self.fetchOrders()
                self.fruitWeekCalendar.reloadData()
            } catch {
                print(error)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    private func initSettingViewUI() {
        initSettingViewNavBar()
        initProfile()
        initTextField()
        initDivider()
        initCalendarLabel()
        initCalendarContainer()
        initWeekCalendar()
    }
    
    private func initSettingViewNavBar() {
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        
        guard let orangeColor = UIColor(named: Constants.FruitfruitColors.orange1) else { return }
        guard let blackColor = UIColor(named: Constants.FruitfruitColors.black1) else { return }
        
        let backButtonImage = UIImage(systemName: "chevron.left")?.withTintColor(orangeColor, renderingMode: .alwaysOriginal)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: backButtonImage, style: .done, target: self, action: #selector(popToPrevious))
        
        navigationItem.title = "프로필"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: blackColor, NSAttributedString.Key.font: UIFont.preferredFont(for: .headline, weight: .bold)]
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "수정하기", style: .done, target: self, action: #selector(editToggle))
        navigationItem.rightBarButtonItem?.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: orangeColor, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15, weight: .semibold)], for: .normal)
        navigationItem.rightBarButtonItem?.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: blackColor, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15, weight: .semibold)], for: .selected)
    }
    
    @objc private func popToPrevious() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func editToggle() {
        guard let orangeColor = UIColor(named: Constants.FruitfruitColors.orange1) else { return }
        guard let blackColor = UIColor(named: Constants.FruitfruitColors.black1) else { return }
        
        isProfileEditing.toggle()
        fruitNicknameTextField.isUserInteractionEnabled.toggle()
        fruitNameTextField.isUserInteractionEnabled.toggle()
        
        if isProfileEditing {
            fruitNicknameTextField.becomeFirstResponder()
            navigationItem.rightBarButtonItem?.title = "수정완료"
            navigationItem.rightBarButtonItem?.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: blackColor, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15, weight: .semibold)], for: .normal)
        } else {
            saveProfile()
            navigationItem.rightBarButtonItem?.title = "수정하기"
            navigationItem.rightBarButtonItem?.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: orangeColor, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15, weight: .semibold)], for: .normal)
        }
    }
    
    private func saveProfile() {
        guard let name = fruitNameTextField.text, let nickname = fruitNicknameTextField.text else { return }
        guard let user = Storage().fruitUser else { return }
        
        let curId = user.id
        if !name.isEmpty && !nickname.isEmpty {
            let fruitUser = FruitUser(id: curId, name: name, nickname: nickname)
            let data = [Constants.FStore.Users.idField : user.id, Constants.FStore.Users.nameField : user.name, Constants.FStore.Users.nicknameField : user.nickname] as [String : Any]
            database.collection(Constants.FStore.Users.collectionName).document(user.id).setData(data)
            Storage().setFruitUser(fruitUser: fruitUser)
        }
    }
    
    private func initProfile() {
        view.addSubview(fruitProfile)
        fruitProfile.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 134).isActive = true
        fruitProfile.topAnchor.constraint(equalTo: view.topAnchor, constant: 125).isActive = true
        fruitProfile.widthAnchor.constraint(equalToConstant: 118).isActive = true
        fruitProfile.heightAnchor.constraint(equalToConstant: 118).isActive = true
    }
    
    private func initTextField() {
        guard let user = Storage().fruitUser else { return }
        
        view.addSubview(fruitNicknameTextField)
        fruitNicknameTextField.delegate = self
        fruitNicknameTextField.font = UIFont.preferredFont(for: .title1, weight: .bold)
        fruitNicknameTextField.topAnchor.constraint(equalTo: fruitProfile.bottomAnchor, constant: 20).isActive = true
        fruitNicknameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        fruitNicknameTextField.text = user.nickname
        fruitNicknameTextField.placeholder = user.nickname
        
        view.addSubview(fruitNameTextField)
        fruitNameTextField.delegate = self
        fruitNameTextField.font = UIFont.preferredFont(for: .headline, weight: .bold)
        fruitNameTextField.topAnchor.constraint(equalTo: fruitNicknameTextField.bottomAnchor, constant: 10).isActive = true
        fruitNameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        fruitNameTextField.text = user.name
        fruitNameTextField.placeholder = user.name
        //TODO: 텍스트 필드 내 폰트 체크
    }
    
    private func initDivider() {
        view.addSubview(fruitDivider)
        guard let grayColor = UIColor(named: Constants.FruitfruitColors.gray2) else { return }
        fruitDivider.backgroundColor = grayColor
        fruitDivider.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        fruitDivider.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        fruitDivider.topAnchor.constraint(equalTo: fruitProfile.bottomAnchor, constant: 146).isActive = true
        fruitDivider.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
    
    private func initCalendarLabel() {
        view.addSubview(fruitCalendarLabel)
        guard let blackColor = UIColor(named: Constants.FruitfruitColors.black1) else { return }
        fruitCalendarLabel.textColor = blackColor
        fruitCalendarLabel.font = UIFont.preferredFont(for: .headline, weight: .bold)
        fruitCalendarLabel.text = "푸릇푸릇 달력"
        fruitCalendarLabel.topAnchor.constraint(equalTo: fruitDivider.bottomAnchor, constant: 40).isActive = true
        fruitCalendarLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24).isActive = true
    }
    
    private func initCalendarContainer() {
        view.addSubview(fruitCalendarContainer)
        guard let grayColor = UIColor(named: Constants.FruitfruitColors.gray3) else { return }
        initCalendarButton()
        
        fruitCalendarContainer.clipsToBounds = true
        fruitCalendarContainer.layer.cornerRadius = 20
        fruitCalendarContainer.backgroundColor = grayColor
        fruitCalendarContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        fruitCalendarContainer.topAnchor.constraint(equalTo: view.topAnchor, constant: 462).isActive = true
        fruitCalendarContainer.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 32).isActive = true
        fruitCalendarContainer.heightAnchor.constraint(equalToConstant: 204).isActive = true
    }
    
    private func fetchValidWeeks() -> [DateComponents] {
        let calendar = Calendar.current
        let validWeeks = Date().getValidWeeks()
        
        let validWeeksComponents = Array(validWeeks.map{calendar.dateComponents([.year, .month, .day], from: $0)})
        
        var dayIndex = 0
        for _ in 0..<2 {
            var tmpWeek = [String]()
            for _ in 0..<7 {
                let dayString = String(validWeeksComponents[dayIndex].day!)
                tmpWeek.append(dayString)
                dayIndex += 1
            }
            validWeekString.append(tmpWeek)
        }
        
        let weekDict = ["일":0, "월":1, "화":2, "수":3, "목":4, "금":5, "토":6]
        todayPos = (1, weekDict[Date().dayString] ?? 0)
        return validWeeksComponents
    }
    
    private func fetchOrders() async throws -> [Int:[FruitOrder]] {
        var fruitArrivedOrders = [Int:[FruitOrder]]()
        
        let calendar = Calendar.current
        let validWeeksComponents = fetchValidWeeks()
        guard let user = Storage().fruitUser else { return [:] }
        
        let validFirstWeekSet = Set(validWeeksComponents[0..<7])
        let validSecondWeekSet = Set(validWeeksComponents[7..<14])
        
        do {
            let snapShot = try await database.collection(Constants.FStore.Orders.collectionName).document(user.id).collection(Constants.FStore.Orders.collectionPath).whereField("status", isEqualTo: "Arrived").getDocuments()
            snapShot.documents.forEach { documentSnapShot in
                let data = documentSnapShot.data()
                do {
                    let fruitOrder: FruitOrder = try FruitOrder.decode(dictionary: data)
                    let orderComponent = calendar.dateComponents([.year, .month, .day], from: fruitOrder.dueDate)
                    if validFirstWeekSet.contains(orderComponent) {
                        var savedDays = fruitArrivedOrders[0] ?? []
                        savedDays.append(fruitOrder)
                        fruitArrivedOrders[0] = savedDays
                    } else if validSecondWeekSet.contains(orderComponent) {
                        var savedDays = fruitArrivedOrders[1] ?? []
                        savedDays.append(fruitOrder)
                        fruitArrivedOrders[1] = savedDays
                    }
                } catch {
                    print(error)
                }
            }
        } catch {
            print(error)
        }
        return fruitArrivedOrders
    }
    
    private func initCalendarButton() {
        view.addSubview(fruitCalendarButton)
        guard let orangeColor = UIColor(named: Constants.FruitfruitColors.orange1) else { return }
        fruitCalendarButton.text = "캘린더 보기"
        fruitCalendarButton.textColor = orangeColor
        fruitCalendarButton.font = UIFont.preferredFont(for: .subheadline, weight: .semibold)
        fruitCalendarButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        fruitCalendarButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 611).isActive = true
        fruitCalendarButton.widthAnchor.constraint(equalToConstant: 71).isActive = true
        fruitCalendarButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        fruitCalendarButton.isUserInteractionEnabled = true
        let calendarTapGesture = UITapGestureRecognizer(target: self, action: #selector(calendarTapGesture))
        fruitCalendarButton.addGestureRecognizer(calendarTapGesture)
    }
    
    private func initWeekCalendar() {
        view.addSubview(fruitWeekCalendar)
        fruitWeekCalendar.delegate = self
        fruitWeekCalendar.dataSource = self
        fruitWeekCalendar.separatorStyle = .none
        fruitWeekCalendar.backgroundColor = .clear
        fruitWeekCalendar.isUserInteractionEnabled = false
        fruitWeekCalendar.register(FruitWeekCell.self, forCellReuseIdentifier: FruitWeekCell.id)
        fruitWeekCalendar.topAnchor.constraint(equalTo: fruitCalendarContainer.topAnchor, constant: 26).isActive = true
        fruitWeekCalendar.leadingAnchor.constraint(equalTo: fruitCalendarContainer.leadingAnchor, constant: 15).isActive = true
        fruitWeekCalendar.trailingAnchor.constraint(equalTo: fruitCalendarContainer.trailingAnchor, constant: -15).isActive = true
        fruitWeekCalendar.bottomAnchor.constraint(equalTo: fruitCalendarButton.topAnchor, constant: -26).isActive = true
    }
    
    @objc private func calendarTapGesture() {
        let storyboard = UIStoryboard(name: "Calendar", bundle: nil)
        guard let calendarVC = storyboard.instantiateViewController(withIdentifier: "CalendarViewController") as? CalendarViewController else { return }
        let settingVC = self.navigationController
        settingVC?.pushViewController(calendarVC, animated: true)
    }
}

extension SettingViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        guard let fruitSettingTextField = textField as? FruitSettingTextField else { return }
        fruitSettingTextField.bottomBorder.isHidden = false
        DispatchQueue.main.async {
            fruitSettingTextField.selectedTextRange = fruitSettingTextField.textRange(from: fruitSettingTextField.endOfDocument, to: fruitSettingTextField.endOfDocument)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let fruitSettingTextField = textField as? FruitSettingTextField else { return }
        fruitSettingTextField.bottomBorder.isHidden = true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return validWeekString.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FruitWeekCell.id, for: indexPath) as? FruitWeekCell, let todayPos = todayPos else { return FruitWeekCell() }
        let orders = fruitArrivedOrders[indexPath.section] ?? []
        let dayPos = indexPath.section == 1 ? todayPos.1 : nil
        cell.setUI(model: validWeekString[indexPath.section], orders: orders, todayPos: dayPos)
        cell.backgroundColor = .clear
        return cell
    }
}
