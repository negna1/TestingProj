
import Foundation

/// Interface for formatter of TextInput, that allow change format of text during input
public protocol TextInputFormatter {
    
    func formatInput(
        currentText: String, range: NSRange, replacementString text: String) -> FormattedTextValue
}
