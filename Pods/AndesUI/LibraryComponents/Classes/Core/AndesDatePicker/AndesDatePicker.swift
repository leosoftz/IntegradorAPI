//
//  AndesDatePicker.swift
//  AndesUI
//
//  Created by Ândriu Felipe Coelho on 08/11/20.
//

import UIKit

@objc public class AndesDatePicker: UIControl {
    // MARK: - Attributes

    @objc
    public var startOfWeek: AndesDatePickerStartOfWeek {
        didSet {
            datePickerView.startOfWeek = self.startOfWeek
        }
    }

    internal var contentView: AndesDatePickerView
    internal var datePickerView = AndesDatePickerDefaultView()
    internal var didTapped: ((_ selectedDate: Date?, _ isConfirmed: Bool) -> Void)?

    /// Date Picker: is a component of quick choice of dates
    /// - Parameters:
    ///   - maxDate: maximum date allowed to select a date (date after that it will not be allowed to select)
    ///   - callback: will return the selected date and if the confirmation button was pressed
    @objc public func setDatePickerDate(baseDate: Date? = nil, minDate: Date? = nil, maxDate: Date? = nil, callback: @escaping ((_ selectedDate: Date?, _ isConfirmed: Bool) -> Void)) {
        self.didTapped = callback
        datePickerView.setDates(base: baseDate, minDate: minDate, maxDate: maxDate)
    }

    /// - Parameters:
    ///   - isHidden: allows to hide the confirm button.
    @objc public func confirmButtonHidden(_ isHidden: Bool) {
        datePickerView.confirmButtonHidden(isHidden)
    }

    // MARK: - Initializer
    @objc public init() {
        self.startOfWeek = .monday
        contentView = datePickerView
        super.init(frame: .zero)
        setup()
    }

    required init?(coder: NSCoder) {
        self.startOfWeek = .monday
        contentView = datePickerView
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .clear
        self.addSubview(contentView)
        contentView.pinToSuperview()
        datePickerView.delegate = self
    }
}

/// Here we have 2 parameters:

/// 1) it's the selected date (can be null if the selected date is outside the allowed range)
/// 2) is the action of the confirm button (the user selected the date)

extension AndesDatePicker: AndesDatePickerAbstractViewDelegate {
    func didSelectDate(_ date: Date?, _ isConfirmed: Bool) {
        didTapped?(date, isConfirmed)
    }
}
