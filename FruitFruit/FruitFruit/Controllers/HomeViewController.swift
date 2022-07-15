//
//  HomeViewController.swift
//  FruitFruit
//
//  Created by Junyeong Park on 2022/07/15.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var homeTitleLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.applyBackgroundGradient()
        setHomeViewUI()
    }
    
    private func setHomeViewUI() {
        homeTitleLabel.font = UIFont.preferredFont(for: .title1, weight: .bold)
    }
}
