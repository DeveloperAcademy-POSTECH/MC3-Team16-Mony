//
//  OrderResultViewController.swift
//  FruitFruit
//
//  Created by 김유나 on 2022/07/19.
//

import UIKit

class OrderResultViewController: UIViewController {

    @IBOutlet weak var navigationTitleLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var secondaryTitleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationTitleLabel.text = "주문 완료"
        navigationTitleLabel.textColor = UIColor(named: Constants.FruitfruitColors.black)
        navigationTitleLabel.font = UIFont.preferredFont(for: .headline, weight: .semibold)
        
        titleLabel.text = "주문이\n완료되었습니다"
        titleLabel.numberOfLines = 0
        titleLabel.textColor = UIColor(named: Constants.FruitfruitColors.black)
        titleLabel.font = UIFont.preferredFont(for: .title1, weight: .bold)
        
        secondaryTitleLabel.text = "아래 계좌로 입금해주세요"
        secondaryTitleLabel.textColor = UIColor(named: Constants.FruitfruitColors.gray1)
        secondaryTitleLabel.font = UIFont.preferredFont(for: .headline, weight: .bold)
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
