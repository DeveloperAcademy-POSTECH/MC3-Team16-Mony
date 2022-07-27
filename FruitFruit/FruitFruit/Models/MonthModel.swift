//
//  MonthModel.swift
//  FruitFruit
//
//  Created by Junyeong Park on 2022/07/26.
//

import Foundation

struct MonthModel: Hashable {
    let year: Int
    let month: Int
    let numOfDays: Int
    let firstWeekDay: String
    let lastWeekDay: String
    let numOfWeeks: Int
    
    init(date: Date) {
        let start = date.startOfMonth
        let end = date.endOfMonth
        let Calendar = Calendar.current
        let endComponents = Calendar.dateComponents([.year, .month, .day, .weekOfMonth], from: end)
        self.year = endComponents.year!
        self.month = endComponents.month!
        self.numOfDays = endComponents.day!
        self.firstWeekDay = start.dayString
        self.lastWeekDay = end.dayString
        self.numOfWeeks = endComponents.weekOfMonth!
    }
    
    func getDatePosition(from : Date) -> (Int, Int)? {
        let dateComponents = Calendar.current.dateComponents([.year, .month, .day], from: from)
        let curYear = dateComponents.year!
        let curMonth = dateComponents.month!
        let curDay = dateComponents.day!
        let curDayString = from.dayString
        if year != curYear || month != curMonth {
            return nil
        }
        let weekdayDict = ["일":0, "월":1, "화":2, "수":3, "목":4, "금":5, "토":6]
        let weekDayDictRev = [0:"일", 1:"월", 2:"화", 3:"수", 4:"목", 5:"금", 6:"토"]
        
        var weekIdx = 0
        var tempDay = 0
        while tempDay + 7 <= curDay {
            tempDay += 7
            weekIdx += 1
        }
        
        return (weekIdx + 1, weekdayDict[curDayString]!)
        // 해당 날짜 -> MonthModel의 달 내에서 몇 주차 몇 번째 요일인지 리턴하기
        // TODO: 달력 그리기 -> 오늘 / 과일 섭취일 날짜 입력 -> 달력 다시 입력값 넣기
    }
    
    func checkWeekDay() -> [[String]] {
        var result = [[String]]()
        result.append(["일", "월", "화", "수", "목", "금", "토"])
        let weekdayDict = ["일":0, "월":1, "화":2, "수":3, "목":4, "금":5, "토":6]
        let weekDayDictRev = [0:"일", 1:"월", 2:"화", 3:"수", 4:"목", 5:"금", 6:"토"]
        var curDayString = firstWeekDay
        var curDayOrder = weekdayDict[firstWeekDay]!
        var curDayInt = 1
        var curWeek = [String]()
        for curDay in 0..<curDayOrder {
            curWeek.append("")
        }
        for weekIdx in 1...numOfWeeks {
            for _ in 0..<7 {
                if curDayInt > numOfDays {
                    curWeek.append("")
                } else {
                    curWeek.append(String(curDayInt))
                }
                curDayInt += 1
                if curDayOrder + 1 == 7 {
                    curDayOrder = 0
                    curDayString = weekDayDictRev[curDayOrder]!
                    result.append(curWeek)
                    curWeek = []
                    break
                }
                curDayOrder += 1
                curDayString = weekDayDictRev[curDayOrder]!
            }
        }
        return result
    }
}
