//
//  CalendarViewController.swift
//  FruitFruit
//
//  Created by Junyeong Park on 2022/07/26.
//

import UIKit

class CalendarViewController: UIViewController, UIGestureRecognizerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        initCalendarViewUI()
    }
    
    private func initCalendarViewUI() {
        initCalendarViewNavBar()
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
    }
    
    @objc private func popToPrevious() {
        navigationController?.popViewController(animated: true)
    }
    
}
