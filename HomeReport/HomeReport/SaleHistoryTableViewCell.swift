//
//  SaleHistoryTableViewCell.swift
//  HomeReport
//
//  Created by Marcelo Mogrovejo on 5/30/17.
//  Copyright © 2017 Marcelo Mogrovejo. All rights reserved.
//

import UIKit

class SaleHistoryTableViewCell: UITableViewCell {

    // MARK: Outlets
    @IBOutlet weak var soldDateLabel: UILabel!
    @IBOutlet weak var soldPriceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(saleHistory: SaleHistory) {
        soldDateLabel.text = saleHistory.soldDate?.toString
        soldPriceLabel.text = saleHistory.soldPrice.currencyFormatter
    }

}
