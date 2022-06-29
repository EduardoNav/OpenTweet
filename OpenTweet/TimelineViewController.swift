//
//  ViewController.swift
//  OpenTweet
//
//  Created by Olivier Larivain on 9/30/16.
//  Copyright © 2016 OpenTable, Inc. All rights reserved.
//

import UIKit

class TimelineViewController: UIViewController {

  @IBOutlet weak var tweetsTable: UITableView!

  var tweetsViewModel: TweetViewModel = TweetViewModel()

	override func viewDidLoad() {
		super.viewDidLoad()
    tweetsTable.delegate = self
    tweetsTable.dataSource = self
    tweetsTable.rowHeight = UITableView.automaticDimension
    loadTweets()
		// Do any additional setup after loading the view, typically from a nib.
	}

  func loadTweets(){
      tweetsViewModel.getDriversData()
      tweetsViewModel.tweets.bind{ tweets in
          DispatchQueue.main.async {
            self.tweetsTable.reloadData()
          }
      }
  }

  override func prepare(for segue: UIStoryboardSegue, sender: Any?){
    guard let selectedPath = tweetsTable.indexPathForSelectedRow else
    {
      return
    }
    if let destination = segue.destination as? DetailViewController {
      let selectedTweet = self.tweetsViewModel.tweets.value?[selectedPath.row] ?? Tweet()
      let tweetsList = self.tweetsViewModel.tweets.value ?? []
      let linkedTweets = tweetsList.filter {
        $0.inReplyTo == selectedTweet.id
      }
      destination.headTweet = selectedTweet
      destination.linkedTweets = linkedTweets
    }
  }
}

extension TimelineViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 105
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    self.performSegue(withIdentifier: "tweetSegue", sender: self)
  }
}

extension TimelineViewController: UITableViewDataSource {

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.tweetsViewModel.tweets.value?.count ?? 0
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

    let headAttributeLabel = TweetHelper().getAttributedBody(
      name: self.tweetsViewModel.tweets.value?[indexPath.row].author ?? "",
      body: self.tweetsViewModel.tweets.value?[indexPath.row].content ?? "",
      date: self.tweetsViewModel.tweets.value?[indexPath.row].dateText ?? ""
    )

    let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetCell
    cell.messageLbl.attributedText = headAttributeLabel
    cell.messageLbl.textAlignment = .left
    cell.messageLbl.sizeToFit()
    cell.userImage.loadFrom(URLAddress: self.tweetsViewModel.tweets.value?[indexPath.row].avatar ?? "")
    return cell
  }
}

extension UIImageView {
  func loadFrom(URLAddress: String) {
    guard let url = URL(string: URLAddress) else {
      self.image = UIImage(systemName: "questionmark")
      return
    }
    DispatchQueue.main.async {
      [weak self] in
      if let imageData = try? Data(contentsOf: url) {
        if let loadedImage = UIImage(data: imageData) {
          self?.image = loadedImage
        }
      }
    }
  }
}

struct TweetHelper {
  func getAttributedBody(name: String, body: String, date: String) -> NSMutableAttributedString {
    let headAttribute = [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 8)]
    let bodyAttribute = [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 10)]
    let subHeadAttribute = [NSAttributedString.Key.foregroundColor: UIColor.darkGray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 7)]
    let headAttributeLabel = NSMutableAttributedString(string: name, attributes: headAttribute)
    let spaceAttributeLabel = NSMutableAttributedString(string: "\n", attributes: headAttribute)
    let bodyAttributeLabel = NSMutableAttributedString(string: body, attributes: bodyAttribute)
    let subHeadAttributeLabel = NSMutableAttributedString(string: date, attributes: subHeadAttribute)
    headAttributeLabel.append(spaceAttributeLabel)
    headAttributeLabel.append(bodyAttributeLabel)
    headAttributeLabel.append(spaceAttributeLabel)
    headAttributeLabel.append(subHeadAttributeLabel)
    return headAttributeLabel
  }
}
