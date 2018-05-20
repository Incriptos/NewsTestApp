//
//  NewsViewController.swift
//  NewsTestApp
//
//  Created by Andrew Vashulenko on 02.03.2018.
//  Copyright © 2018 Andrew Vashulenko. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController {
    
    var categories = ["top-headlines?country=us&category=business",
                      "everything?q=bitcoin&sortBy=publishedAt",
                      "top-headlines?sources=techcrunch",
                      "everything?q=apple&from=2018-03-04&to=2018-03-04&sortBy=popularity", "everything?domains=wsj.com"]
    
    var categoryId = 0 {
        didSet(newId) {
            
            getCategory(source: categories[newId])
        }
    }
    
    
    @IBOutlet weak var selectCatagory: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    
    var dataSource : [Articles] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    var postURL: URL?

    override func viewDidLoad() {
        super.viewDidLoad()

       getCategory(source: categories[categoryId])
        
        
    }

    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "newsDetails" {
            let NVC = segue.destination
            let vc = NVC.childViewControllers[0] as? DetailViewController
            vc?.url = postURL!
        }
    }
    
    func getCategory(source: String) {
        
        NetworkService.shared.downloadJSON(source: source, onSuccess: { (result) in
            self.dataSource = result.articles!
        }) { (error) in
            print(error)
        }
        
    }
    
    func categorySelection() {
        
        let optionMenu = UIAlertController(title: nil, message: "Choose Category", preferredStyle: .actionSheet)
        
        let buisness = UIAlertAction(title: "Buisness", style: .default) { (action) in
            self.categoryId = 0
        }
        let bitcoin = UIAlertAction(title: "Bitcoin", style: .default) { (action) in
            self.categoryId = 1
        }
        let techCrunch = UIAlertAction(title: "TechCrunch", style: .default) { (action) in
            self.categoryId = 2
        }
        let apple = UIAlertAction(title: "Apple", style: .default) { (action) in
            self.categoryId = 3
        }
        let wsj = UIAlertAction(title: "Wall Street Journal", style: .default) { (action) in
            self.categoryId = 4
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            print("Cancel")
        }
        
        optionMenu.addAction(buisness)
        optionMenu.addAction(bitcoin)
        optionMenu.addAction(techCrunch)
        optionMenu.addAction(apple)
        optionMenu.addAction(wsj)
        optionMenu.addAction(cancel)

        self.present(optionMenu, animated: true, completion: nil)
    }
    
    //MARK: - Actions
    
    @IBAction func selectCatagory(_ sender: UIButton) {
        categorySelection()
    }
}


extension NewsViewController: UITableViewDataSource, UITableViewDelegate {
    
    //MARK: - TableView
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        if let url = dataSource[indexPath.row].urlToImage  {
            cell.imageView?.contentMode = .scaleAspectFit
            cell.imageView?.imageFromServerURL(urlString: url, PlaceHolderImage: UIImage(named: "load")!)
        
        }
        cell.textLabel?.text = dataSource[indexPath.row].title
        cell.detailTextLabel?.text = dataSource[indexPath.row].description
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 88.0
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        postURL = URL(string: dataSource[indexPath.row].url!)
        self.performSegue(withIdentifier: "newsDetails", sender: nil)
    }
    
    
}


