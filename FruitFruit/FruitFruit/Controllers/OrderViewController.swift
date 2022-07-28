//ani
//  OrderViewController.swift
//  FruitFruit
//
//  Created by 유재훈 on 2022/07/19.
//

import UIKit

class OrderViewController: UIViewController {
    var fruitSaleInfo: FruitSaleInfo?
    @IBOutlet weak var fruitOriginLabel: UILabel!
    @IBOutlet weak var fruitNameLabel: UILabel!
    @IBOutlet weak var fruitOriginSublabel: UILabel!
    @IBOutlet weak var shopNameLabel: UILabel!
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet var checkOrderButton: UIButton!
    @IBOutlet var TimeView: UIView!
    @IBOutlet var LocationView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setCheckOrderButtonUI()
        setLocationViewUI()
        setTimeViewUI()
        view.applyBackgroundGradient()
        view.addSubview(LocationView)
        view.addSubview(TimeView)
        view.addSubview(checkOrderButton)
        checkOrderButton.addTarget(self, action: #selector(checkOrderButtonTapped), for: .touchUpInside)
        self.view = view
    }
    
    //TODO: 1. 폰트 사이즈
    //TODO: 2. 텍스트 컬러
    //TODO: 3. 정렬
    //TODO: 4. 네비게이션 바 커스텀하기
    private func setUI() {
        guard let fruitSaleInfo = fruitSaleInfo else { return }
        fruitOriginLabel.text = "\(fruitSaleInfo.fruitOrigin)에서 태어난"
        fruitNameLabel.text = fruitSaleInfo.fruitName
        fruitOriginSublabel.text = fruitSaleInfo.fruitOrigin
        shopNameLabel.text = fruitSaleInfo.shopName
        shopNameLabel.numberOfLines = 0
        placeLabel.text = fruitSaleInfo.place
        var hour = fruitSaleInfo.time
        
        if hour > 12 {
            hour = hour - 12
            timeLabel.text = "오후 " + String(hour) + "시 "
        } else {
            timeLabel.text = "오전 " + String(hour) + "시 "
        }
        
    }
    
    @objc func checkOrderButtonTapped() {
        let BottomSheetVC = BottomSheetViewController()
        BottomSheetVC.modalPresentationStyle = .overFullScreen
        self.present(BottomSheetVC, animated: false, completion: nil)
    }
    

    //checkOrderButton.titleLabel.text = "2400원 3개 구매"

    private func setCheckOrderButtonUI() {
        let gradient = checkOrderButton.applyButtonGradient(colors: Constants.FruitfruitColors.buttonGradient)
        checkOrderButton.layer.insertSublayer(gradient, at: 0)
        checkOrderButton.setTitle("주문하기", for: .normal)
        checkOrderButton.titleLabel?.font = UIFont.preferredFont(for: .headline, weight: .semibold)
        checkOrderButton.layer.cornerRadius = 16
        checkOrderButton.layer.borderWidth = 1
        checkOrderButton.layer.borderColor = UIColor(named: Constants.FruitfruitColors.button1)?.cgColor
    }
    private func setTimeViewUI() {
        TimeView.backgroundColor = .white
        TimeView.layer.shadowOpacity = 1
        TimeView.layer.shadowColor = UIColor(red: 0.917, green: 0.813, blue: 0.737, alpha: 0.3).cgColor
        TimeView.layer.shadowOffset = CGSize(width: 0, height: 0)
        TimeView.layer.shadowRadius = 20
        TimeView.layer.masksToBounds = false
    }
    private func setLocationViewUI() {
        LocationView.backgroundColor = .white
        LocationView.layer.shadowOpacity = 1
        LocationView.layer.shadowColor = UIColor(red: 0.917, green: 0.813, blue: 0.737, alpha: 0.3).cgColor
        LocationView.layer.shadowOffset = CGSize(width: 0, height: 0)
        LocationView.layer.shadowRadius = 20
        LocationView.layer.masksToBounds = false
    }
    
}
