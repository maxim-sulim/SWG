//
//  ViewController.swift
//  SWG
//
//  Created by Максим Сулим on 26.06.2023.
//

import UIKit

class ViewController: UIViewController {
    
    var dataITunes = [ResultsData]()
    var timer: Timer?
    
    
    var arrContentNameGit = [String]()
    var arrContentDescrGit = [String]()
    
    var filtredSearch = [String]()
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadContentGit()
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    
    
    private func loadContentGit() {
        arrContentNameGit.append(contentsOf: ["LADA", "dina", "LASA", "aleks","LADA"])
        arrContentDescrGit.append(contentsOf: ["kruti", "kaif", "depression", "cool", "jjj"])
    }
    
    private func loadITunes(name: String) {
        let urlString = "https://itunes.apple.com/search?term=\(name)"
        NetworkData.shared.workData(urlString: urlString) { welcome, error in
            
            if error == nil {
               
                guard let resultData = welcome else {
                    return
                }
                self.dataITunes = resultData.results
                print(self.dataITunes)
                self.tableView.reloadData()
                
            } else {
                print(error!.localizedDescription)
                
            }
            
        }
    }
    
    
    @IBAction func choiceSearch(_ sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 0 {
            self.tableView.reloadData()
        } else if sender.selectedSegmentIndex == 1 {
            filtredSearch = arrContentNameGit
            self.tableView.reloadData()
        }
        
    }
}



extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if self.segmentedControl.selectedSegmentIndex == 0 {
          return dataITunes.count
        } else {
          return arrContentNameGit.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if self.segmentedControl.selectedSegmentIndex == 0 {
        
            if indexPath.row == 0 || indexPath.row % 2 == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "Cell0", for: indexPath) as? FirstTableViewCell
                
                cell?.configureFirstCell(text: dataITunes[indexPath.row])
                return cell!
            } else {
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "Cell1", for: indexPath) as? SecondTableViewCell
                
                cell?.configureFirstCell(text: dataITunes[indexPath.row])
                return cell!
                
            }
            
        } else  {
            if indexPath.row == 0 || indexPath.row % 2 == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "Cell0", for: indexPath) as? FirstTableViewCell
                //cell?.configureFirstCell(text: dataITunes[indexPath.row])
                cell?.nameLableCello.text = arrContentNameGit[indexPath.row]
                cell?.descriptionLableCell0.text = arrContentDescrGit[indexPath.row]
                return cell!
            } else {
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "Cell1", for: indexPath) as? SecondTableViewCell
                //cell?.configureFirstCell(text: dataITunes[indexPath.row])
                cell?.nameLableCell1.text = arrContentNameGit[indexPath.row]
                cell?.descriptionLableCell1.text = arrContentDescrGit[indexPath.row]
                return cell!
                
            }
        }
    }
}

extension ViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if self.segmentedControl.selectedSegmentIndex == 0 {
            
            if searchText.isEmpty == false {
                timer?.invalidate()
                timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { [weak self]_ in
                    self?.loadITunes(name: searchText)
                })
                
            }
            
        } else if self.segmentedControl.selectedSegmentIndex == 1 {
            self.tableView.reloadData()
            filtredSearch = arrContentNameGit
            
            if searchText.isEmpty == false {
                filtredSearch = arrContentNameGit.filter({$0.contains(searchText)})
            }
        }
        
        
    }
    
}


