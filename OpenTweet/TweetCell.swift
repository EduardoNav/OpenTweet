//
//  TweetCell.swift
//  OpenTweet
//
//  Created by Luis Eduardo Moreno Nava on 28/06/22.
//  Copyright © 2022 OpenTable, Inc. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {

  @IBOutlet weak var userImage: UIImageView!
  @IBOutlet weak var userLbl: UILabel!
  @IBOutlet weak var messageLbl: UILabel!
  @IBOutlet weak var dateLbl: UILabel!
  
    override func awakeFromNib() {
      super.awakeFromNib()
      messageLbl.sizeToFit()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
