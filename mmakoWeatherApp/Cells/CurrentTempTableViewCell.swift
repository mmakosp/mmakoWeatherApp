//
//  CurrentTempTableViewCell.swift
//  mmakoWeatherApp
//
//  Created by Mmako Sekhosana on 2023/05/21.
//

import UIKit

class CurrentTempTableViewCell: UITableViewCell {
    @IBOutlet private weak var currentMinTempLabel: UILabel!
    @IBOutlet private weak var minDescriptionLabel: UILabel!
    @IBOutlet private weak var currentTempLabel: UILabel!
    @IBOutlet private weak var currentTempDescriptionLabel: UILabel!
    @IBOutlet private weak var maxTempLabel: UILabel!
    @IBOutlet private weak var maxDescriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setup(minTemp: String,
               minDescription: String,
               currentTemp: String,
               currentTempDescription: String,
               maxTemp: String,
               maxDescription: String) {
        currentMinTempLabel.text = minTemp
        minDescriptionLabel.text = minDescription
        currentTempLabel.text = currentTemp
        currentTempDescriptionLabel.text = currentTempDescription
        maxTempLabel.text = maxTemp
        maxDescriptionLabel.text = maxDescription
    }
}
