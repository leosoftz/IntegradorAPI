//
//  SearchViewController.swift
//  IntegradorAPI
//
//  Created by Leonardo Agustin Zabala on 19/09/2022.
//

import UIKit
import Alamofire
import Foundation
import AndesUI

class SearchViewController: UIViewController, SearchViewModelDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
   
    @IBOutlet weak var tableResultados: UITableView!
    
    var searchResults = [ResultWrapper]()
    var viewModel: SearchViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        self.viewModel = SearchViewModel(delegate: self)
        setupSearchBar()
        setupTable()
        // Do any additional setup after loading the view.
    }
    
    func load(query: String) {
        self.searchResults.removeAll()
        self.tableResultados.reloadData()
        self.viewModel.loadData(query: query) { searchResults in
            self.searchResults = searchResults
            self.tableResultados.reloadData()
        }
    }
    
    func setupTable() {
        tableResultados.delegate = self
        tableResultados.dataSource = self
        tableResultados.rowHeight = 100
    }
    
    func setupSearchBar() {
        let textFieldInsideUISearchBar = searchBar.value(forKey: "searchField") as? UITextField
        textFieldInsideUISearchBar?.textColor = .Andes.gray900
        searchBar.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    func reloadData() {
        self.tableResultados.reloadData()
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchResults = [ResultWrapper]()
        load(query: searchBar.text!)
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentProduct = searchResults[indexPath.row]
        tableResultados.register(UINib(nibName: "ResultTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "resultCell")
        var cell = tableView.dequeueReusableCell(withIdentifier: "resultCell") as? ResultTableViewCell
        if cell == nil {
            cell = ResultTableViewCell(style: .default, reuseIdentifier: "resultCell")
        }
        cell?.loadWithData(currentProduct)
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let product = ProductCoordinator(navigationController: self.navigationController!, product: self.searchResults[indexPath.row])
        product.start()
    }
}

extension SearchViewController {
    func showError(error: String) {
        let bar = AndesSnackbar(text: error, duration: .short, type: .error)
        bar.show()
    }
}
