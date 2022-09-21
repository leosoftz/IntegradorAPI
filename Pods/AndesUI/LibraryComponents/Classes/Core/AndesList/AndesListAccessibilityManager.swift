//
//  AndesListAccessibilityManager.swift
//  AndesUI
//
//  Created by Daniel Esteban Beltran Beltran on 29/07/21.
//

import Foundation

class AndesListAccessibilityManager: AndesAccessibilityManager {
    private weak var view: AndesListCell!

    required init(view: UIView) {
        guard let cell = view as? AndesListCell else {
            fatalError("ListCell AccessibilityManager should recieve an AndesListCell")
        }
        self.view = cell
        viewUpdated()
    }

    func viewUpdated() {
        view.isAccessibilityElement = true
        view.accessibilityLabel = createAccessibilityLabel(cell: view)
        view.accessibilityTraits = accessibilityTraits
        view.accessibilityHint = typeCellHint + elementCount
    }

    func accessibilityActivated() {
    }

    private func createAccessibilityLabel(cell: AndesListCell) -> String {
        var accessibilityLabel: String = ""
        accessibilityLabel += "\(cellTypeText) \(cellThumbnailText) \(cellTitleText) \(cellSubtitleText)"
        return accessibilityLabel
    }

    private func createThumbnailAccessiblityText() -> String? {
        if view.thumbnailImg != nil {
            guard let thumbnailType = view.thumbnailImg?.type,
                  let thumbnailAccessibilityDescription = view.thumbnailImg?.accessibilityDescription else {
                return nil
            }

            let a11yLabel = thumbnailType == .icon ? "icon accessibility".localized() : "image accessibility".localized()
            return "\(thumbnailAccessibilityDescription), \(a11yLabel)"
        }
        return nil
    }
}

extension AndesListAccessibilityManager {
    var cellTitleText: String {
         if let title = view.titleLbl.text {
            return title + ","
         }
         return ""
     }

    var cellSubtitleText: String {
         if let subtitle = view.subtitleLbl.text {
            return subtitle + "."
         }
         return ""
     }

    var cellThumbnailText: String {
        if let thumbnail = createThumbnailAccessiblityText() {
            return thumbnail + ","
        }
        return ""
    }

    var cellTypeText: String {
        return view.type == .checkBox || view.type == .radioButton ? view.isSelected ? "Marcado".localized() : "No Marcado".localized() : ""
    }

    var accessibilityTraits: UIAccessibilityTraits {
        return view.type == .chevron ? .button : .none
    }

    var typeCellHint: String {
        return view.type == .checkBox ? ", \("Casilla de selección".localized())," + "Toque dos veces para alternar".localized() :
        view.type == .radioButton ? ", \("Botón de selección".localized())," + "Toque dos veces para alternar".localized() : ""
    }

    var elementCount: String {
        if let tableView = view.firstSuperViewOf(type: AndesList.self), tableView.numberOfSections(in: tableView.tableView) != 0 {
            return "CurrentStatus".localizeWithFormat(arguments: view.row + 1, tableView.numberOfRows())
        }
        return ""
    }
}
