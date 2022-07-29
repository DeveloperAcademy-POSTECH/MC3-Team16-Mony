//
//  BottomSheetViewController.swift
//  FruitFruit
//
//  Created by 유재훈 on 2022/07/26.
//

import UIKit

class BottomSheetViewController: UIViewController {

//    @IBOutlet var lbl: UILabel!
    var defaultHeight: CGFloat = 250
    var Number = 1
    let lblNumber: UILabel = {
       var lblNumber = UILabel()
        lblNumber.translatesAutoresizingMaskIntoConstraints = false
        return lblNumber
    }()
    let btnPlus: UIButton = {
        let btnPlus = UIButton(type: .custom)
        btnPlus.translatesAutoresizingMaskIntoConstraints = false
        return btnPlus
    }()
    let btnMinus: UIButton = {
        let btnMinus = UIButton(type: .custom)
        btnMinus.translatesAutoresizingMaskIntoConstraints = false
        return btnMinus
    }()
    let checkOrderButton: UIButton = {
        let checkOrderButton = UIButton(type: .custom)
        checkOrderButton.translatesAutoresizingMaskIntoConstraints = false
        return checkOrderButton
    }()
    
    private let dimmedView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.darkGray.withAlphaComponent(0.7)
        return view
    }()
    private let bottomSheetView: UIView = {
            let view = UIView()
            view.backgroundColor = .white
            view.layer.cornerRadius = 40
            view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            view.clipsToBounds = true
            return view
            }()
    private var bottomSheetViewTopConstraint: NSLayoutConstraint!
    
    
    private func setupUI() {
        view.addSubview(dimmedView)
        view.addSubview(bottomSheetView)
        dimmedView.alpha = 0.0
        setupLayout()
        lblNumber.text = setCount()
        view.addSubview(lblNumber)
        lblNumber.topAnchor.constraint(equalTo: bottomSheetView.topAnchor, constant: 72).isActive = true
        lblNumber.leadingAnchor.constraint(equalTo: bottomSheetView.leadingAnchor, constant: 179).isActive = true
        
        btnPlus.setImage(UIImage(named: "Fruitfruit_btn_Plus"), for: .normal)
        self.view.addSubview(btnPlus)
        btnPlus.topAnchor.constraint(equalTo: bottomSheetView.topAnchor, constant: 72).isActive = true
        btnPlus.leadingAnchor.constraint(equalTo: bottomSheetView.leadingAnchor, constant: 265).isActive = true
        btnPlus.addTarget(self, action: #selector(onTapPlus), for: .touchUpInside)
        
        btnMinus.setImage(UIImage(named: "Fruitfruit_btn_Minus"), for: .normal)
        self.view.addSubview(btnMinus)
        btnMinus.topAnchor.constraint(equalTo: bottomSheetView.topAnchor, constant: 72).isActive = true
        btnMinus.leadingAnchor.constraint(equalTo: bottomSheetView.leadingAnchor, constant: 110).isActive = true
        btnMinus.addTarget(self, action: #selector(onTapMinus), for: .touchUpInside)
        
        self.view.addSubview(checkOrderButton)
        checkOrderButton.topAnchor.constraint(equalTo: bottomSheetView.topAnchor, constant: 152).isActive = true
        checkOrderButton.leadingAnchor.constraint(equalTo: bottomSheetView.leadingAnchor, constant: 24).isActive = true
        checkOrderButton.trailingAnchor.constraint(equalTo: bottomSheetView.trailingAnchor, constant: -24).isActive = true
        checkOrderButton.bottomAnchor.constraint(equalTo: bottomSheetView.bottomAnchor, constant: -40).isActive = true
        checkOrderButton.frame.size = CGSize(width: view.bounds.size.width - 48, height: 58)
        let gradient = checkOrderButton.applyButtonGradient(colors: Constants.FruitfruitColors.buttonGradient)
        checkOrderButton.setTitle(costcountCheckText(), for: .normal)
        checkOrderButton.backgroundColor = .blue
        checkOrderButton.titleLabel?.font = UIFont.preferredFont(for: .headline, weight: .semibold)
        checkOrderButton.layer.cornerRadius = 16
        checkOrderButton.layer.borderWidth = 1
        checkOrderButton.layer.borderColor = UIColor(named: Constants.FruitfruitColors.button1)?.cgColor
        checkOrderButton.layer.insertSublayer(gradient, at: 0)
        checkOrderButton.addTarget(self, action: #selector(onTapOrder), for: .touchUpInside)
    }
    private func setCount() -> String {
        let count = String(Number) + "개"
        return count
    }
    private func setCost() -> String {
        let cost = "900원 "
        return cost
    }
    private func costcountCheckText() -> String {
        return setCost() + setCount() + " 주문하기"
    }
    
    override func viewDidLoad() {
          super.viewDidLoad()
          setupUI()
        let dimmedTap = UITapGestureRecognizer(target: self, action: #selector(dimmedViewTapped(_:)))
            dimmedView.addGestureRecognizer(dimmedTap)
            dimmedView.isUserInteractionEnabled = true
      }
    @objc
    func onTapPlus() {
        Number += 1
        lblNumber.text = setCount()
    }
    
    @objc
    func onTapMinus() {
        if Number - 1 <= 0 {
            return
    }
        Number -= 1
        lblNumber.text = setCount()
    }
    
    @objc
    func onTapOrder() {
        print("맛있는 과일 사기 was tapped.")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showBottomSheet()
    }
    private func setupLayout() {
        dimmedView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
        dimmedView.topAnchor.constraint(equalTo: view.topAnchor),
        dimmedView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        dimmedView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        dimmedView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        bottomSheetView.translatesAutoresizingMaskIntoConstraints = false
    let topConstant = view.safeAreaInsets.bottom + view.safeAreaLayoutGuide.layoutFrame.height
        bottomSheetViewTopConstraint = bottomSheetView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: topConstant)
                NSLayoutConstraint.activate([
        bottomSheetView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
        bottomSheetView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        bottomSheetView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        bottomSheetViewTopConstraint,
                ])
    }
    private func showBottomSheet() {
        let safeAreaHeight: CGFloat = view.safeAreaLayoutGuide.layoutFrame.height
        let bottomPadding: CGFloat = view.safeAreaInsets.bottom
        
       bottomSheetViewTopConstraint.constant = (safeAreaHeight + bottomPadding) - defaultHeight
        
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseIn, animations: {
            self.dimmedView.alpha = 0.7
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    private func hideBottomSheetAndGoBack() {
        let safeAreaHeight = view.safeAreaLayoutGuide.layoutFrame.height
        let bottomPadding = view.safeAreaInsets.bottom
        bottomSheetViewTopConstraint.constant = safeAreaHeight + bottomPadding
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseIn, animations: {
            self.dimmedView.alpha = 0.0
            self.view.layoutIfNeeded()
        }) { _ in
            if self.presentingViewController != nil {
                self.dismiss(animated: false, completion: nil)
            }
        }
    }
    @objc private func dimmedViewTapped(_ tapRecognizer: UITapGestureRecognizer) {
        hideBottomSheetAndGoBack()
    }
}
