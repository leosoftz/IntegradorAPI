//
//  TableViewDelegate.swift
//  AndesUI
//
//  Created by Jonathan Alonso Pinto on 27/10/20.
//

import Foundation

internal class AndesListTableViewDelegate: NSObject, UITableViewDelegate {
    var listProtocol: AndesListProtocol

    init(listProtocol: AndesListProtocol) {
        self.listProtocol = listProtocol
        super.init()
    }

    internal func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = listProtocol.cellForRowAt(indexPath: indexPath)
        switch cell.type {
        case .simple, .chevron, .timePicker :
            tableView.deselectRow(at: indexPath, animated: true)

        case .radioButton, .checkBox :
            break
        }
        listProtocol.didSelectRowAt?(indexPath: indexPath)
    }

    internal func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        listProtocol.didDeselectRowAt?(indexPath: indexPath)
    }

    internal func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if tableView.numberOfRows(inSection: indexPath.section) - 1 <= indexPath.row {
            guard let cell = cell as? AndesListCell else {
                fatalError("The dequeued cell is not an instance of AndesListSimpleViewCell.")
            }
            cell.setupSeparatorStyle(separatorStyle: .none)
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
