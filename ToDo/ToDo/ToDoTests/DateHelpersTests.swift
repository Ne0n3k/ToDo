//
//  DateHelpersTests.swift
//  ToDo
//
//  Created by Jakub Błażowski on 22/08/2025.
//

import XCTest
@testable import ToDo

final class DateHelpersTests: XCTestCase {

    private var cal: Calendar!
    private var now: Date!

    override func setUp() {
        super.setUp()
        cal = Calendar(identifier: .gregorian)
        cal.timeZone = TimeZone(secondsFromGMT: 0)!  // determinism
        now = cal.date(from: DateComponents(year: 2025, month: 8, day: 20))!
    }

    func testPlannedDateText_nil() {
        XCTAssertEqual(plannedDateText(nil, now: now, calendar: cal), "None")
    }

    func testPlannedDateText_today_and_tomorrow() {
        let today = now
        let tomorrow = cal.date(byAdding: .day, value: 1, to: now)!
        XCTAssertEqual(plannedDateText(today, now: now, calendar: cal), "Today")
        XCTAssertEqual(plannedDateText(tomorrow, now: now, calendar: cal), "Tomorrow")
    }

    func testPlannedDateText_formatsYearWhenDifferent() {
        let nextYear = cal.date(from: DateComponents(year: 2026, month: 1, day: 5))!
        let str = plannedDateText(nextYear, now: now, calendar: cal, locale: Locale(identifier: "en_US_POSIX"))
        XCTAssertTrue(str.contains("2026"), "Expected year in formatted date, got: \(str)")
    }

    func testDaysUntilDeadlineString_future_and_past() {
        let inTwoDays = cal.date(byAdding: .day, value: 2, to: now)!
        let threeDaysAgo = cal.date(byAdding: .day, value: -3, to: now)!
        XCTAssertEqual(daysUntilDeadlineString(inTwoDays, now: now, calendar: cal), "2 days left")
        XCTAssertEqual(daysUntilDeadlineString(threeDaysAgo, now: now, calendar: cal), "3 days after the deadline")
    }
}
