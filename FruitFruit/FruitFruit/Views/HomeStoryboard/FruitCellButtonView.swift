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
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUI(_ fruitSaleInfo: FruitSaleInfo) {
        setBackground()
        setLabels()
        setLabelText(fruitSaleInfo)
        setFruitButtonImage(fruitSaleInfo.fruitType.fruitSecondary)
    }
    
    private func setBackground() {
        backgroundColor = UIColor(white: 1, alpha: 0.5)
        layer.cornerRadius = 20
        layer.borderWidth = 1
        layer.borderColor = UIColor(red: 0.949, green: 0.957, blue: 0.965, alpha: 1).cgColor
    }
   
    private func setLabels() {
        self.addSubview(fruitShopLabel)
        self.addSubview(fruitNameLabel)
        self.addSubview(fruitPriceLabel)
        self.addSubview(fruitImage)
        fruitShopLabel.font = UIFont.preferredFont(for: .subheadline, weight: .bold)
        fruitShopLabel.textColor = UIColor(named: Constants.FruitfruitColors.black1)
        fruitShopLabel.topAnchor.constraint(equalTo: topAnchor, constant: 24).isActive = true
        fruitShopLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24).isActive = true
        fruitShopLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        fruitNameLabel.font = UIFont.preferredFont(for: .title1, weight: .bold)
        fruitNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 54).isActive = true
        fruitNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24).isActive = true
        fruitNameLabel.heightAnchor.constraint(equalToConstant: 33).isActive = true
        fruitPriceLabel.font = UIFont.preferredFont(for: .subheadline, weight: .bold)
        fruitPriceLabel.textColor = UIColor(named: Constants.FruitfruitColors.black1)
        fruitPriceLabel.topAnchor.constraint(equalTo: topAnchor, constant: 108).isActive = true
        fruitPriceLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24).isActive = true
        fruitPriceLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        fruitImage.topAnchor.constraint(equalTo: topAnchor, constant: 12).isActive = true
        fruitImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 200).isActive = true
        fruitImage.widthAnchor.constraint(equalToConstant: 130).isActive = true
        fruitImage.heightAnchor.constraint(equalToConstant: 130).isActive = true
    }
    

    func setLabelText(_ fruitSaleInfo: FruitSaleInfo) {
        fruitShopLabel.text = fruitSaleInfo.shopName
        fruitNameLabel.text = fruitSaleInfo.fruitName
        fruitNameLabel.textColor = UIColor(named: fruitSaleInfo.fruitType.fruitColorName)!
        fruitPriceLabel.text = "1개 \(fruitSaleInfo.price)원"
    }
    
    func setFruitButtonImage(_ text: String) {
        fruitImage.image = UIImage(named: text)
        fruitImage.frame.size = CGSize(width: 93, height: 100)
    }
}
