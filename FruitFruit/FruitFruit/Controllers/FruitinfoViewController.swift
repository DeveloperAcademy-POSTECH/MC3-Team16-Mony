//
//  FruitinfoViewController.swift
//  FruitFruit
//
//  Created by 유재훈 on 2022/07/20.
//

import UIKit

class FruitinfoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.applyBackgroundGradient()

        // Do any additional setup after loading the view.
    }
    @IBAction func btnDismiss(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
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
