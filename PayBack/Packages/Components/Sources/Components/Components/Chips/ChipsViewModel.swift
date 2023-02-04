

import Foundation

public struct ChipsViewModel {
    let dataSource: [ChipsCellViewModel]
    let delegate: ChipsViewDelegate?
    let centerSelectedItem: Bool
    let didChangeIndex: ((_ index: Int) -> Void)?
    
    public init(dataSource: [ChipsCellViewModel] = [],
                delegate: ChipsViewDelegate? = nil,
                centerSelectedItem: Bool = true,
                didChangeIndex: ((_ index: Int) -> Void)? = nil) {
        self.dataSource = dataSource
        self.delegate = delegate
        self.centerSelectedItem = centerSelectedItem
        self.didChangeIndex = didChangeIndex
    }
}
