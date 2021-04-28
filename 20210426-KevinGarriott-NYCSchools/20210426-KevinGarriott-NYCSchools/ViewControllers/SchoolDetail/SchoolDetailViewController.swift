//
//  SchoolDetailViewController.swift
//  20210426-KevinGarriott-NYCSchools
//
//  Created by Kevin Garriott on 4/27/21.
//

import UIKit

class SchoolDetailViewController: UIViewController {
  
  @IBOutlet weak var overviewTextView: UITextView!
  @IBOutlet weak var activitySatScores: UIActivityIndicatorView!
  @IBOutlet weak var mathSATScoreLabel: UILabel!
  @IBOutlet weak var readingSATScoreLabel: UILabel!
  @IBOutlet weak var writingSATScoreLabel: UILabel!
  
  
  var school: School?
  var satResults = [SATScore]()

  // MARK: -
  // MARK: METHODS
  
  // TODO: handle sat score more elegantly with regard to not using array here
  func loadSATScoresFromService() {
    guard let dbn = school?.dbn, let url = URL(string: kApiSatURL+dbn) else {
      showDismissiveAlertWithMessage(message: kApiError)
      return
    }
    self.activitySatScores.startAnimating()
    APIClient.getSchoolSATScoresWithCompletion(satURL: url) { result in
      switch result {
        case .success(let str):
          DLog(message: "data string: \(str)")
          let tapBack = UINotificationFeedbackGenerator()
          tapBack.notificationOccurred(.success)
          self.satResults = str
          
          if self.satResults.count > 0 {
            self.mathSATScoreLabel.text = self.satResults[0].sat_math_avg_score
            self.readingSATScoreLabel.text = self.satResults[0].sat_critical_reading_avg_score
            self.writingSATScoreLabel.text = self.satResults[0].sat_writing_avg_score
          } else {
            self.mathSATScoreLabel.text = "no result"
            self.readingSATScoreLabel.text = "no result"
            self.writingSATScoreLabel.text = "no resut"
          }
          
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
      self.activitySatScores.stopAnimating()
      
    }//api
    
  }
  
  // MARK: -
  // MARK: VIEW METHODS
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    overviewTextView.text = school?.overview_paragraph ?? "--"
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.20) {
      self.loadSATScoresFromService()
    }
    
  }
  
  override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
  
    self.navigationItem.title = school?.school_name
      DLog(message: school?.overview_paragraph ?? "!---!")
      print("test")
      
    }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
}
