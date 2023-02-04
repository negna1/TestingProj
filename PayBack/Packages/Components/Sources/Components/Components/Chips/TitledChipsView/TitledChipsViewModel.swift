

import Foundation

public struct TitledChipsViewModel {
    let infoText: String
    let chipsViewModel: ChipsViewModel
    
    public init(infoText: String,
                chipsViewModel: ChipsViewModel) {
        self.infoText = infoText
        self.chipsViewModel = chipsViewModel
    }
}
