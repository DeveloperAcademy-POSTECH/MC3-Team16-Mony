//
//  MonthModel.swift
//  FruitFruit
//
//  Created by Junyeong Park on 2022/07/26.
//

import Foundation

struct MonthModel {
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
    
    func checkWeekDay() {
        //TODO: 해당 달의 특정 '날' -> 몇 주 차, 몇 요일인지 체크하는 함수
        let weekdayDict = ["일":0, "월":1, "화":2, "수":3, "목":4, "금":5, "토":6]
        let weekDayDictRev = [0:"일", 1:"월", 2:"화", 3:"수", 4:"목", 5:"금", 6:"토"]
        var curDayString = firstWeekDay
        var curDayOrder = weekdayDict[firstWeekDay]!
        var curDayInt = 1
        
        for curDay in 0..<curDayOrder {
            print(0, curDay, "공백", weekDayDictRev[curDay]!)
        }
        
        for weekIdx in 0..<numOfWeeks {
            for _ in 0..<7 {
                if curDayInt > numOfDays {
                    print(weekIdx, "공백", curDayInt, curDayString)
                } else {
                    print(weekIdx, curDayOrder, curDayInt, curDayString)
                }
                curDayInt += 1
                if curDayOrder + 1 == 7 {
                    curDayOrder = 0
                    curDayString = weekDayDictRev[curDayOrder]!
                    break
                }
                curDayOrder += 1
                curDayString = weekDayDictRev[curDayOrder]!
            }
        }
    }
}
