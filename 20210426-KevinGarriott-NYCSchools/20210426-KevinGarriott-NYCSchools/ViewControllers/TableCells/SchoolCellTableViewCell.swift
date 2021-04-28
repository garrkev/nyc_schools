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


  // MARK: Functions
  
  func setupCellWith(school: School, atIndex: Int) {
    
    if(atIndex % 2 == 0) {
      self.backgroundColor = .white
    } else {
      self.backgroundColor = UIColor (hex: "0099ff", alpha: 0.08)
    }
    schoolTitleLabel.text = school.school_name
    schoolNeighborhoodLabel?.text = "@" + (school.neighborhood ?? "")
    
    //print("cell got school: \(school)")
    
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
  
  // MARK: View Functions
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
}

