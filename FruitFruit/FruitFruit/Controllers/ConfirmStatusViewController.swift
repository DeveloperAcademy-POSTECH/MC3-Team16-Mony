//
//  ConfirmStatusViewController.swift
//  FruitFruit
//
//  Created by 김유나 on 2022/07/21.
//

import UIKit

class ConfirmStatusViewController: UIViewController {
    
    //TODO: 데이터 바인딩
    var saleInfo = FruitSaleInfo(shopName: "효곡청과", fruitName: "여름오렌지", price: 800, fruitOrigin: "캘리포니아", saleDate: Date(), place: "포스텍 C5", time: 13)
    var orderInfo = FruitOrder(name: "여름오렌지", dueDate: Date(), amount: 3, price: 800, status: "Canceled", user: FruitUser(name: "김유나", nickname: "진저"), place: "포스텍 C5", time: 13)
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var secondaryTitleLabel: UILabel!
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var statusImage: UIImageView!
    
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
        setImage()
        setOrderSheet()
    }
    
}

extension ConfirmStatusViewController {
    
    private func setBackground() {
        backgroundView.applyBackgroundGradient()
    }
    
    private func setLabels() {
        titleLabel.text = FruitStatus(rawValue: orderInfo.status)?.detailTitleLabel
        titleLabel.font = UIFont.preferredFont(for: .title1, weight: .bold)
        titleLabel.textColor = UIColor(named: Constants.FruitfruitColors.black1)
    
        secondaryTitleLabel.text = FruitStatus(rawValue: orderInfo.status)?.detailSecondaryTitleLabel
        secondaryTitleLabel.font = UIFont.preferredFont(for: .subheadline, weight: .bold)
        secondaryTitleLabel.textColor = UIColor(named: Constants.FruitfruitColors.gray1)
    }
    
    private func setImage() {
        statusImage.image = UIImage(named: FruitStatus(rawValue: orderInfo.status)!.getStatusImageName(fruit: orderInfo.name))
        statusImage.frame.size = CGSize(width: 160, height: 160)
    }
    
    private func setOrderSheet() {
        view.addSubview(orderSheet)
        orderSheet.prepare(saleInfo: saleInfo, orderInfo: orderInfo)

        orderSheet.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24).isActive = true
        orderSheet.topAnchor.constraint(equalTo: view.topAnchor, constant: 310).isActive = true
        orderSheet.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 48).isActive = true
        orderSheet.heightAnchor.constraint(equalToConstant: 370).isActive = true
        
        orderSheet.account.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapAccountRow))
        orderSheet.account.addGestureRecognizer(tapGesture)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @objc func tapAccountRow() {
        UIPasteboard.general.string = "카카오뱅크 303-22-201058 이정환"
        if let myString = UIPasteboard.general.string {
            print(myString)
        }
    }
    
}
