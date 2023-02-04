
import UIKit

// MARK: - TappableModels
public typealias RowItemelementTapHandler = (TappableReusable) -> ()

public protocol TappableReusable {
    var restorationId: String? { get }
    var onTap: RowItemelementTapHandler? { get }
}

public struct TappableRowItemImage: TappableReusable {
    public var restorationId: String?
    public var image: UIImage
    public var tint: UIColor?
    public var onTap: RowItemelementTapHandler?
    
    
   public init(
         id: String?,
         onTap: RowItemelementTapHandler?,
         image: UIImage,
         tint: UIColor? = nil) {
        
        self.restorationId = id
        self.onTap = onTap
        self.image = image
        self.tint = tint
    }
}

public struct TappableRowItemRemoteImage: TappableReusable {
    public var restorationId: String?
    public var onTap: RowItemelementTapHandler?
    public var imageUrl: URL
    
    public init(
        id: String?,
        onTap: RowItemelementTapHandler?,
        imageUrl: URL) {
        
        self.restorationId = id
        self.onTap = onTap
        self.imageUrl = imageUrl
    }
}

public struct TappableOvalIcon: TappableReusable {
    public var restorationId: String?
    public var onTap: RowItemelementTapHandler?
    public var ovalIconModel: ThumbnailOvalicon.ViewModel
    
    public init(
        restorationId: String? = nil,
        onTap: RowItemelementTapHandler?,
        model: ThumbnailOvalicon.ViewModel) {
        
        self.restorationId = restorationId
        self.onTap = onTap
        self.ovalIconModel = model
    }
}
