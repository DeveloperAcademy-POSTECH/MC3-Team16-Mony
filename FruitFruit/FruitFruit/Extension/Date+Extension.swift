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
    
    func getValidMonthModels(from: Date, to: Date) -> [MonthModel] {
        var months = [MonthModel]()
        let startMonthModel = MonthModel(date: from)
        months.append(startMonthModel)
        let calendar = Calendar.current
        let startDateComponent = calendar.dateComponents([.year, .month], from: from)
        let endDateComponent = calendar.dateComponents([.year, .month], from: to)
        
        var startMonth = startDateComponent.month!
        var startYear = startDateComponent.year!
        
        let endMonth = endDateComponent.month!
        let endYear = endDateComponent.year!
                
        var tempDate = from
        while (startYear < endYear) || ((startYear == endYear) && startMonth < endMonth) {
            tempDate = calendar.date(byAdding: .month, value: 1, to: tempDate)!
            let tempMonthModel = MonthModel(date: tempDate)
            months.append(tempMonthModel)
            startMonth += 1
            
            if startMonth == 13 {
                startMonth = 1
                startYear += 1
            }
        }
        return months
    }
    
    func getValidWeeks() -> [Date] {
        let weekDict = ["일":0, "월":1, "화":2, "수":3, "목":4, "금":5, "토":6]
        let todayString = Date().dayString
        let todayOrdinal = weekDict[todayString] ?? 0
        let calendar = Calendar.current
        var validWeeks = [Date]()
        var offset = -todayOrdinal - 6
        for _ in 0..<14 {
            let tempDay = calendar.date(byAdding: .day, value: offset, to: Date())!
            validWeeks.append(tempDay)
            offset += 1
        }
        
        return validWeeks
    }
}
