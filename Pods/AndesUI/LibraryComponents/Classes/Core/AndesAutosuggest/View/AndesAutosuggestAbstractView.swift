//
//  AndesAutosuggestAbstractView.swift
//  AndesUI
//
//  Created by Santiago Lazzari on 25/05/2021.
//

import UIKit

class AndesAutosuggestAbstractView: UIView, AndesAutosuggestView {
    @IBOutlet var view: UIView!
    @IBOutlet var textField: AndesTextField!
    let list = AndesList()
    let menu = UIView()

    // TODO: There is no easy way to get the height of a cell
    let listCellHeight = 57

    weak var delegate: AndesAutosuggestViewDelegate!
    weak var datasource: AndesAutosuggestViewDatasource!

    private var config: AndesAutosuggestViewConfig

    var showing = false

    var availableFrame: CGRect = CGRect(x: 0, y: 0, width: 100, height: 100) // Hack to make lazy floating menu

    lazy var floatingMenu: AndesAutosuggestFloatingMenu = {
        AndesAutosuggestFloatingMenu(config: self.config, targetView: self.textField.contentView.textInputView, superView: datasource.superView(), menu: menu, delegate: self, availableFrame: self.availableFrame)
    }()

    var text: String {
        get { return textField.text }
        set { textField.text = newValue }
    }

    init() {
        self.config = AndesAutosuggestViewConfig()
        super.init(frame: .zero)
        setup()
        update(with: config)
    }

    required init?(coder: NSCoder) {
        self.config = AndesAutosuggestViewConfig()
        super.init(coder: coder)
        setup()
        update(with: config)
    }

    init(config: AndesAutosuggestViewConfig) {
        self.config = config
        super.init(frame: .zero)
        setup()
        update(with: config)
    }

    internal func loadNib() {
        fatalError("This should be overriden by a subclass")
    }

    func pinXibViewToSelf() {
        addSubview(view)
        view.pinToSuperview()
    }

    func setup() {
        loadNib()
        translatesAutoresizingMaskIntoConstraints = false
        pinXibViewToSelf()
        self.backgroundColor = .clear
        self.clipsToBounds = false
        setupTextfield()
        setupList()
    }

    func setupList() {
        menu.addSubview(list)
        list.pinToSuperview()
        list.delegate = self
        list.dataSource = self

        self.list.closureAccessibilityPerformEscape = { [weak self] in
            self?.hideSuggestions()
            self?.delegate?.onAccessibilityPerformEscapeActivated()
        }
    }

    func setupTextfield() {
        self.textField.delegate = self
        (textField.contentView as? AndesTextFieldAbstractView)?.innerTextField?.autocorrectionType = .no
    }

    func reloadData() {
        if showing {
            list.reloadData()
            floatingMenu.reloadMenu(with: CGFloat(listCellHeight * datasource.suggestions().count))
        }
    }

    func showSuggestions(availableFrame: CGRect) {
        if !showing {
            floatingMenu.availableFrame = availableFrame
            floatingMenu.showMenu(intrinsicSize: CGFloat(listCellHeight * datasource.suggestions().count))
            list.reloadData()
            showing = true
        }
    }

    func hideSuggestions() {
        if showing {
            floatingMenu.hideMenu()
            showing = false
        }
    }

    func update(with config: AndesAutosuggestViewConfig) {
        self.config = config

        textField.state = config.state
        textField.label = config.label
        textField.helper = config.helper
        textField.placeholder = config.placeholder
        textField.counter = config.counter

        textField.leftContent = config.leftContent
        textField.rightContent = config.rightContent
        if let traits = config.inputTraits {
            textField.setCustomInputTraits(traits)
        }
    }

    override func resignFirstResponder() -> Bool {
        if textField.resignFirstResponder() {
            hideSuggestions()
            return true
        }

        return false
    }

    override func becomeFirstResponder() -> Bool {
        return textField.becomeFirstResponder()
    }

    override var isFirstResponder: Bool {
        return textField.isFirstResponder
    }
}

extension AndesAutosuggestAbstractView: AndesTextFieldDelegate {
    public func andesTextFieldShouldBeginEditing(_ textField: AndesTextField) -> Bool {
        return delegate?.shouldBeginEditing() ?? true
    }

    public func andesTextFieldShouldEndEditing(_ textField: AndesTextField) -> Bool {
        return delegate?.shouldEndEditing() ?? true
    }

    public func andesTextFieldDidBeginEditing(_ textField: AndesTextField) {
        delegate?.didBeginEditing()
    }

    public func andesTextFieldDidEndEditing(_ textField: AndesTextField) {
        delegate?.didEndEditing(text: textField.text)
    }

    public func andesTextField(_ textField: AndesTextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return delegate?.textField(shouldChangeCharactersIn: range, replacementString: string) ?? true
    }

    public func andesTextFieldDidChangeSelection(_ textField: AndesTextField, selectedRange range: UITextRange?) {
        delegate?.didChangeSelection(selectedRange: range)
    }

    public func andesTextFieldDidChange(_ textField: AndesTextField) {
        delegate?.didChange()
    }

    public func andesTextFieldDidTapRightAction(_ textField: AndesTextField) {
        delegate?.didTapRightAction()
    }

    public func andesTextFieldShouldReturn(_ textField: AndesTextField) -> Bool {
        return delegate?.shouldReturn() ?? true
    }

    public func andesTextField(_ textField: AndesTextField, didDeleteBackwardAnd wasEmpty: Bool) {
        delegate?.didDeleteBackward(wasEmpty)
    }
}

extension AndesAutosuggestAbstractView: AndesListDelegate, AndesListDataSource {
    func andesList(_ listView: AndesList, didSelectRowAt indexPath: IndexPath) {
        delegate.suggestionWasTapped(suggestion: datasource.suggestions()[indexPath.row])
    }

    func andesList(_ listView: AndesList, cellForRowAt indexPath: IndexPath) -> AndesListCell {
        let suggestion = datasource.suggestions()[indexPath.row]

        return AndesSimpleCell(withTitle: suggestion)
    }

    func andesList(_ listView: AndesList, numberOfRowsInSection section: Int) -> Int {
        return datasource.suggestions().count
    }

    func numberOfSections(_ listView: AndesList) -> Int {
        return 1
    }
}

extension AndesAutosuggestAbstractView: AndesAutosuggestFloatingMenuDelegate {
    func didSelectBackground() {
        self.textField.resignFirstResponder()
        hideSuggestions()
    }
}
