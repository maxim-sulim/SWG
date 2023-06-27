//
//  FirstTableViewCell.swift
//  SWG
//
//  Created by Максим Сулим on 26.06.2023.
//

import UIKit

class FirstTableViewCell: UITableViewCell {

    
    @IBOutlet weak var imageCell0: UIImageView!
    @IBOutlet weak var nameLableCello: UILabel!
    @IBOutlet weak var descriptionLableCell0: UILabel!
    
  
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    

    
    func configureFirstCell(text: ResultsData) {
        
        if let urlString = text.artworkUrl100 {
            
            DispatchQueue.main.async {
                NetworkRequest.shared.requestITunes(stringUrl: urlString) { result in
                    switch result {
                        
                    case .success(let data):
                        let image = UIImage(data: data)
                        self.imageCell0.image = image
                    case .failure(let error ):
                        print(error.localizedDescription)
                        self.imageCell0.image = UIImage(systemName: "person.fill")
                    }
                }
            }
            
        } else {
            self.imageCell0.image = UIImage(systemName: "person.fill")
        }
        
        
        nameLableCello.text = text.artistName
        
        if text.trackName == "" {
            descriptionLableCell0.text = "No track"
        } else {
            descriptionLableCell0.text = text.trackName
        }
        
    }

}
