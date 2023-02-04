
import Foundation
import SDWebImage

public struct Brandbook {
    
    public static func configureSDWebImage(with token: String) {
        SDWebImageDownloader.shared.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
    }
}

