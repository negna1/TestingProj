

import Foundation
import UIKit

struct SecondaryButtonComponentFactory {
    static func getButton(image: UIImage?, dashed: Bool) -> SecondaryButtonComponentViewModelProtocol  {
        var viewModel:SecondaryButtonComponentViewModelProtocol?
        
        if image == nil && !dashed {
            viewModel = SecondaryButtonComponentViewModel()
        }
            
        else if image == nil && dashed {
            viewModel = SecondaryDashedButtonComponentViewModel()
        }
            
        else if image != nil && !dashed {
            viewModel = SecondaryIconButtonComponentViewModel()
        }
            
        else if image != nil && dashed {
            viewModel = SecondaryIconedDashedButtonComponentViewModel()
        }
        
        return viewModel!
    }
}
