//
//  MainViewController.swift
//  DTHAS
//
//  Created by Shanezzar Sharon on 15/01/2022.
//

import UIKit
import SDWebImage

class MainViewController: UITableViewController {
    
    // MARK:- variables
    private let searchController = UISearchController(searchResultsController: nil)
    
    var networkModel = NetworkModel()
    
    var searchText: String = ""
    
    
    // MARK:- functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setup()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
    }
    
    func setupUI() {
        self.title = "Welcome to Giphy Lite"
        
        tableView.tableFooterView = UIView()
        tableView.keyboardDismissMode = .onDrag
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl!.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl!)
        
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search gif here..."
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
    }
    
    func setup() {
        tableView.delegate = self
        tableView.dataSource = self
        
        networkModel.delegate = self
        
        searchController.searchResultsUpdater = self
        
        if networkModel.gifs.count == 0 {
            networkModel.refresh(search: searchText)
        }
        
    }
    
    @objc func refresh(_ sender: AnyObject) {
        SoundModel.shared.playRefresh()
        networkModel.refresh(search: searchText)
        
    }
    
}

// MARK:- tableview delegates
extension MainViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return networkModel.gifs.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mainCell", for: indexPath) as! MainCell
        
        cell.gifImageView.sd_imageIndicator = SDWebImageActivityIndicator.large
        cell.gifImageView.sd_setImage(with: URL(string: networkModel.gifs[indexPath.row].image.downsizedMedium.url))
        cell.gifImageView.contentMode = .scaleAspectFill
        cell.gifImageView.layer.cornerRadius = 8
        
        cell.titleLabel.text = networkModel.gifs[indexPath.row].title
        cell.titleLabel.setLineHeight(lineHeight: 6)
        
        cell.usernameLabel.text = networkModel.gifs[indexPath.row].username.isEmpty ? "..." : networkModel.gifs[indexPath.row].username
        cell.usernameLabel.setLineHeight(lineHeight: 6)
        
        if indexPath.row == networkModel.gifs.count - 2 {
            DispatchQueue.main.async {
                self.networkModel.loadMore(search: self.searchText)
            }
        }
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        haptic()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detailViewController = storyboard.instantiateViewController(withIdentifier: "detailViewController") as! DetailViewController
        detailViewController.id = networkModel.gifs[indexPath.row].id
        navigationController?.pushViewController(detailViewController, animated: true)
        
    }
    
}

// MARK:- search controller delegates
extension MainViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        self.searchText = searchController.searchBar.text ?? ""
        networkModel.refresh(search: searchText)
        
    }
    
}

// MARK:- network model delegates
extension MainViewController: NetworkModelDelegate {
    func error(message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Ops!", message: message, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: .destructive, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    func reloadTable() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.refreshControl!.endRefreshing()
        }
        
    }
    
}
