//
//  DateHelpers.swift
//  ToDo
//
//  Created by Jakub Błażowski on 22/08/2025.
//

import Foundation

public func plannedDateText(_ date: Date?, now: Date = Date(),
                            calendar: Calendar = .current,
                            locale: Locale = Locale(identifier: "en_US_POSIX")) -> String {
    guard let date = date else { return "None" }
    var cal = calendar
    if cal.isDate(date, inSameDayAs: now) { return "Today" }

    if let tomorrow = cal.date(byAdding: .day, value: 1, to: cal.startOfDay(for: now)),
       cal.isDate(date, inSameDayAs: tomorrow) {
        return "Tomorrow"
    }

    let fmt = DateFormatter()
    fmt.locale = locale
    let sameYear = cal.component(.year, from: date) == cal.component(.year, from: now)
    fmt.setLocalizedDateFormatFromTemplate(sameYear ? "d MMMM" : "d MMMM y")
    return fmt.string(from: date)
}

public func daysUntilDeadlineString(_ deadline: Date?, now: Date = Date(),
                                    calendar: Calendar = .current) -> String {
    guard let deadline = deadline else { return "No date" }
    let start = calendar.startOfDay(for: now)
    let end = calendar.startOfDay(for: deadline)
    let days = calendar.dateComponents([.day], from: start, to: end).day ?? 0
    return days >= 0 ? "\(days) days left" : "\(abs(days)) days after the deadline"
}
