//
//  FruitDayCell.swift
//  FruitFruit
//
//  Created by Junyeong Park on 2022/07/26.
//

import UIKit

class FruitDayCell: UICollectionViewCell {
    static let id = "FruitDayCell"
    
    private let day: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let todayMark: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let fruitImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
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
    
    func prepare(model: String?) {
        guard let model = model else { return }
        guard let black1Color = UIColor(named: Constants.FruitfruitColors.black1) else { return }
        guard let black2Color = UIColor(named: Constants.FruitfruitColors.black2) else { return }
        backgroundColor = .clear
        addSubview(day)
        day.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        day.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        day.text = model
//        day.font = UIFont.preferredFont(for: .footnote, weight: .bold)
        if !model.isEmpty {
            let firstLetter = model.first!
            day.textColor = firstLetter.isNumber ? black2Color : black1Color
            day.font = firstLetter.isNumber ? UIFont.systemFont(ofSize: 17, weight: .bold) : UIFont.systemFont(ofSize: 13, weight: .bold)
        }
        //TODO: Font 체크
    }
}
