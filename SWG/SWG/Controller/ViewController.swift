//
//  ViewController.swift
//  SWG
//
//  Created by Максим Сулим on 26.06.2023.
//

import UIKit

protocol VCSourceProtocol: AnyObject {
    func segueImage(index: Int)
}

class ViewController: UIViewController, VCSourceProtocol {
    
    
    func segueImage(index: Int) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let imageViewController = storyboard.instantiateViewController(withIdentifier: "ImageViewController") as? ImageViewController else {
            return
        }
        if self.segmentedControl.selectedSegmentIndex == 0 {
            imageViewController.urlImage = dataITunes[index].artworkUrl100
            imageViewController.segment = 0
        } else {
            imageViewController.urlImage = dataGit[index].avatarURL
            imageViewController.segment = 1
        }
        imageViewController.modalPresentationStyle = .fullScreen
        imageViewController.modalTransitionStyle = .crossDissolve
        present(imageViewController, animated: true)
    }
    
    var urlImage: String?
    
    
    var dataITunes = [ResultsDataITunes]()
    var dataGit = [ResultsDataGit]()
    var timer: Timer?
    var url: String?
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    
    
    private func loadITunes(name: String) {
        let urlString = "https://itunes.apple.com/search?term=\(name)"
        NetworkData.shared.workDataITunes(urlString: urlString) { result, error in
            
            if error == nil {
               
                guard let resultData = result else {
                    return
                }
                self.dataITunes = resultData.results
                self.tableView.reloadData()
                
            } else {
                print(error!.localizedDescription)
                
            }
        }
    }
    
    
    private func loadGit(name: String) {
        let urlString = "https://api.github.com/search/users?q=\(name)"
        NetworkData.shared.workDataGitUsers(urlString: urlString) { result, error in
            
            if error == nil {
               
                guard let resultItem = result else {
                    return
                }
                self.dataGit = resultItem.items
                self.tableView.reloadData()
                
            } else {
                print(error!.localizedDescription)
            }
        }
    }
    
    
    @IBAction func choiceSearch(_ sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 0 {
            self.searchBar.text = ""
            self.tableView.reloadData()
        } else if sender.selectedSegmentIndex == 1 {
            self.searchBar.text = ""
            self.tableView.reloadData()
        }
        
    }
    private func outErrorSearch() {
        let error = UIAlertController(title: "Поиск не дал результатов", message: "Бывает такое", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Попробовать снова", style: .cancel)
        error.addAction(cancel)
        self.present(error, animated: true)
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if self.segmentedControl.selectedSegmentIndex == 0 {
          return dataITunes.count
        } else {
          return dataGit.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if self.segmentedControl.selectedSegmentIndex == 0 {
        
            if indexPath.row == 0 || indexPath.row % 2 == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "Cell0", for: indexPath) as? FirstTableViewCell
                cell?.configureFirstCellITunes(text: dataITunes[indexPath.row], index: indexPath.row)
                cell?.delegate = self
                return cell!
            } else {
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "Cell1", for: indexPath) as? SecondTableViewCell
                
                cell?.configureSecondCellITunes(text: dataITunes[indexPath.row], index: indexPath.row )
                cell?.delegate = self
                return cell!
                
            }
            
        } else  {
            if indexPath.row == 0 || indexPath.row % 2 == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "Cell1", for: indexPath) as? SecondTableViewCell
                cell?.configureSecondCellIGit(text: dataGit[indexPath.row], index: indexPath.row)
                cell?.delegate = self
                return cell!
            } else {
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "Cell0", for: indexPath) as? FirstTableViewCell
                cell?.configureFirstCellIGit(text: dataGit[indexPath.row], index: indexPath.row)
                cell?.delegate = self
                return cell!
                
            }
        }
    }
}


extension ViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if self.segmentedControl.selectedSegmentIndex == 0 {
            self.tableView.reloadData()
            
            if searchText.isEmpty == false {
                timer?.invalidate()
                timer = Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false, block: { [weak self]_ in
                    self?.loadITunes(name: searchText)
                    
                })
                timer = Timer.scheduledTimer(withTimeInterval: 5, repeats: false, block: { [weak self]_ in
                    
                    if self!.dataITunes.count == 0 {
                        self?.outErrorSearch()
                    }
                    
                })
            }
            
        } else if self.segmentedControl.selectedSegmentIndex == 1 {
            self.tableView.reloadData()
            
            if searchText.isEmpty == false {
                timer?.invalidate()
                timer = Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false, block: { [weak self]_ in
                    self?.loadGit(name: searchText)
                    
                })
                timer = Timer.scheduledTimer(withTimeInterval: 5, repeats: false, block: { [weak self]_ in
                    
                    if self!.dataGit.count == 0 {
                        self?.outErrorSearch()
                    }
                    
                })
                
                
            }
            
        }
    }
    
}


