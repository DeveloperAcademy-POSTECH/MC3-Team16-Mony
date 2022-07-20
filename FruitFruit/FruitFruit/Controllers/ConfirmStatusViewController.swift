//
//  ConfirmStatusViewController.swift
//  FruitFruit
//
//  Created by 김유나 on 2022/07/21.
//

import UIKit

class ConfirmStatusViewController: UIViewController {
    
    @IBOutlet weak var backgroundView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        // Do any additional setup after loading the view.
    }
    
    private func setUI() {
        setBackground()
    }
    
    private func setBackground() {
        backgroundView.applyBackgroundGradient()
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
