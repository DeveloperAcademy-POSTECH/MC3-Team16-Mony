//
//  HomeViewController.swift
//  FruitFruit
//
//  Created by Junyeong Park on 2022/07/15.
//

import UIKit

class HomeViewController: UIViewController {
    // MARK: - PROPERTIES
    let fruitStautsLabel: FruitStatusLabel = {
        let statusLabel = FruitStatusLabel(frame: CGRect(x: 0, y: 0, width: 342, height: 68))
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        return statusLabel
    }()
    
    @IBOutlet weak var homeTitleLabel: UILabel!

    
    // MARK: - LIFECYCLES

    override func viewDidLoad() {
        super.viewDidLoad()
        view.applyBackgroundGradient()
        setHomeViewUI()
        setFruitStatusLabel()
    }
    
    // MARK: - FUNCTIONS
    
    private func setHomeViewUI() {
        homeTitleLabel.font = UIFont.preferredFont(for: .title1, weight: .bold)
    }
    
    private func setFruitStatusLabel() {
        view.addSubview(fruitStautsLabel)
        fruitStautsLabel.widthAnchor.constraint(equalToConstant: view.bounds.width - 48).isActive = true
        fruitStautsLabel.heightAnchor.constraint(equalToConstant: 68).isActive = true
        fruitStautsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24).isActive = true
        fruitStautsLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 217).isActive = true
    }
}


