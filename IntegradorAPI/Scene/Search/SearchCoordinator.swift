

import UIKit

class SearchCoordinator: Coordinator {
    var navigation: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigation = navigationController
    }
    
    func start() {
        let searchVC = SearchViewController()
        navigation.pushViewController(searchVC, animated: true)
    }
}
