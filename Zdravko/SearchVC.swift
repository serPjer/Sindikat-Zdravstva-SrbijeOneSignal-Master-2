//
//  SearchVC.swift
//  Sindikat Zdravstva Srbije
//
//  Created by Petar Stijepcic on 4/16/20.
//  Copyright © 2020 2ADesign. All rights reserved.
//

import UIKit

class SearchVC: UIViewController, UITabBarControllerDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainTable = searchTableView
        
        searchTableView.dataSource = self
        searchTableView.delegate = self
        searchBar.delegate = self
        setImages()
//        self.tabBarController?.delegate = self
        
    }
    
//    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
//        let tabBarIndex = tabBarController.selectedIndex
//        if tabBarIndex == 1 {
//            createAlert(title: "Подаци се учитавају", message: "Mолим вас сачекајте")
//        }
//    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        let image: UIImage = UIImage(named: "sindikat")!
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        imageView.contentMode = .scaleAspectFit
        imageView.image = image
        self.navigationItem.titleView = imageView
        
        
    }
    
    func createAlert (title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Уреду", style: UIAlertAction.Style.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
}


extension SearchVC: UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return currentSearchArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath) as? SearchCell else { return UITableViewCell()}
        
        
        
        cell.titleTextSearch.text = currentSearchArray[indexPath.row].titleName
        cell.searchImage.image = currentSearchArray[indexPath.row].image
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        searchIndex = indexPath.row
        
        
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            currentSearchArray = searchArraytest
            searchTableView.reloadData()
            return
        }
        currentSearchArray = searchArraytest.filter({ searchArraytest -> Bool in
            searchArraytest.titleName.lowercased().contains(searchText.lowercased())
            
        })
        searchTableView.reloadData()
        
    }
}
