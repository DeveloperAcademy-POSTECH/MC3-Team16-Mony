//
//  InitSettingViewController.swift
//  FruitFruit
//
//  Created by Junyeong Park on 2022/07/13.
//

import UIKit
import FirebaseFirestore
import Firebase

class InitSettingViewController: UIViewController {

    @IBOutlet weak var nameTextField: FruitTextField!
    @IBOutlet weak var nicknameTextField: FruitTextField!
    @IBOutlet weak var initSettingButton: UIButton!
    let db = Firestore.firestore()
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.delegate = self
        nicknameTextField.delegate = self
        initSettingButton.configuration?.background.backgroundColor = UIColor(named: "Fruitfruit_Button")?.withAlphaComponent(0.2)
    }
    
    @IBAction func initSettingFinished(_ sender: UIButton) {
        if let name = nameTextField.text, let nickname = nicknameTextField.text {
            if !name.isEmpty && !nickname.isEmpty {
                let user = User(name: name, nickname: nickname)
                print(user)
                // User 정보 생성
                let data = [Constants.FStore.Users.idField : user.id, Constants.FStore.Users.nameField : user.name, Constants.FStore.Users.nicknameField : user.nickname] as [String : Any]
                db.collection(Constants.FStore.Users.collectionName).document(user.id).setData(data)
                // FireStore 입력
                UserDefaults.standard.set(true, forKey: "isInitSet")
                // UserDefaults 참 설정
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

extension InitSettingViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if nameTextField.isEditing {
            nameTextField.bottomBorder.backgroundColor = UIColor.orange
        } else if nicknameTextField.isEditing {
            nicknameTextField.bottomBorder.backgroundColor = UIColor.orange
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if !nicknameTextField.isEditing {
            nicknameTextField.bottomBorder.backgroundColor = UIColor.gray
        }
        
        if !nameTextField.isEditing {
            nameTextField.bottomBorder.backgroundColor = UIColor.gray
        }
        
        if let name = nameTextField.text, let nickname = nicknameTextField.text {
            if !name.isEmpty && !nickname.isEmpty {
                initSettingButton.configuration?.background.backgroundColor = UIColor(named: "Fruitfruit_Button")
            }
        }
    }
    
    //TODO: FruitTextField 상에서 Protocol 상속 -> Delegate 파악해서 DidSet 효과 주기
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

