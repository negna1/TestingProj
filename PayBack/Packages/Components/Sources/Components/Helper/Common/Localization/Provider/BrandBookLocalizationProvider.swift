

import Foundation

final class BrandBookLocalizationProvider: LocalizationProvider {
    
    let priority: Int = 1
    
    func localizedString(forKey key: String, language: LocalizationLanguage) -> String {
        
        func value(for key: String) -> String {
            let bundle = Bundle(for: Self.self)
            
            guard
                let localizationPath = bundle.path(forResource: language.rawValue, ofType: "lproj"),
                let localizationBundle = Bundle(path: localizationPath)
            else { return key }
            
            return localizationBundle.localizedString(forKey: key, value: nil, table: nil)
        }
        
        return key.split(separator: " ")
           .map { value(for: String($0)) }.joined(separator: " ")
    }
}
