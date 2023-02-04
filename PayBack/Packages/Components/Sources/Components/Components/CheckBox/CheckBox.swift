

import UIKit

// MARK: - Checkbox With Terms Delegate
public protocol CheckBoxDelegate: AnyObject {
    func checkBox(_ checkBox: CheckBox, didTapAndChangeStateTo state: CheckBox.State)
    func checkBoxDidTapTerm(_ checkBox: CheckBox)
}

public extension CheckBoxDelegate {
    func checkBoxDidTapTerm(_ checkBox: CheckBox) { }
}

/**
 CheckBox Component
 
 ## Usage example ##
 
        let checkbox = CheckBox(type: .checkBox(state: .indeterminate))
 
        checkbox.configure(
                type: .checkBoxWithTitle(
                    title: "დამახსოვრება",
                    state: .active))
        checkbox.configure(
                type: .checkBoxWithTitleAndTerm(
                    title: "ვეთანხმები",
                    term: "პირობებს",
                    state: .inactive))
 
        checkbox.setState(state: .error)

 
 */
public class CheckBox: UIView {
    
    // MARK: Internal components
    private let checkbox: CheckBoxButton = {
        let checkbox = CheckBoxButton()
        checkbox.translatesAutoresizingMaskIntoConstraints = false
        return checkbox
    }()
    
    private lazy var textLabel: TermTextLabel = {
        let textLabel = TermTextLabel()
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        textLabel.delegate = self
        return textLabel
    }()
    
    private let spacerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        view.setContentHuggingPriority(.required, for: .horizontal)
        return view
    }()
    
    private let containerStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 0
        stack.distribution = .fill
        stack.alignment = .center
        return stack
    }()

    private var checkBoxState: CheckBox.State = .inactive
    public weak var delegate: CheckBoxDelegate?
    
    // MARK: Initializers
    
    public init() {
        super.init(frame: .zero)
        commonInit()
    }
    
    public convenience init(type: CheckBox.ModelType){
        self.init()
        configure(type: type)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Public interface
    public func configure(type: CheckBox.ModelType) {
        switch type {
        case .checkBoxWithTitleAndTerm(let preTermText, let term , let state):
            self.checkBoxState = state
            setUpTextLabelWithTerm(preTermText: preTermText, term: term)
            changeLabelTextColors()
        case .checkBoxWithTitle(let preTermText, let state):
            self.checkBoxState = state
            setUpTextLabelWithoutTerm(preTermText: preTermText)
            changeLabelTextColors()
        case .checkBox(let state):
            self.checkBoxState = state
            setUpWithOnlyButton()
        }
    }
    
    public func setState(state: State) {
        self.checkBoxState = state
        changeCheckBoxButtonState()
        changeLabelTextColors()
    }
    
    public func getState() -> State {
        return self.checkBoxState
    }
}

// MARK: Setup
extension CheckBox {
    
    private func commonInit() {
        addSubviews()
        setupConstraints()
        addGestureRecocnizers()
    }
    
    private func addSubviews() {
        addSubview(containerStack)
        containerStack.addArrangedSubview(checkbox)
        containerStack.addArrangedSubview(textLabel)
        containerStack.addArrangedSubview(spacerView)
    }
    
    private func setupConstraints() {
        containerStack.top(toView: self)
        containerStack.left(toView: self)
        containerStack.right(toView: self)
        containerStack.bottom(toView: self)
    }
    
