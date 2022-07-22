//
//  Constants.swift
//  FruitFruit
//
//  Created by Junyeong Park on 2022/07/13.
//

import UIKit

struct Constants {
    static let appName = "FruitFruit"
    struct FStore {
        struct Users {
            static let collectionName = "Users"
            static let idField = "id"
            static let nameField = "name"
            static let nicknameField = "nickname"
        }
        struct Orders {
            static let collectionName =  "Orders"
            static let orderField = "dueDate"
        }
        struct SaleInfos {
            static let collectionName = "SaleInfos"
            static let orderField = "saleDate"
        }
    }
    struct FruitfruitColors {
        static let button1 = "Fruitfruit_Button1"
        static let button2 = "Fruitfruit_Button2"
        static let black1 = "Fruitfruit_Black1"
        static let black2 = "Fruitfruit_Black2"
        static let gray1 = "Fruitfruit_Gray1"
        static let gray2 = "Fruitfruit_Gray2"
        static let gray3 = "Fruitfruit_Gray3"
        static let orange1 = "Fruitfruit_Orange1"
        static let orange2 = "Fruitfruit_Orange2"
        static let buttonGradient = [
            UIColor(red: 0.992, green: 0.533, blue: 0.157, alpha: 1),
            UIColor(red: 1, green: 0.6, blue: 0, alpha: 1)
          ]
        static let backgroundGradient = [
            UIColor(red: 1, green: 0.89, blue: 0.784, alpha: 1),
            UIColor(red: 1, green: 1, blue: 1, alpha: 0)
          ]
    }
    struct FruitfruitImages {
        struct Fruits {
            static let orangeSecondary = "Fruitfruit_Orange_Secondary.pdf"
            static let peachSecondary = "Fruitfruit_Peach_Secondary.pdf"
        }
        struct Status {
            static let arrived = "Fruitfruit_Status_Arrived.pdf"
            static let checking = "Fruitfruit_Status_Chekcking_pdf"
            static let checked = "Fruitfruit_Status_Checked.pdf"
            static let canceled = "Fruitfruit_Status_Canceled.pdf"
        }
        static let profile = "Fruitfruit_Profile.pdf"
    }
}
