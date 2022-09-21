//
//  AndesDayDatePicker.swift
//  AndesUI
//
//  Created by Ândriu Felipe Coelho on 10/11/20.
//

import Foundation

protocol AndesDayDatePickerDelegate: AnyObject {
    func didSelectEnabledDay(_ day: Date?)
}

@objc class AndesDayDatePicker: NSObject {
    // MARK: - Attributes

    private(set) var date: Date
    private(set) var number: String
    private(set) var isCurrentMonth: Bool
    private(set) var isValid: Bool
    private(set) var dueDate: Date?
    private(set) var startDate: Date?
    private(set) var lastDay: Date?

    var selected: Bool {
        didSet {
            if selected {
                delegate?.didSelectEnabledDay(lastDay)
            }
        }
    }
    weak var delegate: AndesDayDatePickerDelegate?

    private lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d"
        return dateFormatter
    }()

    init(date: Date? = Date(), number: String = "", selected: Bool = false, isCurrentMonth: Bool = false, endDate: Date? = nil, startDate: Date? = nil, isValid: Bool = false) {
        self.date = date ?? Date()
        self.number = number
        self.selected = selected
        self.isCurrentMonth = isCurrentMonth
        self.dueDate = endDate
        self.startDate = startDate
        self.isValid = isValid
    }

    // MARK: - Struct methods

    /// this method creates all days of the month

    func getDaysInMonth(
        currentDate: Date,
        selectedDate: Date?,
        startOfWeek: AndesDatePickerStartOfWeek? = .monday
    ) -> [AndesDayDatePicker] {
        guard let monthData = try? AndesMonthDatePicker.getMonthData(currentDate, startOfWeek: startOfWeek ?? .monday) else {
            fatalError("error to load the month in date: \(date)")
        }

        let daysNumberInMonth = monthData.daysNumber
        let offsetToInitialRow = monthData.firstWeekday
        let firstDay = monthData.firstDay

        var daysToRenderInMonth: [AndesDayDatePicker] = (1..<(daysNumberInMonth + offsetToInitialRow)).map { day in
            let dayOffSet = isCurrentMonth ? day - offsetToInitialRow : -(offsetToInitialRow - day)

            let calendar = Calendar(identifier: .gregorian)
            let date = calendar.date(byAdding: .day, value: dayOffSet, to: firstDay) ?? firstDay
            self.lastDay = date

            var isCurrentMonth = hasRange() ? dateIsInRange(date) : day >= offsetToInitialRow
            if calendar.compare(monthData.firstDay, to: date, toGranularity: .day) == .orderedAscending || calendar.compare(monthData.firstDay, to: date, toGranularity: .day) == .orderedSame {
                isValid = hasRange() ? dateIsInRange(date) : true
            } else {
                isValid = false
                isCurrentMonth = false
            }

            if dueDate != nil && selectedDate == nil {
                selected = calendar.compare(date, to: dueDate ?? Date(), toGranularity: .day) == .orderedSame
            } else {
                selected = calendar.isDate(date, inSameDayAs: selectedDate ?? Date())
            }

            return AndesDayDatePicker(date: date, number: dateFormatter.string(from: date), selected: selected, isCurrentMonth: isCurrentMonth, endDate: dueDate, startDate: startDate, isValid: isValid)
        }

        daysToRenderInMonth += generateStartOfNextMonth(
            using: firstDay,
            selectedDate: selectedDate ?? Date(),
            startOfWeek: startOfWeek ?? .monday,
            daysToRenderInMonth: daysToRenderInMonth.count
        )

        return daysToRenderInMonth
    }

    /// this method creates the missing days to fill the last week

    func generateStartOfNextMonth(
        using firstDayOfDisplayedMonth: Date,
        selectedDate: Date, startOfWeek: AndesDatePickerStartOfWeek,
        daysToRenderInMonth: Int
    ) -> [AndesDayDatePicker] {
        let calendar = Calendar(identifier: .gregorian)
        guard let lastDayInMonth = calendar.date(byAdding: DateComponents(month: 1, day: -1),
                                                 to: firstDayOfDisplayedMonth) else { return [] }

        var additionalDays = 7 - calendar.component(.weekday, from: lastDayInMonth)
        if startOfWeek == .monday {
            additionalDays += 1
        }

        let totalDays = daysToRenderInMonth + additionalDays
        if totalDays < 42 {
            additionalDays += 42 - totalDays
        }

        guard additionalDays > 0 else {
            return []
        }
        let days: [AndesDayDatePicker] = (1...additionalDays)
            .map {
                let date = calendar.date(byAdding: .day, value: $0, to: lastDayInMonth) ?? lastDayInMonth

                return AndesDayDatePicker(date: date,
                                          number: dateFormatter.string(from: date),
                                          selected: calendar.isDate(date, inSameDayAs: selectedDate),
                                          isCurrentMonth: false, isValid: false)
            }

        return days
    }

    /// given a date it checks if it is within the range

    private func dateIsInRange(_ date: Date) -> Bool {
        if dueDate == nil && startDate == nil {
            return false
        }

        if let dueDate = dueDate {
            if Calendar.current.compare(date, to: dueDate, toGranularity: .day) == .orderedSame {
                return true
            }
        }

        if let startDate = startDate {
            if Calendar.current.compare(date, to: startDate, toGranularity: .day) == .orderedSame {
                return true
            }
        }

        if dueDate == nil && startDate != nil {
            return date.compare(startDate ?? Date()) == .orderedDescending
        }

        if startDate == nil && dueDate != nil {
            return date.compare(dueDate ?? Date()) == .orderedAscending
        }

        if Calendar.current.compare(date, to: startDate ?? Date(), toGranularity: .day) == .orderedDescending && Calendar.current.compare(date, to: dueDate ?? Date(), toGranularity: .day) == .orderedAscending {
            return true
        }

        return false
    }

    func hasRange() -> Bool {
        return startDate != nil || dueDate != nil
    }
}
