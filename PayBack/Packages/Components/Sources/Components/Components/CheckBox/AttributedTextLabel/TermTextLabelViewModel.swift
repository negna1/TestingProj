

import UIKit


extension TermTextLabel {
    public enum TermTextType {
        case withOnlyPreTermText(preTermText: String)
        case withTermAndPreTermText(preTermText: String, term: String)
    }
}
