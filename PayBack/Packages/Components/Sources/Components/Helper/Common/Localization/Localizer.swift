

import Foundation

public enum LocalizationLanguage: String {
    case georgian = "ka"
    case english = "en"
}

public final class Localizer {
    
    private var providers = [LocalizationProvider]()
    private(set) public var language: LocalizationLanguage = .georgian
    
    public static var shared = Localizer()
    
    private init() {
        providers = [BrandBookLocalizationProvider()]
    }
    
    public func localizedValue(for key: String) -> String {
        guard !key.isEmpty else { return key }
        for provider in providers {
            let localized = provider.localizedString(forKey: key, language: language)
            if localized != key {
                return localized
            }
        }
        return key
    }
    
    public func addProvider(_ provider: LocalizationProvider) {
        let allProviders = providers + [provider]
        providers = allProviders.sorted {
            $0.priority > $1.priority
        }
    }
    
    public func setLanguge(code: String) {
        language = LocalizationLanguage(rawValue: code) ?? .georgian
    }
}
