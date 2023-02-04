

import UIKit

public enum StatusBadgeType {
    case success
    case error
    case warning
    case waiting
    
    
    var content: UIView {
        switch self {
        case .success:
            return StatusBadgeType.imageView(with: StatusBadgeConsts.Content.Success.icon,
                                             tintColor: StatusBadgeConsts.Content.Success.color)
        case .error:
            return StatusBadgeType.imageView(with: StatusBadgeConsts.Content.Error.icon,
                                             tintColor: StatusBadgeConsts.Content.Error.color)
        case .warning:
            return StatusBadgeType.imageView(with: StatusBadgeConsts.Content.Warning.icon,
                                             tintColor: StatusBadgeConsts.Content.Warning.color)
        case .waiting:
            let spinner = UIActivityIndicatorView(style: .gray)
            spinner.translatesAutoresizingMaskIntoConstraints = false
            spinner.startAnimating()
            return spinner
        }
    }
    
    private static func imageView(with image: String, tintColor: UIColor) -> UIImageView {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "hand.thumbsup.fill")
        imageView.tintColor = tintColor
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }
}
