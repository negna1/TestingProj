
import UIKit

public enum ChipsViewCellType {
    case checkbox
    case standard
    case iconed
}

public protocol ChipsCellViewModel {
    var title: String { get }
    var type: ChipsViewCellType { get }
    var reuseId: String { get }
}

public class StandardChipsCellViewModel: ChipsCellViewModel {
    public var title: String
    public var type: ChipsViewCellType { return .standard}
    public var state: StandardChipsCellState
    public var reuseId: String { return "StandartTabCollectionCell" }
   
    public init(title: String, state: StandardChipsCellState) {
        self.title = title
        self.state = state
    }
}

public class CheckboxChipsCellViewModel: ChipsCellViewModel {
    public var title: String
    public var type: ChipsViewCellType { return .checkbox}
    public var state: CheckboxChipsCellState
    public var reuseId: String { return "CheckBoxTabCollectionCell" }
    
    public init(title: String, state: CheckboxChipsCellState) {
        self.title = title
        self.state = state
    }
}

public class IconedChipsCellViewModel: ChipsCellViewModel {
    
    public var titleType: IconedChipsCellTextType
    public var iconString: String?
    public var type: ChipsViewCellType { return .iconed}
    public var state: IconedChipsCellState
    public var reuseId: String { return "IconedChipsCollectionViewCell" }
    
    public init(titleType: IconedChipsCellTextType, iconString: String?, state: IconedChipsCellState) {
        self.titleType = titleType
        self.iconString = iconString
        self.state = state
    }
    
    public var title: String {
        switch titleType {
        case .singleLine(let text):
            return text
        case .twoLine(let tuple):
            return tuple.topText.count > tuple.bottomText.count ? tuple.topText : tuple.bottomText
        }
    }
    
    public enum IconedChipsCellTextType {
        case singleLine(_ text: String)
        case twoLine((topText: String, bottomText: String))
    }
    
}

public enum IconedChipsCellState {
    case active
    case enabled
    case disabled
    
    var borderColor: UIColor {
        switch self {
        case .active:
            return .green
        case .enabled:
            return .clear
        case .disabled:
            return .lightGray
        }
    }
    
    var backgroundColor: UIColor {
        switch self {
        case .active:
            return .green
        case .enabled:
            return .clear
        case .disabled:
            return .lightGray
        }
    }
    
    var textColor: UIColor {
        switch self {
        case .active:
            return .white
        case .enabled:
            return .black
        case .disabled:
            return .white
        }
    }
}

public enum StandardChipsCellState {
    case active
    case enabled
    case disabled
    
    var borderColor: UIColor {
        switch self {
        case .active:
            return .green
        case .enabled:
            return .clear
        case .disabled:
            return .lightGray
        }
    }
    
    var backgroundColor: UIColor {
        switch self {
        case .active:
            return .green
        case .enabled:
            return .clear
        case .disabled:
            return .lightGray
        }
    }
    
    var titleColor: UIColor {
        switch self {
        case .active:
            return .white
        case .enabled:
            return .black
        case .disabled:
            return .white
        }
    }
    
    
}

public enum CheckboxChipsCellState {
    case active
    case enabled
    case disabled
    case intermediate
}


extension CheckboxChipsCellState {
    
    var checkboxState: CheckBox.State {
        switch self {
        case .enabled:
            return .inactive
        case .active:
            return .active
        case .disabled:
            return .disabled
        case .intermediate:
            return .indeterminate
        }
    }
    
    var attributes: [NSAttributedString.Key : Any] {
        switch self {
        case .active:
            return [NSAttributedString.Key.font: Brandbook.Font.smallButton,
                    NSAttributedString.Key.foregroundColor: UIColor.green]
        default:
            return [NSAttributedString.Key.font: Brandbook.Font.smallButton,
                    NSAttributedString.Key.foregroundColor: UIColor.green]
        }
    }
}
