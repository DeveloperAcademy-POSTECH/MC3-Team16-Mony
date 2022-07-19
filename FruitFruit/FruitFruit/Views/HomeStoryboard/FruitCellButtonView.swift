//
//  FruitCellButtonView.swift
//  FruitFruit
//
//  Created by Junyeong Park on 2022/07/16.
//

import UIKit

class FruitCellButtonView: UIView {
    //TODO: 과일 이미지 -> Asset / Firebase Server 사용 
    var fruitShopLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var fruitNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var fruitPriceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var fruitImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        setBackground()
        setLabels()
        setLabelText()
        setFruitButtonImage(Constants.FruitfruitImages.Fruits.orangeSecondary)
        //TODO: setLabelText -> UI 확인용 함수. 이후 데이터 모델 입력되었을 때 뷰 뜨도록 구현
    }
    
    private func setBackground() {
        self.backgroundColor = .clear
        self.layer.backgroundColor = UIColor(red: 0.98, green: 0.98, blue: 0.98, alpha: 1).cgColor
        self.layer.cornerRadius = 20
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor(red: 0.949, green: 0.957, blue: 0.965, alpha: 1).cgColor
    }
   
    private func setLabels() {
        self.addSubview(fruitShopLabel)
        self.addSubview(fruitNameLabel)
        self.addSubview(fruitPriceLabel)
        self.addSubview(fruitImage)
        fruitShopLabel.font = UIFont.preferredFont(for: .subheadline, weight: .bold)
        fruitShopLabel.textColor = UIColor(named: Constants.FruitfruitColors.black)
        fruitShopLabel.topAnchor.constraint(equalTo: topAnchor, constant: 24).isActive = true
        fruitShopLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24).isActive = true
        fruitShopLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        fruitNameLabel.font = UIFont.preferredFont(for: .title1, weight: .bold)
        fruitNameLabel.textColor = UIColor(named: Constants.FruitfruitColors.orange1)
        fruitNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 54).isActive = true
        fruitNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24).isActive = true
        fruitNameLabel.heightAnchor.constraint(equalToConstant: 33).isActive = true
        fruitPriceLabel.font = UIFont.preferredFont(for: .subheadline, weight: .bold)
        fruitPriceLabel.textColor = UIColor(named: Constants.FruitfruitColors.black)
        fruitPriceLabel.topAnchor.constraint(equalTo: topAnchor, constant: 108).isActive = true
        fruitPriceLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24).isActive = true
        fruitPriceLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        fruitImage.topAnchor.constraint(equalTo: topAnchor, constant: 12).isActive = true
        fruitImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 200).isActive = true
        fruitImage.widthAnchor.constraint(equalToConstant: 130).isActive = true
        fruitImage.heightAnchor.constraint(equalToConstant: 130).isActive = true
        //TODO: 130X130 사이즈 맞춰서 SVG 패딩 값 고정!

    }
    
    func setLabelText() {
        fruitShopLabel.text = "효곡청과"
        fruitNameLabel.text = "여름오렌지"
        fruitPriceLabel.text = "1개 800원"
    }
    // 초기화용 함수 -> 추후 삭제하기
    //TODO: FruitCellButtom 정보 데이터 모델 자체를 입력받고 한 번에 표현하기 -> 현재를 각 라벨별 정보를 여러 개 받고 있다.
    
    func setLabelText(_ fruitShop: String, _ fruitName: String, _ fruitPrice: String) {
        fruitShopLabel.text = fruitShop
        fruitNameLabel.text = fruitName
        fruitPriceLabel.attributedText = "1개 \(fruitPrice)".getColoredText("1개", UIColor(named: Constants.FruitfruitColors.gray1)!)
    }
    
    func setFruitButtonImage(_ text: String) {
        fruitImage.image = UIImage(named: text)
        fruitImage.frame.size = CGSize(width: 93, height: 100)
    }
}