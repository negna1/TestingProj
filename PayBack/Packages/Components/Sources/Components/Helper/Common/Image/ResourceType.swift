

import UIKit
import SDWebImage

public enum ResourceType {
    case localImage(UIImage?)
    case remoteImage(URL)
}

extension ResourceType {
    
    func image(with callback: @escaping (UIImage?) -> ()) {
        switch self {
        case .localImage(let image):
            callback(image)
        case .remoteImage(let url):
            SDWebImageDownloader.shared.downloadImage(with: url) { (image, _, _, _) in
                callback(image)
            }
        }
    }
}
