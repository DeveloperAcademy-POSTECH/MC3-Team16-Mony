//
//  SettingViewController.swift
//  FruitFruit
//
//  Created by Junyeong Park on 2022/07/25.
//

import UIKit

class SettingViewController: UIViewController, UIGestureRecognizerDelegate {
    var isProfileEditing: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        initSettingViewNavBar()
    }
    
    private func initSettingViewNavBar() {
        guard let orangeColor = UIColor(named: Constants.FruitfruitColors.orange1) else { return }
        guard let blackColor = UIColor(named: Constants.FruitfruitColors.black1) else { return }
        let backButtonImage = UIImage(systemName: "chevron.left")?.withTintColor(orangeColor, renderingMode: .alwaysOriginal)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: backButtonImage, style: .done, target: self, action: #selector(popToPrevious))
        navigationItem.title = "프로필"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: blackColor, NSAttributedString.Key.font: UIFont.preferredFont(for: .headline, weight: .semibold)]
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
