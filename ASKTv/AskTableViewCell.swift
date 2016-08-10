//
//  AskTableViewCell.swift
//  ASKTv
//
//  Created by Bryan Ye on 4/08/2016.
//  Copyright © 2016 Bryan Ye. All rights reserved.
//

import UIKit

protocol AskTableViewCellDelegate {
    func presentAnswerTextField(toUser: User)
}

class AskTableViewCell: UITableViewCell {
    
    var delegate: AskTableViewCellDelegate?

    @IBOutlet weak var usernameLabel: UILabel!
    
    var user: User? {
        didSet {
           usernameLabel.text = user?.username ?? ""
        }
    }
    
    @IBAction func askButtonTapped(sender: AnyObject) {
        guard let user = user else { return }
        delegate?.presentAnswerTextField(user)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
