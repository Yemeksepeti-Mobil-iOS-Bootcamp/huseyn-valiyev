//
//  CookCell.swift
//  HomeworkWeek-3
//
//  Created by Huseyn Valiyev on 9.07.2021.
//

import UIKit

class CookCell: UITableViewCell {

    @IBOutlet weak var cookImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var location: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
