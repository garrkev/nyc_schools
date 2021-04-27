//
//  Logger.swift
//  Schools
//
//  Created by Kevin Garriott on 4/27/21.
//  Copyright © 2021 Kevin Garriott. All rights reserved.
//

import Foundation
//
// debug logging
//
#if DEBUG
func DLog(message: String, filename: String = #file, function: String = #function, line: Int = #line) {
  NSLog("\n[\(filename.components(separatedBy: "/").last ?? ""):\(line)] \(function) - \(message)\n")
}
#else
func DLog(message: String, filename: String = #file, function: String = #function, line: Int = #line) {}
#endif
