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
    
    let fruitProfile: UIImageView = {
        let profile = UIImageView()
        profile.image = UIImage(named: Constants.FruitfruitImages.profile)
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

    override func viewDidLoad() {
        super.viewDidLoad()
        initSettingViewUI()
    }
    
    private func initSettingViewUI() {
        initSettingViewNavBar()
        initProfile()
        initTextField()
        initDivider()
        initCalendar()
    }
    
    private func initSettingViewNavBar() {
        guard let orangeColor = UIColor(named: Constants.FruitfruitColors.orange1) else { return }
        guard let blackColor = UIColor(named: Constants.FruitfruitColors.black1) else { return }
        let backButtonImage = UIImage(systemName: "chevron.left")?.withTintColor(orangeColor, renderingMode: .alwaysOriginal)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: backButtonImage, style: .done, target: self, action: #selector(popToPrevious))
        navigationItem.title = "프로필"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: blackColor, NSAttributedString.Key.font: UIFont.preferredFont(for: .headline, weight: .bold)]
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "수정하기", style: .done, target: self, action: #selector(editToggle))
        navigationItem.rightBarButtonItem?.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: orangeColor, NSAttributedString.Key.font: UIFont.preferredFont(for: .headline, weight: .semibold)], for: .normal)
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
            navigationItem.rightBarButtonItem?.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: blackColor], for: .normal)
        } else {
            saveProfile()
            navigationItem.rightBarButtonItem?.title = "수정하기"
            navigationItem.rightBarButtonItem?.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: orangeColor], for: .normal)
        }
    }
    
    private func saveProfile() {
        guard let name = fruitNameTextField.text, let nickname = fruitNicknameTextField.text else { return }
        guard var user = Storage().fruitUser else { return }
        if !name.isEmpty && !nickname.isEmpty {
            user.nickname = nickname
            user.name = name
            let data = [Constants.FStore.Users.idField : user.id, Constants.FStore.Users.nameField : user.name, Constants.FStore.Users.nicknameField : user.nickname] as [String : Any]
            database.collection(Constants.FStore.Users.collectionName).document(user.id).setData(data)
            Storage().setFruitUser(fruitUser: user)
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
        view.addSubview(fruitNicknameTextField)
        fruitNicknameTextField.delegate = self
        guard let user = Storage().fruitUser else { return }
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
        fruitDivider.topAnchor.constraint(equalTo: fruitProfile.bottomAnchor, constant: 122).isActive = true
        fruitDivider.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
    
    private func initCalendar() {
        guard let blackColor = UIColor(named: Constants.FruitfruitColors.black1) else { return }
        view.addSubview(fruitCalendarLabel)
        fruitCalendarLabel.textColor = blackColor
        fruitCalendarLabel.font = UIFont.preferredFont(for: .headline, weight: .bold)
        fruitCalendarLabel.text = "푸릇푸릇 달력"
        fruitCalendarLabel.topAnchor.constraint(equalTo: fruitDivider.bottomAnchor, constant: 40).isActive = true
        fruitCalendarLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24).isActive = true
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

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
