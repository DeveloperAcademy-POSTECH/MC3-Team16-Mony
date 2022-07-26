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
}
