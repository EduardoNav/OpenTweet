//
//  TweetViewModel.swift
//  OpenTweet
//
//  Created by Luis Eduardo Moreno Nava on 27/06/22.
//  Copyright © 2022 OpenTable, Inc. All rights reserved.
//

import Foundation

struct TweetViewModel {

  var tweets: Observable<[Tweet]> = Observable([])

  mutating func getDriversData() {
    self.tweets.value = getTweetsFormattedData()
  }

  func getTweetsFormattedData() -> [Tweet] {
    var tweets: [Tweet] = []
    TweetService.getTweetsData().timeline.forEach{ tweet in
      let formattedTweet = Tweet(
        id: tweet.id,
        author: tweet.author,
        content: tweet.content,
        avatar: tweet.avatar,
        date: tweet.date,
        dateText: self.getDateString(serverDate: tweet.date ?? ""),
        inReplyTo: tweet.inReplyTo
      )
      tweets.append(formattedTweet)
    }
    return tweets.sorted(by: {
      $0.getDate() ?? Date() > $1.getDate() ?? Date()
    })
  }

  func getDate(serverDate: String) -> Date? {
    let dateFormatter = ISO8601DateFormatter()
    let date =  dateFormatter.date(from: serverDate)
    return date
  }

  func getDateString(serverDate: String) -> String? {
    let dateFormatter = ISO8601DateFormatter()
    let date =  dateFormatter.date(from: serverDate)
    if let formDate = date {
      let components = Calendar.current.dateComponents([.day, .month, .hour, .minute], from: formDate)
      guard let day = components.day,
            let month = components.month,
            let hour = components.hour,
            let minute = components.minute else {
        return nil
      }
      return "\(month)/\(day)/\(hour):\(minute)"
    }
    return nil
  }
}
