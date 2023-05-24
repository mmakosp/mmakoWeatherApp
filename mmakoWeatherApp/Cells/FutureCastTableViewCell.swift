//
//  FutureCastTableViewCell.swift
//  mmakoWeatherApp
//
//  Created by Mmako Sekhosana on 2023/05/21.
//

import UIKit

class FutureCastTableViewCell: UITableViewCell {
    @IBOutlet private weak var futureDayLabel: UILabel!
    @IBOutlet private weak var iconImageView: UIImageView!
    @IBOutlet private weak var tempDegreesLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func cellSetup(futureDay: String, iconImage: UIImage, tempDegrees: String) {
        futureDayLabel.text = futureDay
        //iconImageView.image = iconImage
        tempDegreesLabel.text = tempDegrees
    }
    
}
