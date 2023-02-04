

import Foundation

public enum BRLocalization: String, CaseIterable {
    case en = "en"
    case ka = "ka"

    static let defaultFile: String = "Base"
    static let `extension`: String = "lproj"
}

public class LocalizationManager {
    
    public static var shared = LocalizationManager()
    var currentLanguage: BRLocalization {
        guard let savedLanguage = UserDefaults.standard.value(
                forKey: "APP_LANGUAGE") as? String,
              let locale = BRLocalization(rawValue: savedLanguage) else {
            return .ka
        }
        
        return locale
    }
    
    public func localizedValue(for text: String) -> String {
         text.split(separator: " ")
            .map { bundledTextToValue(text: String($0)) }.joined(separator: " ")
    }
    
    private func bundledTextToValue(text: String) -> String {
        let splited = text.split(separator: "-")
        guard let bundle = splited.first,
              let key = splited.last else {
            return loadKeyFromDefaultBundle(key: text)
        }
        
        return load(key: String(key), from: String(bundle))
    }
    
    private func load(key: String, from bundle: String) -> String {
        guard let moduleBundle = Bundle(identifier: bundle),
              let localizationPath = moduleBundle.path(forResource: currentLanguage.rawValue, ofType: BRLocalization.extension),
              let localization = Bundle(path: localizationPath) else {
            return key
        }
        
        return localization.localizedString(forKey: key, value: nil, table: nil)
    }
    
    private func loadKeyFromDefaultBundle(key: String) -> String {
        guard let localizationPath = Bundle.main.path(forResource: BRLocalization.defaultFile, ofType: BRLocalization.extension),
              let localization = Bundle(path: localizationPath) else  {
            return key
        }
        
        return localization.localizedString(forKey: key, value: nil, table: nil)
    }
}
