//
//  FavoritesViewController.swift
//  IntegradorAPI
//
//  Created by Leonardo Agustin Zabala on 19/09/2022.
//

import UIKit
import AndesUI

class FavoritesViewController: UIViewController {
    let viewModel = FavoritesViewModel()
    
    @IBOutlet weak var tableFavorites: UITableView!
    
    @IBOutlet var btnReload: UIButton!
    
    var favorites = [ResultWrapper]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTable()
        setupBtnReload()
    }
    
    func setupTable() {
        tableFavorites.delegate = self
        tableFavorites.allowsSelection = true
        tableFavorites.dataSource = self
        tableFavorites.rowHeight = 100
    }
    
    func data() {
        self.favorites.removeAll()
        self.viewModel.loadFavorites { favorites in
            self.favorites = favorites
            print("favorites: \(favorites)")
            self.tableFavorites.reloadData()
        }
    }
    
    func setupBtnReload() {
        let imageRefresh = UIImage(named: "andes_ui_refresh_20", in: AndesBundle.bundle(), with: nil)
        self.btnReload.setImage(imageRefresh, for: .normal)
        self.btnReload.tintColor = .black
    }
    
    @IBAction func btnReload(_ sender: Any) {
        self.data()
        self.tableFavorites.reloadData()
    }

    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
        self.data()
        self.tableFavorites.reloadData()
    }
    
    func reloadData() {
        self.tableFavorites.reloadData()
    }

}

extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentProduct = favorites[indexPath.row]
        tableFavorites.register(UINib(nibName: "ResultTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "resultCell")
        var cell = tableView.dequeueReusableCell(withIdentifier: "resultCell") as? ResultTableViewCell
        if cell == nil {
            cell = ResultTableViewCell(style: .default, reuseIdentifier: "resultCell")
        }
        cell?.loadWithData(currentProduct)
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let product = ProductCoordinator(navigationController: self.navigationController!, product: self.favorites[indexPath.row])
        product.start()
    }
    
}
