//
//  SecondTableViewCell.swift
//  SWG
//
//  Created by Максим Сулим on 26.06.2023.
//

import UIKit

class SecondTableViewCell: UITableViewCell {

    
    struct ViewModel {
        var index = 0
    }
    
    private var model = ViewModel()
    
    weak var delegate: VCSourceProtocol?
    
    @IBOutlet weak var nameLableCell1: UILabel!
    @IBOutlet weak var descriptionLableCell1: UILabel!
    
    @IBOutlet weak var buttonImage1: UIButton!
    
    
    @IBAction func actionTapImage1(_ sender: UIButton) {
        
        delegate?.segueImage(index: model.index)
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    
    func configureSecondCellITunes(text: ResultsDataITunes, index: Int) {
        
        if let urlString = text.artworkUrl100 {
            DispatchQueue.main.async {
                self.model.index = index
                NetworkRequest.shared.request(stringUrl: urlString) { result in
                    switch result {
                        
                    case .success(let data):
                        let image = UIImage(data: data)
                        self.buttonImage1.imageView?.image = image
                        self.buttonImage1.setImage(image, for: .normal)
                        self.buttonImage1.imageView?.contentMode = .scaleAspectFit
                    case .failure(let error ):
                        print(error.localizedDescription)
                        self.buttonImage1.imageView?.image = UIImage(systemName: "person.fill")
                        self.buttonImage1.imageView?.contentMode = .scaleAspectFit
                    }
                }
            }
        } else {
            self.buttonImage1.imageView?.image = UIImage(systemName: "person.fill")
        }
        
        nameLableCell1.text = text.artistName
        
        if text.trackName == "" {
            descriptionLableCell1.text = "No track"
        } else {
            descriptionLableCell1.text = text.trackName
        }
        
    }
    
    func configureSecondCellIGit(text: ResultsDataGit, index: Int) {
        
        if let urlString = text.avatarURL {
            model.index = index
            DispatchQueue.main.async {
                NetworkRequest.shared.request(stringUrl: urlString) { result in
                    switch result {
                        
                    case .success(let data):
                        let image = UIImage(data: data,scale: 5)
                        
                        self.buttonImage1.setImage(image, for: .normal)
                        self.buttonImage1.imageView?.contentMode = .scaleAspectFill
                        
                    case .failure(let error ):
                        print(error.localizedDescription)
                        self.buttonImage1.imageView?.image = UIImage(systemName: "person.fill")
                        self.buttonImage1.imageView?.contentMode = .scaleAspectFit
                    }
                }
            }
            
        } else {
            self.buttonImage1.imageView?.image = UIImage(systemName: "person.fill")
        }
        
        
        nameLableCell1.text = text.login
        
        if text.type == "" {
            descriptionLableCell1.text = "No link"
        } else {
            descriptionLableCell1.text = text.url
        }
        
    }

}
