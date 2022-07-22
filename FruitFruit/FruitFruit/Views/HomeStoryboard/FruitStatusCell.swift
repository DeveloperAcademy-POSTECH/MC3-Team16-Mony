//
//  FruitStatusCell.swift
//  FruitFruit
//
//  Created by Junyeong Park on 2022/07/22.
//

import UIKit

class FruitStatusCell: UICollectionViewCell {
    static let id = "FruitStatusCell"
    
    private let fruitStatusImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let fruitStatusLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.prepare(model: nil)
    }
    
    func prepare(model: FruitOrder?) {
        guard let model = model else { return }
        backgroundColor = .clear
        layer.backgroundColor = UIColor(named: Constants.FruitfruitColors.gray3)?.cgColor
        layer.cornerRadius = 20
        let _ = self.subviews.map { $0.removeFromSuperview() }
        addSubview(fruitStatusLabel)
        addSubview(fruitStatusImage)
        let imageName = FruitName(rawValue: model.name)!.fruitSecondary
        let image = UIImage(named: imageName)
        fruitStatusImage.image = image
        fruitStatusImage.topAnchor.constraint(equalTo: topAnchor, constant: 19).isActive = true
        fruitStatusImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        fruitStatusImage.widthAnchor.constraint(equalToConstant: 30).isActive = true
        fruitStatusImage.heightAnchor.constraint(equalToConstant: 30).isActive = true
        fruitStatusLabel.font = UIFont.preferredFont(for: .subheadline, weight: .bold)
        fruitStatusLabel.text = FruitStatus(rawValue: model.status)?.statusLabel
        fruitStatusLabel.textColor = UIColor(named: Constants.FruitfruitColors.black2)
        fruitStatusLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 54).isActive = true
        fruitStatusLabel.topAnchor.constraint(equalTo: topAnchor, constant: 24).isActive = true
    }
}
