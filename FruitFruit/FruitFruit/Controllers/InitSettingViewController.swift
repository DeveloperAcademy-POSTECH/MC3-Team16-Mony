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

    @IBOutlet weak var smallNameLabel: UILabel!
    @IBOutlet weak var addNameLabel: UILabel!
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var nameTextField: FruitTextField!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nicknameTextField: FruitTextField!
    @IBOutlet weak var initSettingButton: UIButton!
    let db = Firestore.firestore()
    override func viewDidLoad() {
        super.viewDidLoad()
        welcomeLabel.font = UIFont.preferredFont(for: .subheadline, weight: .semibold)
        welcomeLabel.textColor = UIColor(named: Constants.FruitfruitColors.gray1)
        addNameLabel.font = UIFont.preferredFont(for: .title1, weight: .bold)
        addNameLabel.textColor = UIColor(named: Constants.FruitfruitColors.black)
        nameTextField.font = UIFont.preferredFont(for: .title3, weight: .regular)
        nameTextField.textColor = UIColor(named: Constants.FruitfruitColors.black)
        nameTextField.tintColor = UIColor(named: Constants.FruitfruitColors.orange1)
        nameTextField.attributedPlaceholder = NSAttributedString(string: "이름", attributes: [NSAttributedString.Key.foregroundColor : UIColor(named: Constants.FruitfruitColors.gray1)!])
        nameTextField.delegate = self
        nicknameTextField.font = UIFont.preferredFont(for: .title3, weight: .regular)
        nicknameTextField.textColor = UIColor(named: Constants.FruitfruitColors.black)
        nicknameTextField.tintColor = UIColor(named: Constants.FruitfruitColors.orange1)
        nicknameTextField.attributedPlaceholder = NSAttributedString(string: "닉네임", attributes: [NSAttributedString.Key.foregroundColor : UIColor(named: Constants.FruitfruitColors.gray1)!])
        smallNameLabel.font = UIFont.preferredFont(for: .footnote, weight: .regular)
        smallNameLabel.textColor = UIColor(named: Constants.FruitfruitColors.gray1)

        nicknameTextField.delegate = self
        initSettingButton.configuration?.background.backgroundColor = UIColor(named: Constants.FruitfruitColors.button2)
        initSettingButton.titleLabel?.font = UIFont.preferredFont(for: .headline, weight: .semibold)
        nicknameTextField.isHidden = true
        nameLabel.isHidden = true
    }
    
    @IBAction func initSettingFinished(_ sender: UIButton) {
        if let name = nameTextField.text, let nickname = nicknameTextField.text {
            if !name.isEmpty && !nickname.isEmpty {
                let user = User(name: name, nickname: nickname)
                // User 정보 생성
                let data = [Constants.FStore.Users.idField : user.id, Constants.FStore.Users.nameField : user.name, Constants.FStore.Users.nicknameField : user.nickname] as [String : Any]
                db.collection(Constants.FStore.Users.collectionName).document(user.id).setData(data)
                // FireStore 입력
                UserDefaults.standard.set(true, forKey: "isInitSet")
                // UserDefaults true 설정
            }
        }
    }

    func nameTextFieldSet(_ initialSet: Bool) {
        let topPadding: CGFloat = initialSet ? 325 : 232
        for constraint in self.view.constraints {
            if constraint.identifier == "nameTextFieldTop" {
               constraint.constant = topPadding
            }
        }
        
        if !initialSet {
            UIView.animate(withDuration: 0.8, animations: {
                self.nameLabel.isHidden = true
                self.nicknameTextField.isHidden = true
            }, completion: { _ in
                UIView.animate(withDuration: 0.8, animations: {
                    self.view.layoutIfNeeded()
                }, completion: nil)
            })
        } else {
            UIView.animate(withDuration: 0.8, animations: {
                self.view.layoutIfNeeded()
            }, completion: { _ in
                UIView.animate(withDuration: 0.8, animations: {
                    self.nameLabel.isHidden = false
                    self.nicknameTextField.isHidden = false
                }, completion: nil)
            })
            
        }
    }
    
    func textFieldVisibilityCheck() {
        if let name = nameTextField.text {
            if name != "" && nicknameTextField.isHidden {
                nameTextFieldSet(true)
            } else if name == "" {
                if !nicknameTextField.isHidden {
                    if let nickname = nicknameTextField.text {
                        if nickname == "" {
                            nameTextFieldSet(false)
                        }
                    }
                }
            }
        }
    }
}

extension InitSettingViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if nameTextField.isEditing {
            nameTextField.bottomBorder.backgroundColor = UIColor(named: Constants.FruitfruitColors.orange1)
            nameTextField.heightSet(true)
        } else if nicknameTextField.isEditing {
            nicknameTextField.bottomBorder.backgroundColor = UIColor(named: Constants.FruitfruitColors.orange1)
            nicknameTextField.heightSet(true)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if !nicknameTextField.isEditing {
            nicknameTextField.bottomBorder.backgroundColor = UIColor(named: Constants.FruitfruitColors.gray2)
            nameTextField.heightSet(false)
        }
        
        if !nameTextField.isEditing {
            nameTextField.bottomBorder.backgroundColor = UIColor(named: Constants.FruitfruitColors.gray2)
            nicknameTextField.heightSet(false)
        }
        
        if let name = nameTextField.text, let nickname = nicknameTextField.text {
            if !name.isEmpty && !nickname.isEmpty {
                initSettingButton.configuration?.background.backgroundColor = UIColor(named: Constants.FruitfruitColors.button1)
                initSettingButton.titleLabel?.font = UIFont.preferredFont(for: .headline, weight: .semibold)
            } else {
                initSettingButton.configuration?.background.backgroundColor = UIColor(named: Constants.FruitfruitColors.button2)
                initSettingButton.titleLabel?.font = UIFont.preferredFont(for: .headline, weight: .semibold)
            }
        } else {
            initSettingButton.configuration?.background.backgroundColor = UIColor(named: Constants.FruitfruitColors.button2)
            initSettingButton.titleLabel?.font = UIFont.preferredFont(for: .headline, weight: .semibold)
        }
    }
    
    //TODO: FruitTextField 상에서 Protocol 상속 -> Delegate 파악해서 DidSet 효과 주기
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        textFieldVisibilityCheck()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        textFieldVisibilityCheck()
    }
}

