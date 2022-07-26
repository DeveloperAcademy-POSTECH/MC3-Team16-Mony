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
    
    private func setUI() {
        welcomeLabel.font = UIFont.preferredFont(for: .subheadline, weight: .semibold)
        welcomeLabel.textColor = UIColor(named: Constants.FruitfruitColors.gray1)
        addNameLabel.font = UIFont.preferredFont(for: .title1, weight: .bold)
        addNameLabel.textColor = UIColor(named: Constants.FruitfruitColors.black1)
        nameTextField.font = UIFont.preferredFont(for: .title3, weight: .regular)
        nameTextField.textColor = UIColor(named: Constants.FruitfruitColors.black1)
        nameTextField.tintColor = UIColor(named: Constants.FruitfruitColors.orange1)
        nameTextField.attributedPlaceholder = NSAttributedString(string: "이름", attributes: [NSAttributedString.Key.foregroundColor : UIColor(named: Constants.FruitfruitColors.gray1)!])
        nameTextField.autocorrectionType = .no
        nicknameTextField.font = UIFont.preferredFont(for: .title3, weight: .regular)
        nicknameTextField.textColor = UIColor(named: Constants.FruitfruitColors.black1)
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
        guard let name = nameTextField.text, let nickname = nicknameTextField.text else { return }
        if !name.isEmpty && !nickname.isEmpty {
            let userId = UUID().uuidString
            let user = FruitUser(id: userId, name: name, nickname: nickname)
            // User 정보 생성
            let data = [Constants.FStore.Users.idField : user.id, Constants.FStore.Users.nameField : user.name, Constants.FStore.Users.nicknameField : user.nickname] as [String : Any]
            db.collection(Constants.FStore.Users.collectionName).document(user.id).setData(data)
            // FireStore 입력
            Storage().setFruitUser(fruitUser: user)
            // UserDefaults true 설정
            goToHome()
            // HomeView 이동
        }
    }
    
    private func nicknameHiddenToggle() {
        if nicknameTextField.isHidden {
            nicknameTextField.isHidden = false
            nameLabel.isHidden = false
        } else {
            nicknameTextField.isHidden = true
            nameLabel.isHidden = true
        }
    }

    private func nameTextFieldSet(_ initialSet: Bool) {
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
            self.welcomeLabel.text = !initialSet ? "푸릇푸릇 첫 번째 구매를 위해" : "애플아카데미개발자 러너인가요?"
            self.addNameLabel.text = !initialSet ? "이름을 입력해주세요" : "닉네임을 입력해주세요"
        }, completion: nil)
        // 이름/닉네임 입력 상황 -> 텍스트 변경
    }
    
    private func textFieldVisibilityCheck() {
        guard let name = nameTextField.text else { return }
        if !name.isEmpty && nicknameTextField.isHidden {
            nameTextFieldSet(true)
        } else if name.isEmpty && !nicknameTextField.isHidden {
            guard let nickname = nicknameTextField.text else { return }
            if !nickname.isEmpty {
                nameTextFieldSet(false)
            }
        }
    }
    
    func buttonColorCheck() {
        guard let name = nameTextField.text, let nickname = nicknameTextField.text else { return }
        if !name.isEmpty && !nickname.isEmpty {
            if !name.isEmpty && !nickname.isEmpty {
                let limitedCnt = 2
                if initSettingButton.layer.sublayers!.count == limitedCnt {
                    let gradient = initSettingButton.applyButtonGradient(colors: Constants.FruitfruitColors.buttonGradient)
                    UIView.animate(withDuration: 4.0, delay: 0, options: .transitionCrossDissolve, animations: {
                        self.initSettingButton.layer.insertSublayer(gradient, at: 0)
                    }, completion: nil)
                }
            } else {
                let limitedCnt = 3
                if initSettingButton.layer.sublayers!.count == limitedCnt {
                    initSettingButton.layer.sublayers?.removeFirst()
                }
            }
        }
        DispatchQueue.main.async {
            self.initSettingButton.titleLabel?.font = UIFont.preferredFont(for: .headline, weight: .bold)
        }
    }
    
    private func goToHome() {
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        let homeVC = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        let initVC = self.navigationController
        initVC?.pushViewController(homeVC, animated: true)
        initVC?.isNavigationBarHidden = true
        // 현재 네비게이션 컨트롤러 -> 홈뷰 푸쉬로 띄우기
    }
}

// MARK: - EXTENSIONS

extension InitSettingViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        guard let fruitTextField = textField as? FruitTextField else { return }
        fruitTextField.backgroundSet(true)
        fruitTextField.heightSet(true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let fruitTextField = textField as? FruitTextField else { return }
        fruitTextField.backgroundSet(false)
        fruitTextField.heightSet(false)
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

