//
//  SearchVC.swift
//  miniMusic
//
//  Created by Mark Goncharov on 09.08.2022.
//

import UIKit
import Alamofire

class SearchMusicVC: UITableViewController {
    
    var networkServise = NetworkService()
    var tracks = [Track]()
    
    let searchController = UISearchController(searchResultsController: nil)
    
    private var timer: Timer?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        setupSearchBar()
        view.backgroundColor = .white
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
        searchController.searchBar.delegate = self
    }
}

//MARK: - setitng Table View

extension SearchMusicVC {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tracks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        let tracks = tracks[indexPath.row]
        cell.textLabel?.text = "\(tracks.trackName)\n\(tracks.artistName)"
        cell.textLabel?.numberOfLines = 2
        cell.imageView?.image = #imageLiteral(resourceName: "Image")
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
}

//MARK: - setitng Search Bar

extension SearchMusicVC: UISearchBarDelegate {
    
    private func setupSearchBar() {
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (_) in
            
            self.networkServise.fetchTracks(searchText: searchText) { [ weak self ](searchResults) in
                self?.tracks = searchResults?.results ?? []
                self?.tableView.reloadData()
            }
        })
    }
}

// MARK: - SwiftUI

import SwiftUI

struct SearchVCProvider: PreviewProvider {
    
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        
        let tabBarVC = MainTabBarController()
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<SearchVCProvider.ContainerView>) -> MainTabBarController {
            return tabBarVC
        }
        
        func updateUIViewController(_ uiViewController: SearchVCProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<SearchVCProvider.ContainerView>) {
        }
    }
}
