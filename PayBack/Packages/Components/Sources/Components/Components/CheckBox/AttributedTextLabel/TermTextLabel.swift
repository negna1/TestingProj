

import UIKit

public protocol TermTextLabelDelegate: AnyObject {
    func termTextLabelDidTapOnText(_ termTextLabel: TermTextLabel)
    func termTextLabelDidTapOnTerm(_ termTextLabel: TermTextLabel)
}

public class TermTextLabel: LocalLabel {
    private var termRangeWithIcon: NSRange?
    public weak var delegate: TermTextLabelDelegate?
    
    //MARK: Initializers
    public init() {
        super.init(frame: .zero)
        addGestureRecognizers()
        setUpLabelProperties()
    }
    
    public convenience init(preTermText: String? , term: String?) {
        self.init()
        setUpText(preTermText: preTermText, term: term)

    }
    
    public convenience init (preTermText: String?) {
        self.init()
        setUpText(preTermText: preTermText)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: Public interface
    public func getTermRange() -> NSRange? {
        return self.termRangeWithIcon
    }
    
    public func configure(type: TermTextType) {
        resetVariables()
        switch type {
        case .withTermAndPreTermText(let preTermText, let term):
            setupAttributedText(fullTitle:  preTermText + " " + term, term: term, preTermText: preTermText)
        case .withOnlyPreTermText(let preTermText):
            setupAttributedText(preTermText: preTermText)
        }
    }
    
    
    //MARK: Helper Functions
    private func addGestureRecognizers() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.checkboxLabelDidTap(_:)))
        self.addGestureRecognizer(tapGestureRecognizer)
    }
    
    private func resetVariables() {
        termRangeWithIcon = nil
        self.attributedText = nil
    }
    
    private func setUpLabelProperties() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.isUserInteractionEnabled = true
        self.textAlignment = .left
    }
    
    private func setUpText(preTermText: String? , term: String? = nil) {
        if let preTermText = preTermText , let term = term {
            setupAttributedText(fullTitle: preTermText + " " + term, term: term, preTermText: preTermText)
        } else if let preTermText = preTermText {
            setupAttributedText(preTermText: preTermText)
        }
    }
    
    
    private func setupAttributedText(preTermText: String) {
        self.attributedText = NSAttributedString(string: preTermText)
    }
    
    private func setupAttributedText(fullTitle: String, term: String, preTermText: String) {
        guard let range = fullTitle.range(of: term) else { return }
        buildAttributedText(from: fullTitle, term: term, termRange: range)
    }
    
    //MARK: Attributed String
    private func buildAttributedText(from fullTitle: String, term: String, termRange: Range<String.Index>) {
        let attributedString = NSMutableAttributedString(string: fullTitle)
        
        let termWithIcon = getTermWithIcon(term: term)
        
        attributedString.replaceCharacters(in: NSRange(termRange, in: fullTitle), with: termWithIcon)
        
        let start = fullTitle.distance(from: fullTitle.startIndex, to: termRange.lowerBound)
        let length = fullTitle.distance(from: termRange.lowerBound, to: termRange.upperBound)
        
        self.attributedText = attributedString
        self.termRangeWithIcon = NSMakeRange(start, length + 1)
    }
    
    private func getTermWithIcon(term: String) -> NSAttributedString {
        let nsTerm = NSMutableAttributedString(string: term)
        
        let imageAttachment = NSTextAttachment()
            imageAttachment.image = UIImage(systemName: "externaldrive.badge.wifi")
            imageAttachment.bounds = CGRect(x: 2, y: 0, width: 12, height: 12)
        
        let imageString = NSAttributedString(attachment: imageAttachment)
        nsTerm.append(imageString)
        
        return nsTerm
    }
    
    //MARK: User iteraction
    @objc private func checkboxLabelDidTap(_ sender: UITapGestureRecognizer) {
        if let termRange = termRangeWithIcon {
            if sender.didTapAttributedTextInLabel(label: self, inRange: termRange) {
                delegate?.termTextLabelDidTapOnTerm(self)
            } else {
                delegate?.termTextLabelDidTapOnText(self)
            }
        } else {
            delegate?.termTextLabelDidTapOnText(self)
        }
    }
    
}

//MARK: Helpers
private extension UITapGestureRecognizer {
    func didTapAttributedTextInLabel(label: UILabel, inRange targetRange: NSRange) -> Bool {
        // Create instances of NSLayoutManager, NSTextContainer and NSTextStorage
        let layoutManager = NSLayoutManager()
        let textContainer = NSTextContainer(size: CGSize.zero)
        let textStorage = NSTextStorage(attributedString: label.attributedText!)

        // Configure layoutManager and textStorage
        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)

        // Configure textContainer
        textContainer.lineFragmentPadding = 0.0
        textContainer.lineBreakMode = label.lineBreakMode
        textContainer.maximumNumberOfLines = label.numberOfLines
        let labelSize = label.bounds.size
        textContainer.size = labelSize

        // Find the tapped character location and compare it to the specified range
        let locationOfTouchInLabel = self.location(in: label)
        let textBoundingBox = layoutManager.usedRect(for: textContainer)
        let textContainerOffset = CGPoint(
            x: (labelSize.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x,
            y: (labelSize.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y
        )
        let locationOfTouchInTextContainer = CGPoint(
            x: locationOfTouchInLabel.x - textContainerOffset.x,
            y: locationOfTouchInLabel.y - textContainerOffset.y
        )
        let indexOfCharacter = layoutManager.characterIndex(
            for: locationOfTouchInTextContainer,
            in: textContainer,
            fractionOfDistanceBetweenInsertionPoints: nil
        )

        return NSLocationInRange(indexOfCharacter, targetRange)
    }
}


