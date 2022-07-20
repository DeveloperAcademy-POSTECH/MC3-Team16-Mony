//
//  ConfirmStatusViewController.swift
//  FruitFruit
//
//  Created by 김유나 on 2022/07/21.
//

import UIKit

class ConfirmStatusViewController: UIViewController {
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var secondaryTitleLabel: UILabel!
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    let orderSheet: OrderSheet = {
        let orderSheet = OrderSheet(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 48, height: 370))
        orderSheet.translatesAutoresizingMaskIntoConstraints = false
        return orderSheet
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        navigationBar.shadowImage = UIImage()
    }
    
    private func setUI() {
        setBackground()
        setLabels()
        view.addSubview(orderSheet)
        orderSheet.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24).isActive = true
        orderSheet.topAnchor.constraint(equalTo: view.topAnchor, constant: 310).isActive = true
    }
    
    private func setBackground() {
        backgroundView.applyBackgroundGradient()
    }
    
    private func setLabels() {
        titleLabel.text = "입금을\n확인 중이에요!"
        titleLabel.font = UIFont.preferredFont(for: .title1, weight: .bold)
        titleLabel.textColor = UIColor(named: Constants.FruitfruitColors.black)
        
        secondaryTitleLabel.text = "오늘 오후 6시까지 입금이 확인되지 않으면\n주문이 자동으로 취소됩니다."
        secondaryTitleLabel.font = UIFont.preferredFont(for: .subheadline, weight: .bold)
        secondaryTitleLabel.textColor = UIColor(named: Constants.FruitfruitColors.gray1)
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
