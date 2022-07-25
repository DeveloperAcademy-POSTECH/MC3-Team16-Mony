//
//  SettingViewController.swift
//  FruitFruit
//
//  Created by Junyeong Park on 2022/07/25.
//

import UIKit

class SettingViewController: UIViewController, UIGestureRecognizerDelegate {
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

    override func viewDidLoad() {
        super.viewDidLoad()
        initSettingViewUI()
    }
    
    private func initSettingViewUI() {
        initSettingViewNavBar()
        initProfile()
        initTextField()
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
        if isProfileEditing {
            navigationItem.rightBarButtonItem?.title = "수정완료"
            navigationItem.rightBarButtonItem?.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: blackColor], for: .normal)
        } else {
            navigationItem.rightBarButtonItem?.title = "수정하기"
            navigationItem.rightBarButtonItem?.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: orangeColor], for: .normal)
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
