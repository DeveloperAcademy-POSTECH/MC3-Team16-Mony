//
//  FruitStatus.swift
//  FruitFruit
//
//  Created by Junyeong Park on 2022/07/19.
//

import UIKit

enum FruitStatus: String {
    case Checking = "Checking"
    case Checked = "Checked"
    case Canceled = "Canceled"
    case Arriving = "Arriving"
    case Arrived = "Arrived"
    
    func homeTitleText(fruit: String, time: Int, place: String) -> NSAttributedString  {
        let color = UIColor(named: Constants.FruitfruitColors.orange1)!
        // TODO: 과일 종류 따라서 나중에 색깔 변경할 수 있음
        switch self {
        case .Checking:
            return "맛있는 \(fruit)가\n기다리고 있어요.".getColoredText(fruit, color)
        case .Checked:
            return "맛있는 \(fruit)와\n내일 오전 11시 찾아뵐게요!".getColoredText(fruit, color)
        case .Canceled:
            return "푸릇푸릇!\n상큼한 수요일 되세요".getColoredText("푸릇푸릇!", color)
        case .Arriving:
            return "맛있는 \(fruit)가\nC5로 오고있어요".getColoredText(fruit, color)
        case .Arrived:
            return "맛있는 \(fruit)가\nC5에 도착했어요".getColoredText(fruit, color)
        default:
            return "푸릇푸릇!\n상큼한 수요일 되세요".getColoredText("푸릇푸릇!", color)
        }
    }
    
    var statusLabel: String {
        switch self {
        case .Checking:
            return "입금을 확인 중이예요"
        case .Checked, .Arrived, .Arriving:
            return "입금이 확인되었어요"
        case .Canceled:
            return "주문이 취소되었어요"
        }
    }
    
    func statusImageName(fruit: String) -> String {
        switch self {
        case .Checking:
            return "Fruitfruit_Status_\(fruit)_Checking.pdf"
        case .Checked:
            return "Fruitfruit_Status_\(fruit)_Checked.pdf"
        case .Canceled:
            return "Fruitfruit_Status_\(fruit)_Checking.pdf"
        case .Arriving:
            return "Fruitfruit_Status_\(fruit)_Arriving.pdf"
        case .Arrived:
            return "Fruitfruit_Status_\(fruit)_Arrived.pdf"
        }
    }
    
    var detailTitleLabel: String {
        switch self {
        case .Checking:
            return "입금을\n확인 중이에요!"
        case .Checked, .Arriving, .Arrived:
            return "입금이\n확인 되었어요!"
        case .Canceled:
            return "주문이 자동으로\n취소 되었어요 :("
        }
    }
    
    var detailSecondaryTitleLabel: String {
        switch self {
        case .Checking:
            return "오늘 오후 6시까지 입금되지 않으면\n주문이 자동으로 취소됩니다"
        case .Canceled:
            return "6시까지 입금되지 않았어요\n문의사항이 있으시다면 디너를 찾아주세요"
        case .Checked:
            return "내일 오후 1시 C5 앞에 배달됩니다"
        case .Arriving:
            return "오늘 오후 1시 C5 앞에 배달됩니다"
        case .Arrived:
            return "배달이 완료 되었어요"
        }
    }
}
