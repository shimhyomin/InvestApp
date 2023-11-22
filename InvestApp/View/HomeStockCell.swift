//
//  HomeStockCell.swift
//  InvestApp
//
//  Created by shm on 2023/11/18.
//

import UIKit

class HomeStockCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var prLabel: UILabel!
    @IBOutlet weak var ctrtLabel: UILabel!
    @IBOutlet weak var ctrtSignImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
