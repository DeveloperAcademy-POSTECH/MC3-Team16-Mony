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
        return dayString
    }
    
    var dayComment: NSMutableAttributedString {
        let dayString = self.dayString
        var dayComment: String
        switch dayString {
        case "월": dayComment = "싱그러운 월요일 되세요"
        case "화": dayComment = "맛있는 화요일 되세요"
        case "수": dayComment = "상큼한 수요일 되세요"
        case "목": dayComment = "건강한 목요일 되세요"
        case "금": dayComment = "달콤한 금요일 되세요"
        case "토": dayComment = "배부른 토요일 되세요"
        case "일": dayComment = "든든한 일요일 되세요"
        default: dayComment = "싱그러운 \(dayString) 되세요"
        }
        let color = UIColor(named: Constants.FruitfruitColors.orange1) ?? UIColor.orange
        return "푸릇푸릇!\n\(dayComment)".getColoredText("푸릇푸릇!", color)
    }
    
    var startOfMonth: Date {
        return Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Calendar.current.startOfDay(for: self)))!
    }
    
    var endOfMonth: Date {
        return Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: self.startOfMonth)!
    }
}
