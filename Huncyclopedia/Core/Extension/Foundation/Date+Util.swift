//
//  Date+Util.swift
//  CoreUI
//
//  Created by hsncr on 1.12.2020.
//

import Foundation

extension Date {
    
    public func dateByAddingYears(by years: Int) -> Date {
        let endDate = Calendar.current.date(byAdding: .year,
                                            value: years,
                                            to: self)
        return endDate ?? self
    }
    
    
    public var timeString: String {
        return formattedString(with: "HH:mm")
    }
    
    public var shortDateString: String {
        return formattedString(with: "dd.MM.yyyy")
    }
    
    public var dateTimeString: String {
        return formattedString(with: "dd.MM.yyyy HH:mm")
    }
    
    public func formattedString(with format: String,
                                locale: Locale = Locale.current) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.locale = locale
        return formatter.string(from: self)
    }
    
    public var year: Int {
        let calender = Calendar.current
        let dateComponent = calender.dateComponents([.year, .month, .day], from: self)
        return dateComponent.year!
    }
    
    public var month: Int {
        let calender = Calendar.current
        let dateComponent = calender.dateComponents([.year, .month, .day], from: self)
        return dateComponent.month!
    }
    
    public var day: Int {
        let calender = Calendar.current
        let dateComponent = calender.dateComponents([.year, .month, .day], from: self)
        return dateComponent.day!
    }
    
    public var isInToday: Bool {
        return Calendar.current.isDateInToday(self)
    }
    
    public func isSameDay(with date: Date) -> Bool {
        return Calendar.current.isDate(self, inSameDayAs: date)
    }
}
