//
//  MeaningReusableCell.swift
//  DICTO
//
//  Created by Deepanshu Gautam on 24/07/21.
//

import UIKit

class MeaningReusableCell: UITableViewCell {

    @IBOutlet weak var partOfSpeechLabel: UILabel!
    @IBOutlet weak var definitionsLabel: UILabel!
    @IBOutlet weak var synonymsLabel: UILabel!
    @IBOutlet weak var exampleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
