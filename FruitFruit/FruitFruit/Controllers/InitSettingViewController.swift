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
    // MARK: - PROPERTIES
    @IBOutlet weak var addNameLabel: UILabel!
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var nameTextField: FruitTextField!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nicknameTextField: FruitTextField!
    @IBOutlet weak var initSettingButton: UIButton!
    let db = Firestore.firestore()

    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.delegate = self
        nicknameTextField.delegate = self
        setUI()
    }
    
    // MARK: - FUNCTIONS
    
    func setUI() {
        welcomeLabel.font = UIFont.preferredFont(for: .subheadline, weight: .semibold)
        welcomeLabel.textColor = UIColor(named: Constants.FruitfruitColors.gray1)
        addNameLabel.font = UIFont.preferredFont(for: .title1, weight: .bold)
        addNameLabel.textColor = UIColor(named: Constants.FruitfruitColors.black)
        nameTextField.font = UIFont.preferredFont(for: .title3, weight: .regular)
        nameTextField.textColor = UIColor(named: Constants.FruitfruitColors.black)
        nameTextField.tintColor = UIColor(named: Constants.FruitfruitColors.orange1)
        nameTextField.attributedPlaceholder = NSAttributedString(string: "이름", attributes: [NSAttributedString.Key.foregroundColor : UIColor(named: Constants.FruitfruitColors.gray1)!])
        nameTextField.autocorrectionType = .no
        nicknameTextField.font = UIFont.preferredFont(for: .title3, weight: .regular)
        nicknameTextField.textColor = UIColor(named: Constants.FruitfruitColors.black)
        nicknameTextField.tintColor = UIColor(named: Constants.FruitfruitColors.orange1)
        nicknameTextField.attributedPlaceholder = NSAttributedString(string: "닉네임", attributes: [NSAttributedString.Key.foregroundColor : UIColor(named: Constants.FruitfruitColors.gray1)!])
        nicknameTextField.autocorrectionType = .no
        nameLabel.font = UIFont.preferredFont(for: .footnote, weight: .regular)
        nameLabel.textColor = UIColor(named: Constants.FruitfruitColors.gray1)
        initSettingButton.configuration?.background.backgroundColor = UIColor(named: Constants.FruitfruitColors.button2)
        initSettingButton.titleLabel?.font = UIFont.preferredFont(for: .headline, weight: .bold)
        // 텍스트 폰트, 색깔 설정
        nicknameTextField.isHidden = true
        nameLabel.isHidden = true
        buttonColorCheck()
    }
    
    @IBAction func initSettingFinished(_ sender: UIButton) {
        if let name = nameTextField.text, let nickname = nicknameTextField.text {
            if !name.isEmpty && !nickname.isEmpty {
                let user = FruitUser(name: name, nickname: nickname)
                // User 정보 생성
                let data = [Constants.FStore.Users.idField : user.id, Constants.FStore.Users.nameField : user.name, Constants.FStore.Users.nicknameField : user.nickname] as [String : Any]
                db.collection(Constants.FStore.Users.collectionName).document(user.id).setData(data)
                // FireStore 입력
                UserDefaults.standard.set(true, forKey: "isInitSet")
                // UserDefaults true 설정
            }
        }
    }
    
    func nicknameHiddenToggle() {
        if nicknameTextField.isHidden {
            nicknameTextField.isHidden = false
            nameLabel.isHidden = false
        } else {
            nicknameTextField.isHidden = true
            nameLabel.isHidden = true
        }
    }

    func nameTextFieldSet(_ initialSet: Bool) {
        let topPadding: CGFloat = initialSet ? 325 : 232
        for constraint in self.view.constraints {
            if constraint.identifier == "nameTextFieldTop" {
               constraint.constant = topPadding
            }
        }
        // 이름 텍스트 필드 위치 조정

        if !initialSet {
            UIView.animate(withDuration: 0.8, delay: 0.0, options: .curveEaseInOut, animations: {
                self.view.layoutIfNeeded()
            }, completion: { _ in
                UIView.animate(withDuration: 0.1, delay: 0.0, options: .transitionCrossDissolve , animations: {
                    self.nameLabel.alpha = 0
                    self.nicknameTextField.alpha = 0
                })
            })
            nicknameHiddenToggle()
        } else {
            nicknameHiddenToggle()
            self.nameLabel.alpha = 0
            self.nicknameTextField.alpha = 0
            UIView.animate(withDuration: 0.8, delay: 0.0, options: .curveEaseInOut, animations: {
                self.view.layoutIfNeeded()
            }, completion: { _ in
                UIView.animate(withDuration: 0.1, delay: 0.0, options: .transitionCrossDissolve, animations: {
                    self.nameLabel.alpha = 1
                    self.nicknameTextField.alpha = 1
                }, completion: nil)
            })
        }
        
        UIView.animate(withDuration: 0.8, delay: 0.0, options: .curveEaseIn, animations: {
            self.welcomeLabel.text = !initialSet ? "어서와요 푸릇푸릇입니다" : "애플아카데미개발자 러너인가요?"
            self.addNameLabel.text = !initialSet ? "이름을 입력해주세요" : "닉네임을 입력해주세요"
        }, completion: nil)
        // 이름/닉네임 입력 상황 -> 텍스트 변경
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
    
    func buttonColorCheck() {
        if let name = nameTextField.text, let nickname = nicknameTextField.text {
            if !name.isEmpty && !nickname.isEmpty {
                if initSettingButton.layer.sublayers!.count == 2 {
                    let graident = initSettingButton.applyButtonGradient(colors: Constants.FruitfruitColors.buttonGradient)
                    UIView.animate(withDuration: 4.0, delay: 0, options: .transitionCrossDissolve, animations: {
                        self.initSettingButton.layer.insertSublayer(graident, at: 0)
                        self.initSettingButton.configuration?.background.backgroundColor = UIColor.clear
                        self.initSettingButton.titleLabel?.font = UIFont.preferredFont(for: .headline, weight: .bold)
                    }, completion: nil)
                }
            } else {
                if initSettingButton.layer.sublayers!.count == 3 {
                    initSettingButton.layer.sublayers?.removeFirst()
                    initSettingButton.configuration?.background.backgroundColor = UIColor(named: Constants.FruitfruitColors.button2)
                    initSettingButton.titleLabel?.font = UIFont.preferredFont(for: .headline, weight: .bold)

                }
            }
        }
    }
}

// MARK: - EXTENSIONS

extension InitSettingViewController: UITextFieldDelegate {

    func textFieldDidBeginEditing(_ textField: UITextField) {
        if nameTextField.isEditing {
            nameTextField.backgroundSet(true)
            nameTextField.heightSet(true)
        } else if nicknameTextField.isEditing {
            nicknameTextField.backgroundSet(true)
            nicknameTextField.heightSet(true)
        }
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        if !nicknameTextField.isEditing {
            nicknameTextField.backgroundSet(false)
            nameTextField.heightSet(false)
        }

        if !nameTextField.isEditing {
            nameTextField.backgroundSet(false)
            nicknameTextField.heightSet(false)
        }
        //TODO: 텍스트 필드 체크 -> 공백 체크 / 한글, 영어만 가능
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        buttonColorCheck()
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

