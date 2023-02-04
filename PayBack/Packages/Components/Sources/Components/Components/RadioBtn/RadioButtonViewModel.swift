

import UIKit



extension RadioButton {
    
    /// Model for Radio button component
    public struct ViewModel {
        let text: String?
        let state: RadioButton.State
        
        /// - Parameters:
        ///   - title: text for label
        ///   - state: default value is enabled
        public init(
            text: String? = nil,
            state: RadioButton.State = .enabled(onTap: nil)) {
            
            self.text = text
            self.state = state
        }
    }
}
