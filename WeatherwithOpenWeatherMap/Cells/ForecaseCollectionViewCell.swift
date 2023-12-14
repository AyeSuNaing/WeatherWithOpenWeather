//
//  ForecaseCollectionViewCell.swift
//  WeatherwithOpenWeatherMap
//
//  Created by Brycen on 12/4/23.
//

import UIKit

class ForecaseCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var tempLbl: UILabel!
    @IBOutlet weak var lowHighTempLbl: UILabel!
    @IBOutlet weak var weatherMainLbl: UILabel!
    
    @IBOutlet weak var weatherImg: UIImageView!
    @IBOutlet weak var bgView: UIView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

}
