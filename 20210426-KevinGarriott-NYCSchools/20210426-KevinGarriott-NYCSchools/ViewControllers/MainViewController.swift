//
//  MainViewController.swift
//  20210426-KevinGarriott-NYCSchools
//
//  Created by Kevin Garriott on 4/27/21.
//

import UIKit

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

  @IBOutlet weak var titleBarNavigationBar: UINavigationBar!
  @IBOutlet weak var schoolsTableView: UITableView!
  @IBOutlet weak var loadingLabel: UILabel!
  @IBOutlet weak var loadingActivity: UIActivityIndicatorView!
  
  var schoolResults = [School]()
  var hasInitiallyLoaded: Bool = false
  
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .darkContent
  }
  
  // MARK: Functions
  
  /// Loads the data from the service and returns data or error.
  ///
  /// Use to query the API for data and update the view for display.
  func loadElementsFromServcie() {
    guard let url = URL(string: kApiURL) else {
      showDismissiveAlertWithMessage(message: kApiError)
      return
    }
  
    APIClient.getSchoolsFromUrlWithCompletion(schoolsUrl: url) { result in
      switch result {
      case .success(let str):
        DLog(message: "data string: \(str)")
        let tapBack = UINotificationFeedbackGenerator()
        tapBack.notificationOccurred(.success)
        self.schoolResults = str
        if let navController = self.navigationController {
          navController.navigationBar.isHidden = false
        }
        
        self.schoolsTableView.reloadData()
        self.schoolsTableView.setNeedsDisplay()
        
      case .failure(let error):
        switch error {
        case .requestIssue:
          print("the request failed: \(error.localizedDescription)")
        case .unknownIssue:
          print("unknown error")
        }
        
        let tapBack = UINotificationFeedbackGenerator()
        tapBack.notificationOccurred(.error)
        self.showDismissiveAlertWithMessage(message: error.localizedDescription)
        
      }//result
      
      self.hideLoadingElements()

    }//api
    
  }
  
  // Hides the loading UI and updates the view.
  ///
  /// Use the API closures returns whether success or failure.
  func hideLoadingElements() {
    self.loadingLabel.isHidden = true
    self.loadingActivity.stopAnimating()
    self.schoolsTableView.isHidden = false
  }
  
  func showLoadingElements() { //don't really need this
    //reload table and service
    
    self.schoolsTableView.isHidden = true
    self.loadingLabel.isHidden = false
    self.loadingActivity.isHidden = false
    self.loadingActivity.startAnimating()
    
//    self.loadingLabel.isHidden = false
//    self.loadingActivity.isHidden = false
//    self.loadingActivity.startAnimating()
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
      self.loadElementsFromServcie()
    }
    
  }
  
  @objc func reloadSchoolsTable() {
    print("reload the table")
    
    showLoadingElements()
    
  }
  

  
  // MARK: Table Delegate Functions
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    return schoolResults.count
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 65.0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let schoolResult = schoolResults[indexPath.row]
    
    if let cell = tableView.dequeueReusableCell(withIdentifier: "SchoolCellTableViewCell") as? SchoolCellTableViewCell {
      cell.setupCellWith(school: schoolResult, atIndex: indexPath.row)
      return cell
    }
    
    return UITableViewCell()
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: false)
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    showLoadingElements()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.title = "NYC Schools"
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    
    let schoolCell = UINib(nibName: "SchoolCellTableViewCell", bundle: nil)
    schoolsTableView.register(schoolCell, forCellReuseIdentifier: "SchoolCellTableViewCell")
    
    if let navController = self.navigationController {
     
      let reloadButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(self.reloadSchoolsTable))
      //reloadButton.tintColor = .white
      reloadButton.tintColor = .darkGray
      self.navigationItem.rightBarButtonItem = reloadButton
      
      navController.navigationBar.isHidden = true
      
    }
    
    schoolsTableView.contentInset = UIEdgeInsets(top: 44.0, left: 0.0, bottom: 0.0, right: 0.0)
    
    
  }
  
}
