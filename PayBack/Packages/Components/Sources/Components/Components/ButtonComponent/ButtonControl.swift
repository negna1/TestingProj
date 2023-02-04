

import Foundation

public typealias ButtonAction = () -> Void

public protocol ButtonControl {
    
    var isEnabled: Bool { get set}
    func action( handler: ButtonAction?)
}

public protocol LoadableButtonControl: ButtonControl {
    
    var isLoading: Bool { get set}
}
