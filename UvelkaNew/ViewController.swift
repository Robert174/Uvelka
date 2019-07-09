//
//  ViewController.swift
//  UvelkaNew
//
//  Created by Роберт Райсих on 09/07/2019.
//  Copyright © 2019 Роберт Райсих. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    let cellId = "cellId"
    var names = [ExpandableMarks(isExpanded: true, marks: ["cs", "sdsd", "sdsd", "sdsd"]),
                 ExpandableMarks(isExpanded: true, marks: ["ad", "as", "sdsd", "sdsd", "sdsd", "sdsd"]),
                 ExpandableMarks(isExpanded: true, marks: ["af", "sdsd", "sdsd", "sdsd", "sdsd", "sdcsdc", "sdsd", "sdsd", "sdsd", "sdsd", "sdsd", "sdsd"])]
    
    
    
    
    let cameraButton = UIBarButtonItem(image: UIImage(named: "ic_photo"), style: .plain, target: self, action: #selector(getter: UIDynamicBehavior.action))
    let searchBar:UISearchBar = UISearchBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createNavigationBar()
        createSearchBar()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        
    }
    
    func createSearchBar(){
        
        searchBar.searchBarStyle = UISearchBar.Style.prominent
        searchBar.placeholder = "Поиск"
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        searchBar.searchBarStyle = UISearchBar.Style.minimal
        tableView.tableHeaderView = searchBar
        tableView.tableHeaderView?.backgroundColor = UIColor(red: 0xf8, green: 0xf7, blue: 0xf5, alpha: 0.5)
    }
    
    func createNavigationBar(){
        navigationItem.title = "Отчет"
        navigationItem.rightBarButtonItem  = cameraButton
        navigationItem.rightBarButtonItem?.tintColor = UIColor.black
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let button = UIButton(type: .system)
        button.setTitle("Header", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        
        button.addTarget(self, action: #selector(handleOpenClose), for: .touchUpInside)
        
        button.tag = section
        
        return button
        
    }
    
    @objc func handleOpenClose(button: UIButton) {
        
        let section = button.tag
        var indexPaths = [IndexPath]()
        
        
        for row in names[section].marks.indices {
            let indexPath = IndexPath(row: row, section: section)
            indexPaths.append(indexPath)
        }
        
        let isExpanded = names[section].isExpanded
        
        names[section].isExpanded = !isExpanded
        
        if isExpanded{
            tableView.deleteRows(at: indexPaths, with: .fade)
        } else {
            tableView.insertRows(at: indexPaths, with: .fade)
        }
        
    }
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if names[section].isExpanded{
            return names[section].marks.count
        }
        
        return 0
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return names.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        let name = names[indexPath.section].marks[indexPath.row]
        cell.textLabel?.text = name
        
        return cell
    }

}

