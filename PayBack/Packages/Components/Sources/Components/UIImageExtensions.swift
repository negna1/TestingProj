

import UIKit

public extension UIImage {
    convenience init?(placeholderImageType: PlaceholderImageType) {
        self.init(systemName: "hand.thumbsup.fill")
    }
    
    enum PlaceholderImageType: String {
        case scale1_1 = "thumbnail1_1"
        case scale3_2 = "thumbnail3_2"
        case scale4_3 = "thumbnail4_3"
        case scale16_9 = "thumbnail16_9"
        case scale21_6 = "thumbnail21_6"
        case scale32_9 = "thumbnail32_9"
        case circle = "thumbnailCircle"
    }
}


public extension UIImage {
    func resizedTo(newWidth: CGFloat) -> UIImage? {
        let height = (newWidth/self.size.width)*self.size.height
        return self.resizedTo(size: CGSize(width: newWidth, height: height))
    }

    func resizedTo(newHeight: CGFloat) -> UIImage? {
        let width = (newHeight/self.size.height)*self.size.width
        return self.resizedTo(size: CGSize(width: width, height: newHeight))
    }

    func resizedTo(size: CGSize) -> UIImage? {
        let widthRatio = size.width / self.size.width
        let heightRatio = size.height / self.size.height
        var updateSize = size
        if(widthRatio > heightRatio) {
            updateSize = CGSize(width: self.size.width*heightRatio, height: self.size.height * heightRatio)
        } else if heightRatio > widthRatio {
            updateSize = CGSize(width: self.size.width * widthRatio, height: self.size.height * widthRatio)
        }
        UIGraphicsBeginImageContextWithOptions(updateSize, false, UIScreen.main.scale)
        self.draw(in: CGRect(origin: .zero, size: updateSize))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
}
