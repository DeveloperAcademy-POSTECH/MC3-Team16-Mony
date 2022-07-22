//
//  FruitStatusCell.swift
//  FruitFruit
//
//  Created by Junyeong Park on 2022/07/22.
//

import UIKit

class FruitStatusCell: UITableViewCell {
    static let identifier = "FruitStatusCell"
    
    var fruitStatusImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        return image
    }()
    
    var fruitStatusLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented.")
    }
    
    private func setUI(model: FruitOrder) {
        backgroundColor = .clear
        layer.backgroundColor = UIColor(named: Constants.FruitfruitColors.gray3)?.cgColor
        layer.cornerRadius = 20
        insertSubview(fruitStatusLabel, at: 0)
        insertSubview(fruitStatusImage, at: 0)
        let imageName = model.statusEnum.getStatusImageName(fruit: model.name)
        let image = UIImage(named: imageName)
        fruitStatusImage.image = image
        fruitStatusImage.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
        fruitStatusImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        fruitStatusLabel.font = UIFont.preferredFont(for: .subheadline, weight: .bold)
        fruitStatusLabel.textColor = UIColor(named: Constants.FruitfruitColors.black2)
        fruitStatusLabel.topAnchor.constraint(equalTo: topAnchor, constant: 24).isActive = true
        fruitStatusLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24).isActive = true
    }
}
