//
//  ViewController.swift
//  SWG
//
//  Created by Максим Сулим on 26.06.2023.
//

import UIKit

class ViewController: UIViewController {
    
    
 
    
    @IBOutlet weak var tableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }


}



extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 || indexPath.row % 2 == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell0", for: indexPath) as? FirstTableViewCell
            cell?.nameLableCello.text = "0 Cell"
            cell?.descriptionLableCell0.text = "0 Cell description long"
            return cell!
        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell1", for: indexPath) as? SecondTableViewCell
            cell?.nameLableCell1.text = "1 Cell"
            cell?.descriptionLableCell1.text = "1 Cell description long"
            return cell!
            
        }
        
    }
    
    
}
