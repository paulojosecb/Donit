import UIKit
import DetailUI
import HomeUI

public class Coordinator {
    var navigationController: UINavigationController
    
    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    public func start() {
        let viewController = DetailViewController()
        navigationController.pushViewController(viewController, animated: true)
    }
}
