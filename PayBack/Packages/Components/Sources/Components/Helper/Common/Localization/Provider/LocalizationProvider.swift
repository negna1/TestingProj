

import Foundation

public protocol LocalizationProvider: AnyObject {
    var priority: Int { get }
    
    func localizedString(forKey key: String, language: LocalizationLanguage) -> String
}

public extension LocalizationProvider {
    
    func localizedString(forKey key: String, language: LocalizationLanguage) -> String {
        let bundle = Bundle(for: Self.self)
        
        guard
            let localizationPath = bundle.path(forResource: language.rawValue, ofType: "lproj"),
            let localizationBundle = Bundle(path: localizationPath)
        else { return key }
        
        return localizationBundle.localizedString(forKey: key, value: nil, table: nil)
    }
}
