//
//  TweetService.swift
//  OpenTweet
//
//  Created by Luis Eduardo Moreno Nava on 27/06/22.
//  Copyright © 2022 OpenTable, Inc. All rights reserved.
//

import Foundation

class TweetService{

    static func getTweetsData() -> AppModel {
        if let path = Bundle.main.path(forResource: "timeline", ofType: "json")
        {
          guard let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe) else {
            fatalError("Failed to load data")
          }
          let decoder = JSONDecoder()
          guard let tweets = try? decoder.decode(AppModel.self, from: data) else {
                        fatalError("Failed to decode  from bundle.")
          }
          return tweets
        } else {
            fatalError("Failed to find path")
        }
    }
}
