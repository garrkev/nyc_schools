//
//  SchoolCellTableViewCell.swift
//  20210426-KevinGarriott-NYCSchools
//
//  Created by Kevin Garriott on 4/27/21.
//

import UIKit

class SchoolCellTableViewCell: UITableViewCell {

  @IBOutlet weak var schoolTitleLabel: UILabel!
  @IBOutlet weak var schoolNeighborhoodLabel: UILabel?
  //@IBOutlet weak var restaurantDescriptionLabel: UILabel!
  //@IBOutlet weak var restaruantCategoryLabelView: UIView!
  //@IBOutlet weak var restaruantCategoryLabel: UILabel!

  // MARK: Functions
  
  func setupCellWith(school: School, atIndex: Int) {
    
    if(atIndex % 2 == 0) {
      self.backgroundColor = .white
    } else {
      self.backgroundColor = UIColor (hex: "0099ff", alpha: 0.08)
    }
    schoolTitleLabel.text = school.school_name
    schoolNeighborhoodLabel?.text = school.neighborhood
    //self.accessoryView =
    
    print("cell got school: \(school)")
//    restaurantTitleLabel.text = restaurant.name
//    restaurantDescriptionLabel.text = restaurant.description
//    restaruantCategoryLabel.text = restaurant.category
    
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)

    // Configure the view for the selected state
  }
  
  // MARK: View Functions
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
}

