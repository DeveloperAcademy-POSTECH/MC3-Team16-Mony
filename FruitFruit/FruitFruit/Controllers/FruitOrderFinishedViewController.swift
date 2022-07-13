//
//  FruitOrderFinishedViewController.swift
//  FruitFruit
//
//  Created by Junyeong Park on 2022/07/13.
//

import UIKit

class FruitOrderFinishedViewController: UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    @IBAction func popToMain(_ sender: UIButton) {
        guard let viewControllerStack = self.navigationController?.viewControllers else { return }
            for viewController in viewControllerStack {
                if let mainView = viewController as? MainViewController {
                    self.navigationController?.popToViewController(mainView, animated: true)
                }
            }
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
