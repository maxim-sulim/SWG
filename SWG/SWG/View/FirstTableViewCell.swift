//
//  FirstTableViewCell.swift
//  SWG
//
//  Created by Максим Сулим on 26.06.2023.
//

import UIKit

class FirstTableViewCell: UITableViewCell {
    
    struct ViewModel {
        var index = 0
    }
    private var model = ViewModel()
    
    
    weak var delegate: VCSourceProtocol?
    
    @IBOutlet weak var buttonImage: UIButton!
    
    
    @IBOutlet weak var nameLableCell0: UILabel!
    @IBOutlet weak var descriptionLableCell0: UILabel!
    
    
    
    @IBAction func tapImageButton(_ sender: UIButton) {
        
        delegate?.segueImage(index: model.index)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    func configureFirstCellITunes(text: ResultsDataITunes, index: Int) {
        
        if let urlString = text.artworkUrl100 {
            self.model.index = index
            
            DispatchQueue.main.async {
                NetworkRequest.shared.request(stringUrl: urlString) { result in
                    switch result {
                    case .success(let data):
                        let image = UIImage(data: data)
                        self.buttonImage.setImage(image, for: .normal)
                        self.buttonImage.imageView?.contentMode = .scaleAspectFit
                        self.buttonImage.tag = index
                        
                    case .failure(let error ):
                        print(error.localizedDescription)
                        self.buttonImage.imageView?.image = UIImage(systemName: "person.fill")
                        self.buttonImage.imageView?.contentMode = .scaleAspectFit
                    }
                }
            }
            
        } else {
            self.buttonImage.imageView?.image = UIImage(systemName: "person.fill")
        }
        nameLableCell0.text = text.artistName
        
        if text.trackName == "" {
            descriptionLableCell0.text = "No track"
        } else {
            descriptionLableCell0.text = text.trackName
        }
        
    }
    
    func configureFirstCellIGit(text: ResultsDataGit, index: Int) {
        
        if let urlString = text.avatarURL {
            self.model.index = index
            DispatchQueue.main.async {
                NetworkRequest.shared.request(stringUrl: urlString) { result in
                    switch result {
                        
                    case .success(let data):
                        let image = UIImage(data: data, scale: 5)
                        self.buttonImage.setImage(image, for: .normal)
                        self.buttonImage.imageView?.contentMode = .scaleAspectFit
                    case .failure(let error ):
                        print(error.localizedDescription)
                        self.buttonImage.setImage(UIImage(systemName: "person.fill"), for: .normal)
                        self.buttonImage.imageView?.contentMode = .scaleAspectFit
                    }
                }
            }
            
        } else {
            self.buttonImage.setImage(UIImage(systemName: "person.fill"), for: .normal)
            self.buttonImage.imageView?.contentMode = .scaleAspectFit
        }
        
        nameLableCell0.text = text.login
        
        if text.type == "" {
            descriptionLableCell0.text = "No link"
        } else {
            descriptionLableCell0.text = text.url
        }
        
    }
}
