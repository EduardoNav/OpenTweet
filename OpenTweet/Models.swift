//
//  Models.swift
//  OpenTweet
//
//  Created by Luis Eduardo Moreno Nava on 27/06/22.
//  Copyright © 2022 OpenTable, Inc. All rights reserved.
//

import Foundation

struct AppModel: Codable {
  var timeline: [Tweet]
}

struct Tweet: Codable {
  var id: String?
  var author: String?
  var content: String?
  var avatar: String?
  var date: String?
  var dateText: String?
  var inReplyTo: String?

  func getDate() -> Date? {
    guard let serverDate = self.date else {
      return nil
    }
    let dateFormatter = ISO8601DateFormatter()
    let date =  dateFormatter.date(from: serverDate)
    return date
  }
}
