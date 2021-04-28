//
//  APIClient.swift
//  Schools
//
//  Created by Kevin Garriott on 4/27/21.
//  Copyright © 2021 Kevin Garriott. All rights reserved.
//

import Foundation

enum APIError: Error {
    case requestIssue
    case unknownIssue
}

class APIClient {
  
  class func getSchoolSATScoresWithCompletion(satURL: URL, completion: @escaping(Result<[SATScore], APIError>) -> Void) {
    
    DispatchQueue.global(qos: .background).async {
      URLSession.shared.dataTask(with: satURL) { (data, _, error) in
        if error != nil {
          DispatchQueue.main.async {
            completion(.failure(.requestIssue))
            print("error \(error!.localizedDescription)")
          }
          return
        }
        guard let data = data else {
          DispatchQueue.main.async {
            completion(.failure(.requestIssue))
          }
          return
        }
        do {
          let satJson = try JSONDecoder().decode([SATScore].self, from: data)
          var satResults = [SATScore]()
          satResults = satJson
          DispatchQueue.main.async {
            completion(.success(satResults))
          }
        } catch let jsonError {
          DispatchQueue.main.async {
            print("MAJOR ERROR: \(jsonError)")
            completion(.failure(.unknownIssue))
          }
        }
        
      }.resume()//session
    }//queue
    
  }
  
  class func getSchoolsFromUrlWithCompletion(schoolsUrl: URL, completion: @escaping (Result<[School], APIError>) -> Void) {
    
    DispatchQueue.global(qos: .background).async {
      URLSession.shared.dataTask(with: schoolsUrl) { (data, _, error) in
        if error != nil {
          DispatchQueue.main.async {
            completion(.failure(.requestIssue))
            print("error \(error!.localizedDescription)")
          }
          return
        }
        guard let data = data else {
          DispatchQueue.main.async {
            completion(.failure(.requestIssue))
          }
          return
        }
        
        do {
          let schoolJson = try JSONDecoder().decode([School].self, from: data)
           var schoolResults = [School]()
          schoolResults = schoolJson
          DispatchQueue.main.async {
            completion(.success(schoolResults))
          }
        } catch let jsonError {
          DispatchQueue.main.async {
            print("MAJOR ERROR: \(jsonError)")
            completion(.failure(.unknownIssue))
          }
        }
        
      }.resume()//session
    }//gueue
    
  }//func
  
}