    private func addGestureRecocnizers() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.didTapCheckBoxButton(_:)))
        checkbox.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc private func didTapCheckBoxButton(_ sender: UITapGestureRecognizer) {
        guard checkBoxState != .disabled else { return }
        
        checkBoxState.changeState()
        changeCheckBoxButtonState()
        changeLabelTextColors()
        delegate?.checkBox(self, didTapAndChangeStateTo: checkBoxState)
    }
    
    private func changeCheckBoxButtonState() {
        UIView.animate(withDuration: TimeInterval(0.1), animations: updateCheckBoxColors )
    }
    
    private func updateCheckBoxColors() {
        checkbox.updateColors(
            backgroundColor:CheckBox.CheckBoxButtonConfigurations.fillColor(forState: checkBoxState),
            borderColor: CheckBox.CheckBoxButtonConfigurations.borderColor(forState: checkBoxState).cgColor,
            image: CheckBox.CheckBoxButtonConfigurations.fillerImage(forState: checkBoxState)
        )
    }
    
    private func setUpWithOnlyButton() {
        changeCheckBoxButtonState()
        toggleLabelVisibility(showLabel: false, showSpacer: false)
    }
    
    private func setUpTextLabelWithTerm(preTermText: String, term: String) {
        changeCheckBoxButtonState()
        configureLabelWithTextAndTerm(preTermText: preTermText, term: term)
        toggleLabelVisibility(showLabel: true, showSpacer: true)
    }
 
    
    private func setUpTextLabelWithoutTerm(preTermText: String) {
        changeCheckBoxButtonState()
        configureLabelWithOnlyText(preTermText: preTermText)
        toggleLabelVisibility(showLabel: true, showSpacer: false)
    }
    
    private func configureLabelWithOnlyText(preTermText: String) {
        textLabel.configure(type: .withOnlyPreTermText(preTermText: preTermText))
        textLabel.font = Brandbook.Font.body1
        textLabel.numberOfLines = CheckBox.TermTextLabelConsts.Metric.numberOfLinesWhenWithoutTerm
    }
    
    
    private func configureLabelWithTextAndTerm(preTermText: String, term: String) {
        textLabel.configure(type: .withTermAndPreTermText(preTermText: preTermText, term: term))
        textLabel.font = Brandbook.Font.smallButton
        textLabel.numberOfLines = CheckBox.TermTextLabelConsts.Metric.numberOfLinesWhenWithTerm
    }
    
    private func changeLabelTextColors() {
        guard let attributedText = textLabel.attributedText else { return }
        textLabel.attributedText = formattedAttributedStringForTerms(
            currentString: attributedText,
            termRange: textLabel.getTermRange(),
            forState: checkBoxState,
            font: textLabel.font
        )
    }
    
    private func toggleLabelVisibility(showLabel: Bool, showSpacer: Bool) {
        textLabel.isHidden = !showLabel
        spacerView.isHidden = !showSpacer
    }
}

// MARK: Delegate
extension CheckBox: TermTextLabelDelegate {
    /// :nodoc:
    public func termTextLabelDidTapOnText(_ sender: TermTextLabel) {
        if checkBoxState == .disabled { return }
        
        checkBoxState.changeState()
        changeCheckBoxButtonState()
        changeLabelTextColors()
        
        delegate?.checkBox(self, didTapAndChangeStateTo: checkBoxState)
    }
    
    /// :nodoc:
    public func termTextLabelDidTapOnTerm(_ sender: TermTextLabel) {
        if checkBoxState == .disabled { return }
        
        delegate?.checkBoxDidTapTerm(self)
    }
    
}

// MARK: term label configuration with state
extension CheckBox {
    private func formattedAttributedStringForTerms(
        currentString: NSAttributedString,
        termRange: NSRange?,
        forState state: CheckBox.State,
        font: UIFont
    ) -> NSAttributedString? {
        
        let attributedString = NSMutableAttributedString(attributedString: currentString)
        
        switch state {
        case .active, .inactive:
            attributedString.addAttributes(
                [
                    .font: font,
                    .foregroundColor: CheckBox.TermTextLabelConsts.Color.defaultTextColor
                ],
                range: NSRange(location: 0, length: currentString.length)
            )
            if let termRange = termRange {
                attributedString.addAttributes([
                    .foregroundColor: CheckBox.TermTextLabelConsts.Color.externalLinkTextColor
                ], range: termRange)
            }
        case .disabled:
            attributedString.addAttributes(
                [
                    .font: font,
                    .foregroundColor: CheckBox.TermTextLabelConsts.Color.disabledTextColor
                ],
                range: NSRange(location: 0, length: currentString.length)
            )
        case .error:
            attributedString.addAttributes(
                [
                    .font: font,
                    .foregroundColor: CheckBox.TermTextLabelConsts.Color.errorTextColor
                ],
                range: NSRange(location: 0, length: currentString.length)
            )
        case .indeterminate:
            attributedString.addAttributes(
                [
                    .font: font,
                    .foregroundColor: CheckBox.TermTextLabelConsts.Color.defaultTextColor
                ],
                range: NSRange(location: 0, length: currentString.length)
            )
            if let termRange = termRange {
                attributedString.addAttributes([
                    .foregroundColor: CheckBox.TermTextLabelConsts.Color.externalLinkTextColor
                ], range: termRange)
            }
        }
        return attributedString
    }
}
