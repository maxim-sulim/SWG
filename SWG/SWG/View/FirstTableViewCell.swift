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
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
