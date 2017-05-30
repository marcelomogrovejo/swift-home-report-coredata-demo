//
//  HomeListTableViewCell.swift
//  HomeReport
//
//  Created by Marcelo Mogrovejo on 5/30/17.
//  Copyright © 2017 Marcelo Mogrovejo. All rights reserved.
//

import UIKit

class HomeListTableViewCell: UITableViewCell {

    // MARK: Outlets
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var bedLabel: UILabel!
    @IBOutlet weak var bathLabel: UILabel!
    @IBOutlet weak var sqftLabel: UILabel!
    @IBOutlet weak var homeImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configureCell(home: Home) {
        cityLabel.text = home.city
        categoryLabel.text = home.homeType
        bedLabel.text = String(home.bed)
        bathLabel.text = String(home.bath)
        sqftLabel.text = String(home.sqft)
        priceLabel.text = home.price.currencyFormatter
        
        let image = UIImage(data: home.image! as Data)
        homeImageView.image = image
        homeImageView.layer.borderWidth = 1
        homeImageView.layer.cornerRadius = 4
    }
}
