//
//  FruitCell.swift
//  FruitFruit
//
//  Created by Junyeong Park on 2022/07/12.
//

import UIKit

class FruitCell: UITableViewCell {

    @IBOutlet weak var fruitName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
