//
//  SchoolDetailViewController.swift
//  20210426-KevinGarriott-NYCSchools
//
//  Created by Kevin Garriott on 4/27/21.
//

import UIKit

class SchoolDetailViewController: UIViewController {
  
  var school: School?

  // MARK: -
  // MARK: VIEW METHODS
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
//    guard let person = person else { return }
//    self.navigationItem.title = person.name
//    let imgPath = docsDir.appendingPathComponent(person.avatarPath)
//    largePersonImage.image = UIImage(contentsOfFile: imgPath.path)
    
    
    self.navigationItem.title = school?.school_name
    DLog(message: school?.overview_paragraph ?? "!---!")
    print("test")
    
  }
  
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
}
