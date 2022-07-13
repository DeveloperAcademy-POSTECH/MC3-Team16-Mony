//
//  InitSettingViewController.swift
//  FruitFruit
//
//  Created by Junyeong Park on 2022/07/12.
//

import UIKit

class InitSettingViewController: UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func initFinished(_ sender: UIButton) {
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func initSetFinished(_ sender: UIButton) {
        presentMainVC()
    }
    
    private func presentMainVC() {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mainVC = storyboard.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
        let navVC = self.navigationController
        navVC?.pushViewController(mainVC, animated: true)
        // MainView 네비게이션 사용 push
    }
}
