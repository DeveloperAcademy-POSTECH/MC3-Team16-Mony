//
//  InitSettingViewController.swift
//  FruitFruit
//
//  Created by Junyeong Park on 2022/07/13.
//

import UIKit

class InitSettingViewController: UIViewController {

    @IBOutlet weak var nameTextField: FruitTextField!
    @IBOutlet weak var nicknameTextField: FruitTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.delegate = self
        nicknameTextField.delegate = self

        // Do any additional setup after loading the view.
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

extension InitSettingViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

