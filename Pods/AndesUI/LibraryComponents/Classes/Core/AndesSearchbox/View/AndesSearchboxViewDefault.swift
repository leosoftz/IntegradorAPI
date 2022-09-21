//
//  AndesSearchboxViewDefault.swift
//  AndesUI
//
//  Created by Alvaro Hernan Orellana Villarroel on 22/05/2022.
//

import Foundation

class AndesSearchboxViewDefault: UIView, AndesSearchboxView {
    weak var delegate: AndesSearchboxViewDelegate?
    var config: AndesSearchboxViewConfig
    var searchbar = UISearchBar()
    var searchText: String? {
        get {
            searchbar.text
        }
        set {
            searchbar.text = newValue
        }
    }

    init(withConfig config: AndesSearchboxViewConfig) {
        self.config = config
        super.init(frame: .zero)
        setup()
    }

    required init?(coder: NSCoder) {
        config = AndesSearchboxViewConfig()
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        setupSearchBar()
        updateView()
    }

    private func setupSearchBar() {
        searchbar.translatesAutoresizingMaskIntoConstraints = false
        searchbar.tintColor = config.tintColor

        AndesIconsProvider.loadIcon(name: config.clearIconName) { clearIcon in
            searchbar.setImage(clearIcon, for: .clear, state: .normal)
        }

        searchbar.searchTextField.textColor = config.tintColor
        searchbar.searchTextField.layer.roundContentView(with: config.cornerRadius,
                                                         isMaskToBounds: true)
        positionIcons()
        addSubview(searchbar)
        searchbar.pinToSuperview()
        searchbar.delegate = self
    }

    private func positionIcons() {
        let searchIconOffset = UIOffset(horizontal: config.iconHorizontalOffset, vertical: 0)
        let clearIconOffset = UIOffset(horizontal: -config.iconHorizontalOffset, vertical: 0)
        searchbar.setPositionAdjustment(searchIconOffset, for: .search)
        searchbar.setPositionAdjustment(clearIconOffset, for: .clear)
    }

    func update(withConfig config: AndesSearchboxViewConfig) {
        self.config = config
        updateView()
    }

    private func updateView() {
        searchbar.placeholder = config.placeHolder

        let borderColor = config.state.borderColor
        let borderWidth = config.state.borderWidth

        searchbar.searchTextField.layer.setBorder(color: borderColor, width: borderWidth)
    }

    override func resignFirstResponder() -> Bool {
        searchbar.resignFirstResponder()
    }
}

// MARK: UISearchBarDelegate
extension AndesSearchboxViewDefault: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        delegate?.searchboxView(self, textDidChange: searchText)
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        delegate?.searchboxViewSearchButtonClicked(self)
    }

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        delegate?.searchboxTextDidBeginEditing(self)
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        delegate?.searchboxTextDidEndEditing(self)
    }
}
