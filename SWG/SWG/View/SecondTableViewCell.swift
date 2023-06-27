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
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
