//
//  Date+Extension.swift
//  FruitFruit
//
//  Created by Junyeong Park on 2022/07/20.
//

import UIKit

extension Date {
    var dayString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEEEE"
        formatter.locale = Locale(identifier: "ko_KR")
        let dayString = formatter.string(from: self)
        return dayString + "요일"
    }
    
    var dayComment: NSMutableAttributedString {
        let dayString = self.dayString
        var dayComment: String
        switch dayString {
        case "월요일": dayComment = "싱그러운 월요일 되세요"
        case "화요일": dayComment = "맛있는 화요일 되세요"
        case "수요일": dayComment = "상큼한 수요일 되세요"
        case "목요일": dayComment = "건강한 목요일 되세요"
        case "금요일": dayComment = "달콤한 금요일 되세요"
        case "토요일": dayComment = "배부른 토요일 되세요"
        case "일요일": dayComment = "든든한 일요일 되세요"
        default: dayComment = "싱그러운 \(dayString) 되세요"
        }
        let color = UIColor(named: Constants.FruitfruitColors.orange1) ?? UIColor.orange
        return "푸릇푸릇!\n\(dayComment)".getColoredText("푸릇푸릇!", color)
    }
}
