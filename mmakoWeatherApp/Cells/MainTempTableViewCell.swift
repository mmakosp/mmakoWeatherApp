//
//  MainTempTableViewCell.swift
//  mmakoWeatherApp
//
//  Created by Mmako Sekhosana on 2023/05/21.
//

import UIKit

class MainTempTableViewCell: UITableViewCell {
    @IBOutlet private weak var currentMainTempLabel: UILabel!
    @IBOutlet private weak var currentMainDescriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setup(currentMainTemp: String, currentMainDescription: String) {
        currentMainTempLabel.text = currentMainTemp
        currentMainDescriptionLabel.text = currentMainDescription
    }
    
}
