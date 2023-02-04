

import Foundation

public protocol TextUnformatter {
    /**
     Method for convert string, that sutisfy current textPattern, into unformatted string
     
     - Parameters:
     - formatted: String to convert
     
     - Returns: String converted into unformatted
     */
    func unformat(_ formattedText: String?) -> String?
}
