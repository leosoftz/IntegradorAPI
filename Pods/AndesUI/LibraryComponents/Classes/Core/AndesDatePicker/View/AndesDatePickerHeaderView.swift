//
//  AndesDatePickerHeaderView.swift
//  AndesUI
//
//  Created by Ândriu Felipe Coelho on 09/11/20.
//

import UIKit

protocol AndesDatePickerHeaderViewDelegate: AnyObject {
    func nextMonth()
    func previousMonth()
}

class AndesDatePickerHeaderView: UICollectionReusableView {
    // MARK: - Attributes

    static let identifier = String(describing: AndesDatePickerHeaderView.self)
    var startOfWeek: AndesDatePickerStartOfWeek? {
        didSet {
            buildDaysOfWeek()
        }
    }
    weak var delegate: AndesDatePickerHeaderViewDelegate?

    private lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        dateFormatter.locale = Locale.init(identifier: Locale.preferredLanguages.first ?? Locale.current.identifier)
        dateFormatter.dateFormat = "MMMM yyyy"
        return dateFormatter
    }()

    var currentDate = Date() {
        didSet {
            monthLabel.text = dateFormatter.string(from: currentDate).capitalized
        }
    }

    // MARK: - UIComponents

    private let weekDaysStackView: UIStackView = {
        let horizontalStack = UIStackView()
        horizontalStack.axis = .horizontal
        horizontalStack.alignment = .center
        horizontalStack.distribution = .fillEqually
        horizontalStack.translatesAutoresizingMaskIntoConstraints = false

        return horizontalStack
    }()

    private lazy var monthLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = AndesStyleSheetManager.styleSheet.textColorPrimary
        label.font = AndesStyleSheetManager.styleSheet.regularSystemFont(size: 16.0)

        return label
    }()

    private(set) lazy var previousButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(didTouchPreviousMonth), for: .touchUpInside)
        return button
    }()

    private(set) lazy var nextButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(didTouchNextMonth), for: .touchUpInside)
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(weekDaysStackView)

        weekDaysStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12).isActive = true
        weekDaysStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        weekDaysStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true

        addSubview(monthLabel)
        monthLabel.bottomAnchor.constraint(equalTo: weekDaysStackView.topAnchor, constant: -20).isActive = true
        monthLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true

        addSubview(previousButton)
        AndesIconsProvider.loadIcon(name: AndesIcons.chevronLeft24) { icon in
            previousButton.setImage(icon.withRenderingMode(.alwaysOriginal), for: .normal)
        }
        previousButton.centerYAnchor.constraint(equalTo: monthLabel.centerYAnchor).isActive = true
        previousButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        previousButton.widthAnchor.constraint(equalTo: previousButton.widthAnchor, constant: 24).isActive = true
        previousButton.heightAnchor.constraint(equalTo: previousButton.heightAnchor, constant: 24).isActive = true
        previousButton.accessibilityLabel = "Mes anterior".localized()
        previousButton.accessibilityTraits = .button

        addSubview(nextButton)
        AndesIconsProvider.loadIcon(name: AndesIcons.chevronRight24) { icon in
            nextButton.setImage(icon.withRenderingMode(.alwaysOriginal), for: .normal)
        }
        nextButton.centerYAnchor.constraint(equalTo: monthLabel.centerYAnchor).isActive = true
        nextButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 8).isActive = true
        nextButton.widthAnchor.constraint(equalTo: previousButton.widthAnchor, constant: 24).isActive = true
        nextButton.heightAnchor.constraint(equalTo: previousButton.heightAnchor, constant: 24).isActive = true
        nextButton.accessibilityLabel = "Siguiente Mes".localized()
        nextButton.accessibilityTraits = .button

        accessibilityElements = [previousButton, monthLabel, nextButton]
        buildDaysOfWeek()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func clearWeekDaysStackView() {
        let removedSubviews = weekDaysStackView.arrangedSubviews.reduce([]) { allSubviews, subview -> [UIView] in
            weekDaysStackView.removeArrangedSubview(subview)
            return allSubviews + [subview]
        }

        // Deactivate all constraints
        NSLayoutConstraint.deactivate(removedSubviews.flatMap({ $0.constraints }))

        // Remove the views from self
        removedSubviews.forEach({ $0.removeFromSuperview() })
    }

    private func buildDaysOfWeek() {
        clearWeekDaysStackView()

        for day in 0...6 {
            let label = UILabel()

            var dayOfWeek = ["SEG".localized(),
                             "TER".localized(),
                             "QUA".localized(),
                             "QUI".localized(),
                             "SEX".localized(),
                             "SAB".localized(),
                             "DOM".localized()]

            if startOfWeek == .sunday, let mon = dayOfWeek.popLast() {
                dayOfWeek.insert(mon, at: 0)
            }

            label.text = dayOfWeek[day]
            label.textAlignment = .center
            label.font = AndesStyleSheetManager.styleSheet.regularSystemFont(size: 10.0)
            label.textColor = AndesStyleSheetManager.styleSheet.textColorSecondary
            label.isAccessibilityElement = false

            weekDaysStackView.addArrangedSubview(label)
        }
    }

    func togglePreviousButton(days: [AndesDayDatePicker], compareDate: Date? = nil) {
        let calendar = Calendar(identifier: .gregorian)
        previousButton.isEnabled = true
        for day in days {
            if let startDate = day.startDate {
                let sameMonth = calendar.compare(day.date, to: startDate, toGranularity: .day) == .orderedAscending
                if sameMonth {
                    previousButton.isEnabled = false
                }
            }
        }
    }

    func toggleNextButton(days: [AndesDayDatePicker], compareDate: Date? = nil) {
        let calendar = Calendar(identifier: .gregorian)
        nextButton.isEnabled = true
        for day in days {
            if let dueDate = day.dueDate {
                let sameMonth = calendar.compare(day.date, to: dueDate, toGranularity: .day) == .orderedDescending
                if sameMonth {
                    nextButton.isEnabled = false
                }
            }
        }
    }

    // MARK: - IBActions

    @objc func didTouchPreviousMonth(_ sender: UIButton) {
        delegate?.previousMonth()
    }

    @objc func didTouchNextMonth(_ sender: UIButton) {
        delegate?.nextMonth()
    }
}
