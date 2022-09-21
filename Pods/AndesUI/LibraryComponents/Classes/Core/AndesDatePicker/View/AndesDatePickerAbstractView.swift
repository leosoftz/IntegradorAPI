//
//  AndesDatePickerAbstractView.swift
//  AndesUI
//
//  Created by Ândriu Felipe Coelho on 08/11/20.
//

import Foundation

protocol AndesDatePickerAbstractViewDelegate: AnyObject {
    func didSelectDate(_ date: Date?, _ isConfirmed: Bool)
}

public class AndesDatePickerAbstractView: UIView, AndesDatePickerView {
    // MARK: - IBOutlet

    @IBOutlet var datePickerView: UIView!
    @IBOutlet var datePickerCollectionView: UICollectionView!
    @IBOutlet var buttonPrimary: AndesButton!

    // MARK: - Attributes

    internal var backgroundLayer = CALayer()
    weak var delegate: AndesDatePickerAbstractViewDelegate?
    internal var dataCollectionView: AndesDatePickerSettingCollection?

    internal var selectedDate: Date? = Date() {
        didSet {
            if selectedDate != nil {
                lastSelectedDate = selectedDate
            }
        }
    }
    internal var lastSelectedDate: Date?
    internal var isAlreadyInitialized = false
    private(set) var dayCalendar = AndesDayDatePicker()
    private var calendar = Calendar(identifier: .iso8601)
    public var currentDates: (Date?, Date?) {
           (dayCalendar.startDate, dayCalendar.dueDate)
       }

    private(set) lazy var daysToRender = dayCalendar.getDaysInMonth(currentDate: Date(), selectedDate: nil, startOfWeek: startOfWeek)

    private(set) var baseDate: Date {
        didSet {
            daysToRender = dayCalendar.getDaysInMonth(currentDate: baseDate, selectedDate: selectedDate, startOfWeek: startOfWeek)
            dataCollectionView?.days = daysToRender
            dataCollectionView?.currentDate = baseDate
            datePickerCollectionView.reloadData()
        }
    }

    var startOfWeek: AndesDatePickerStartOfWeek? {
        didSet {
            daysToRender = dayCalendar.getDaysInMonth(currentDate: baseDate, selectedDate: selectedDate, startOfWeek: startOfWeek)
            dataCollectionView?.days = daysToRender
            dataCollectionView?.currentDate = baseDate
            dataCollectionView?.startOfWeek = startOfWeek
            datePickerCollectionView.reloadData()
        }
    }

    override public var frame: CGRect {
        didSet {
            datePickerView?.frame = frame
        }
    }

    // MARK: - Instantiate

    internal init() {
        baseDate = Date()
        super.init(frame: .zero)
        setup()
    }

    required init?(coder: NSCoder) {
        baseDate = Date()
        super.init(coder: coder)
        setup()
    }

    internal func loadNib() { }

    // MARK: - Class methods

    func setDates(base: Date? = nil, minDate: Date? = nil, maxDate: Date? = nil) {
        maxDate != nil ? setup() : ()
        if let baseDate = base, let min = minDate, let max = maxDate {
            if baseDate >= min && baseDate <= max {
                selectedDate = base
                dayCalendar = AndesDayDatePicker(endDate: maxDate, startDate: minDate)
            }
        } else {
            var noLimit = true
            var wrongRange = false

            if let baseDate = base, let min = minDate {
                noLimit = false
                if baseDate >= min {
                    selectedDate = base
                } else {
                    selectedDate = Date()
                    wrongRange = true
                }
            }

            if let baseDate = base, let max = maxDate {
                noLimit = false
                if baseDate <= max {
                    selectedDate = base
                } else {
                    selectedDate = Date()
                    wrongRange = true
                }
            }

            if noLimit {
                if let baseDate = base {
                    selectedDate = baseDate
                } else {
                    selectedDate = Date()
                }
            }

            if wrongRange {
                dayCalendar = AndesDayDatePicker()
            } else {
                dayCalendar = AndesDayDatePicker(endDate: maxDate, startDate: minDate)
            }
        }
        dayCalendar.delegate = self
        baseDate = base ?? Date()
        setupCollectionView(baseDate: selectedDate)
    }

    func confirmButtonHidden(_ isHidden: Bool) {
        buttonPrimary.isHidden = isHidden
    }

    private func setup() {
        if isAlreadyInitialized {
            return
        }
        isAlreadyInitialized = true
        loadNib()
        datePickerView.layer.cornerRadius = 12
        translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(datePickerView)
        backgroundLayer = datePickerView.layer
        datePickerView.pinToSuperview()

        buttonPrimary.text = "Confirmar".localized()
        buttonPrimary.size = .large

        buttonPrimary.isEnabled = false
    }

    func setupCollectionView(baseDate _ : Date?) {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 0
        datePickerCollectionView.collectionViewLayout = layout
        datePickerCollectionView.isScrollEnabled = false

        dataCollectionView = AndesDatePickerSettingCollection(
            baseDate: baseDate,
            daysToRender: daysToRender,
            startOfWeek: self.startOfWeek ?? .monday
        )
        dataCollectionView?.delegate = self
        datePickerCollectionView.dataSource = dataCollectionView
        datePickerCollectionView.delegate = dataCollectionView

        datePickerCollectionView.register(AndesDatePickerCell.self, forCellWithReuseIdentifier: AndesDatePickerCell.identifier)
        datePickerCollectionView.register(AndesDatePickerHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "AndesDatePickerHeaderView")
    }

    // MARK: - IBAction

    @IBAction func didTouchConfirm(_ sender: AndesButton) {
        delegate?.didSelectDate(lastSelectedDate, true)
    }
}

extension AndesDatePickerAbstractView: AndesDatePickerSettingCollectionDelegate {
    func didSelectDate(_ date: Date?) {
        selectedDate = date
        buttonPrimary.isEnabled = true
        delegate?.didSelectDate(selectedDate, false)
    }

    func didTouchNextMonth() {
        baseDate = calendar.date(byAdding: .month, value: 1, to: baseDate) ?? baseDate
    }

    func didTouchPreviousMonth() {
        baseDate = calendar.date(byAdding: .month, value: -1, to: baseDate) ?? baseDate
    }
}

extension AndesDatePickerAbstractView: AndesDayDatePickerDelegate {
    func didSelectEnabledDay(_ day: Date?) {
        selectedDate = day
        buttonPrimary.isEnabled = true
    }
}
