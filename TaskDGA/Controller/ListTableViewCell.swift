//
//  ListTableViewCell.swift
//  TaskDGA
//
//  Created by Sarath on 29/07/21.
//

import UIKit

class ListTableViewCell: UITableViewCell {
    @IBOutlet weak var lblText1: UILabel!
    @IBOutlet weak var lblTexte2: UILabel!
    @IBOutlet weak var imgArticle: CustomImageView!
    @IBOutlet weak var lblDate: UILabel!
    
    @IBOutlet weak var lblUpdatedDate: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
