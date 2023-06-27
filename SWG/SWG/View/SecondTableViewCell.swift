//
//  SecondTableViewCell.swift
//  SWG
//
//  Created by Максим Сулим on 26.06.2023.
//

import UIKit

class SecondTableViewCell: UITableViewCell {

    
    @IBOutlet weak var imageCell1: UIImageView!
    @IBOutlet weak var nameLableCell1: UILabel!
    @IBOutlet weak var descriptionLableCell1: UILabel!
    
    
    
    
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
                        self.imageCell1.image = image
                    case .failure(let error ):
                        print(error.localizedDescription)
                        self.imageCell1.image = UIImage(systemName: "person.fill")
                    }
                }
            }
        } else {
            self.imageCell1.image = UIImage(systemName: "person.fill")
        }
        
        nameLableCell1.text = text.artistName
        
        if text.trackName == "" {
            descriptionLableCell1.text = "No track"
        } else {
            descriptionLableCell1.text = text.trackName
        }
        
    }

}
