

import Foundation
import UIKit

struct SmallButtonComponentFactory {
    static func getButton(icon: UIImage?, bordered: Bool) -> SmallButtonComponentViewModelProtocol  {
        var viewModel:SmallButtonComponentViewModelProtocol?
        
        if icon == nil && bordered == false {
            viewModel = SmallButtonComponentViewModel()
        }
        else if icon == nil && bordered == true {
            viewModel = SmallButtonBorderedComponentViewModel()
        }
        else if icon != nil && bordered == false {
            viewModel = SmallButtonIconComponentViewModel()
        }
        
        return viewModel!
    }
}
