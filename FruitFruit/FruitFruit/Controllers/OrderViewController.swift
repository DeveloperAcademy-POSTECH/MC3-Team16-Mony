//ani
//  OrderViewController.swift
//  FruitFruit
//
//  Created by 유재훈 on 2022/07/19.
//

import UIKit

class OrderViewController: UIViewController, UIGestureRecognizerDelegate {
    var fruitSaleInfo: FruitSaleInfo?
    @IBOutlet weak var fruitImage: UIImageView!
    @IBOutlet weak var fruitOriginLabel: UILabel!
    @IBOutlet weak var fruitNameLabel: UILabel!
    @IBOutlet weak var fruitOriginSublabel: UILabel!
    @IBOutlet weak var fruitOriginTitlelabel: UILabel!
    @IBOutlet weak var shopNameLabel: UILabel!
    @IBOutlet weak var shopNameTitlelabel: UILabel!
    @IBOutlet weak var placeHeadLabel: UILabel!
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var timeHeadLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var priceTitlelabel: UILabel!
    @IBOutlet var checkOrderButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initOrderViewNavBar()
        setUI()
        setCheckOrderButtonUI()
        view.applyBackgroundGradient()
        setLocationViewUI()
        setTimeViewUI()
        view.addSubview(LocationView)
        view.addSubview(TimeView)
        view.addSubview(checkOrderButton)
        checkOrderButton.addTarget(self, action: #selector(checkOrderButtonTapped), for: .touchUpInside)
        view.applyBackgroundGradient()
        if let backgroundView = view.viewWithTag(1) {
            view.sendSubviewToBack(backgroundView)
        }
        self.view = view
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    private func initOrderViewNavBar() {
        guard let orangeColor = UIColor(named: Constants.FruitfruitColors.orange1) else { return }
        guard let blackColor = UIColor(named: Constants.FruitfruitColors.black1) else { return }
        let backButtonImage = UIImage(systemName: "chevron.left")?.withTintColor(orangeColor, renderingMode: .alwaysOriginal)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: backButtonImage, style: .done, target: self, action: #selector(popToPrevious))
        navigationItem.title = "자세히보기"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: blackColor, NSAttributedString.Key.font: UIFont.preferredFont(for: .headline, weight: .bold)]
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    @objc private func popToPrevious() {
        navigationController?.popViewController(animated: true)
    }
    
    //TODO: 1. 폰트 사이즈
    //TODO: 2. 과일 종류에 따라서 텍스트 컬러 주기
    //TODO: 3. 정렬
    //TODO: 4. 과일 이미지 따오기
    private func setUI() {
                
        guard let fruitSaleInfo = fruitSaleInfo else { return }
        let fruitType = fruitSaleInfo.fruitName.getFruitType
        let fruitColorName = fruitType.fruitColorName
        guard let fruitColor = UIColor(named: fruitColorName) else { return }
        let fruitImageName = fruitType.fruitImageName
        guard let image = UIImage(named: fruitImageName) else { return }
        guard let blackColor = UIColor(named: Constants.FruitfruitColors.black1) else { return }
        
        fruitOriginLabel.text = "\(fruitSaleInfo.fruitOrigin)에서 태어난"
        fruitOriginLabel.textColor = UIColor(named: Constants.FruitfruitColors.black1)
        fruitOriginLabel.font = UIFont.preferredFont(for: .subheadline, weight: .bold)
        fruitOriginLabel.translatesAutoresizingMaskIntoConstraints = false
        fruitOriginLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 395).isActive = true
        

        fruitNameLabel.text = fruitSaleInfo.fruitName
        fruitNameLabel.font = UIFont.preferredFont(for: .title1, weight: .bold)

        fruitOriginTitlelabel.font = UIFont.preferredFont(for: .footnote, weight: .semibold)
        fruitOriginTitlelabel.textColor = UIColor(named: Constants.FruitfruitColors.orange1)
        
        fruitOriginSublabel.text = fruitSaleInfo.fruitOrigin
        fruitOriginSublabel.font = UIFont.preferredFont(for: .body, weight: .semibold)
        fruitOriginSublabel.textColor = UIColor(named: Constants.FruitfruitColors.black1)
        
        
        shopNameTitlelabel.font = UIFont.preferredFont(for: .footnote, weight: .semibold)
        shopNameTitlelabel.textColor = UIColor(named: Constants.FruitfruitColors.orange1)
        
        shopNameLabel.text = fruitSaleInfo.shopName
        shopNameLabel.numberOfLines = 0
        shopNameLabel.font = UIFont.preferredFont(for: .body, weight: .semibold)
        shopNameLabel.textColor = UIColor(named: Constants.FruitfruitColors.black1)

        priceTitlelabel.font = UIFont.preferredFont(for: .footnote, weight: .semibold)
        priceTitlelabel.textColor = UIColor(named: Constants.FruitfruitColors.orange1)
        
        priceLabel.font = UIFont.preferredFont(for: .body, weight: .semibold)
        priceLabel.textColor = UIColor(named: Constants.FruitfruitColors.black1)
        
        placeHeadLabel.font = UIFont.preferredFont(for: .footnote, weight: .semibold)
        placeHeadLabel.textColor = UIColor(named: Constants.FruitfruitColors.gray0)
        placeLabel.text = fruitSaleInfo.place
        placeLabel.font = UIFont.preferredFont(for: .body, weight: .semibold)
        placeLabel.textColor = UIColor(named: Constants.FruitfruitColors.black1)

        var hour = fruitSaleInfo.time
        
        if hour > 12 {
            hour = hour - 12
            timeLabel.text = "오후 " + String(hour) + "시 "
        } else {
            timeLabel.text = "오전 " + String(hour) + "시 "
        }
        timeHeadLabel.font = UIFont.preferredFont(for: .footnote, weight: .semibold)
        timeHeadLabel.textColor = UIColor(named: Constants.FruitfruitColors.gray0)
        timeLabel.font = UIFont.preferredFont(for: .body, weight: .semibold)
        timeLabel.textColor = UIColor(named: Constants.FruitfruitColors.black1)
        
        fruitImage.image = image
    }
    
    @objc func checkOrderButtonTapped() {
        let BottomSheetVC = BottomSheetViewController()
        BottomSheetVC.modalPresentationStyle = .overFullScreen
        BottomSheetVC.fruitSaleInfo = fruitSaleInfo
        self.present(BottomSheetVC, animated: false, completion: nil)
    }
    
    private func setCheckOrderButtonUI() {
        let gradient = checkOrderButton.applyButtonGradient(colors: Constants.FruitfruitColors.buttonGradient)
        checkOrderButton.layer.insertSublayer(gradient, at: 0)
        checkOrderButton.setTitle("주문하기", for: .normal)
        DispatchQueue.main.async {
            self.checkOrderButton.titleLabel?.font = UIFont.preferredFont(for: .headline, weight: .bold)
        }
        checkOrderButton.layer.cornerRadius = 16
        checkOrderButton.layer.borderWidth = 1
        checkOrderButton.layer.borderColor = UIColor(named: Constants.FruitfruitColors.button1)?.cgColor
    }

}
