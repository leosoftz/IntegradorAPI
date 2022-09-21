//
//  HomeViewController.swift
//  IntegradorAPI
//
//  Created by Leonardo Agustin Zabala on 19/09/2022.
//

import UIKit
import IQKeyboardManager
import AndesUI

class HomeViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        if UserDefaults.standard.object(forKey: "token") != nil {
            UserDefaults.standard.removeObject(forKey: "token")
        }
        setupTabBar()
    }
    
    func setupTabBar() {
        let searchIconAndes = UIImage(named: "andes_control_y_accion_buscar_24",
                                              in: AndesBundle.bundle(),
                                              compatibleWith: nil)
        let item0 = SearchViewController()
        let nav0 = UINavigationController(rootViewController: item0)
        let icon0 = UITabBarItem(title: nil, image: searchIconAndes, selectedImage: searchIconAndes)
        item0.tabBarItem = icon0
        let item1 = FavoritesViewController()
        let nav1 = UINavigationController(rootViewController: item1)
        let favIconAndes = UIImage(named: "andes_navegacion_favoritos_24",
                                              in: AndesBundle.bundle(),
                                              compatibleWith: nil)
        let icon1 = UITabBarItem(title: nil, image: favIconAndes, selectedImage: favIconAndes)
        item1.tabBarItem = icon1
        self.viewControllers = [nav0, nav1]
    }
}
