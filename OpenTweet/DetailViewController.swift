//
//  DetailViewController.swift
//  OpenTweet
//
//  Created by Luis Eduardo Moreno Nava on 28/06/22.
//  Copyright © 2022 OpenTable, Inc. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

  @IBOutlet weak var detailTable: UITableView!

  var headTweet: Tweet = Tweet()
  var linkedTweets: [Tweet] = []

  override func viewDidLoad() {
    super.viewDidLoad()
    self.detailTable.delegate = self
    self.detailTable.dataSource = self
  }
}

extension DetailViewController: UITableViewDataSource {

  func numberOfSections(in tableView: UITableView) -> Int {
    return 2
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if section == 0 {
      return 1
    } else {
      return self.linkedTweets.count
    }
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if indexPath.section == 0 {
      let headAttributeLabel = TweetHelper().getAttributedBody(
        name: self.headTweet.author ?? "",
        body: self.headTweet.content ?? "",
        date: self.headTweet.dateText ?? ""
      )
      let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetCell
      cell.messageLbl.attributedText = headAttributeLabel
      cell.messageLbl.textAlignment = .left
      cell.messageLbl.sizeToFit()
      cell.userImage.loadFrom(URLAddress: self.headTweet.avatar ?? "")
      return cell
    }
    let headAttributeLabel = TweetHelper().getAttributedBody(
      name: self.linkedTweets[indexPath.row].author ?? "",
      body: self.linkedTweets[indexPath.row].content ?? "",
      date: self.linkedTweets[indexPath.row].dateText ?? ""
    )
    let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCellAnswer", for: indexPath) as! TweetCell
    cell.messageLbl.attributedText = headAttributeLabel
    cell.messageLbl.textAlignment = .left
    cell.messageLbl.sizeToFit()
    cell.userImage.loadFrom(URLAddress: self.linkedTweets[indexPath.row].avatar ?? "")
    return cell
  }
}

extension DetailViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 98
  }
}
