

import UIKit

public extension RowImageView {
    enum `Type` {
        case icon16x16
        case icon24x24
        case roundedImage
    }
}

extension RowImageView.`Type` {
    var size: CGSize {
        switch self {
        case .icon24x24:
            return .init(width: 24, height: 24)
        case .icon16x16:
            return .init(width: 16, height: 16)
        case .roundedImage:
            return .init(width: 36, height: 36)
        }
    }
}
