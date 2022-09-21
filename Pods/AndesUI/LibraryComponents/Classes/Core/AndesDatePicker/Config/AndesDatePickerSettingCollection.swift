//
//  AndesDatePickerSettingCollection.swift
//  AndesUI
//
//  Created by Ândriu Felipe Coelho on 09/11/20.
//

import UIKit

/// This class has all collectionview implementation (UICollectionViewDataSource and UICollectionViewDelegate)

protocol AndesDatePickerSettingCollectionDelegate: AnyObject {
    func didTouchNextMonth()
    func didTouchPreviousMonth()
    func didSelectDate(_ date: Date?)
}

@objc class AndesDatePickerSettingCollection: NSObject, UICollectionViewDataSource {
    // MARK: - Attributes

    var days: [AndesDayDatePicker] = []
    var currentDate: Date
    internal var startOfWeek: AndesDatePickerStartOfWeek?

    weak var delegate: AndesDatePickerSettingCollectionDelegate?
    var currentSelectedDay: IndexPath?

    private var calendar = Calendar(identifier: .iso8601)
    private var header: AndesDatePickerHeaderView?

    // MARK: - Initializer

    init(baseDate: Date, daysToRender daysToRenderInMonth: [AndesDayDatePicker], startOfWeek: AndesDatePickerStartOfWeek?) {
        self.days = daysToRenderInMonth
        self.currentDate = baseDate
        self.startOfWeek = startOfWeek
    }

    // MARK: - UICollectionViewDataSource

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return days.count
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let day = days[indexPath.item]
        if day.selected {
            currentSelectedDay = indexPath
        }

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AndesDatePickerCell.identifier, for: indexPath) as? AndesDatePickerCell else {
            fatalError("error to create AndesDatePickerCell")
        }
        cell.day = day

        if !day.isValid, !day.selected {
            cell.accessibilityTraits = .notEnabled
        } else if day.selected {
            cell.accessibilityTraits = .selected
        } else {
            cell.accessibilityTraits = .button
        }
        return cell
    }
}

extension AndesDatePickerSettingCollection: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard days[indexPath.item].isValid else {
            delegate?.didSelectDate(nil)
            collectionView.deselectItem(at: indexPath, animated: false)
            return
        }

        if let currentSelectedDay = currentSelectedDay {
            days[currentSelectedDay.row].selected = false
            days[indexPath.item].selected = true
            let itemsToReload = currentSelectedDay != indexPath ? [currentSelectedDay, indexPath] : [indexPath]
            collectionView.reloadItems(at: itemsToReload)
            self.currentSelectedDay = indexPath
        } else {
            currentSelectedDay = indexPath
            days[indexPath.item].selected = true
            collectionView.reloadItems(at: [indexPath])
        }
        let day = days[indexPath.item]
        delegate?.didSelectDate(day.date)
    }
}

extension AndesDatePickerSettingCollection: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = Int(collectionView.frame.width / 7)
        return CGSize(width: width, height: 29)
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 80.0)
    }

    public func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: AndesDatePickerHeaderView.identifier, for: indexPath) as? AndesDatePickerHeaderView
            header?.startOfWeek = self.startOfWeek
            header?.delegate = self
            header?.currentDate = currentDate
            header?.togglePreviousButton(days: days)
            header?.toggleNextButton(days: days)

            return header ?? UICollectionReusableView()
        default:
            return UICollectionReusableView()
        }
    }
}

extension AndesDatePickerSettingCollection: AndesDatePickerHeaderViewDelegate {
    func nextMonth() {
        delegate?.didTouchNextMonth()
    }

    func previousMonth() {
        delegate?.didTouchPreviousMonth()
    }
}
