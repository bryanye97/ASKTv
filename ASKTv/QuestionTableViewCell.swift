//
//  QuestionTableViewCell.swift
//  ASKTv
//
//  Created by Bryan Ye on 4/08/2016.
//  Copyright © 2016 Bryan Ye. All rights reserved.
//

import UIKit

protocol QuestionTableViewCellDelegate {
    func takeVideo()
}

class QuestionTableViewCell: UITableViewCell {
    
    var videoHelper: VideoHelper?
    
    var delegate: QuestionTableViewCellDelegate?
    
    @IBOutlet weak var questionStringLabel: UILabel!
    
    var question: Question? {
        didSet {
            questionStringLabel.text = question?.questionString ?? ""
        }
    }
    
    @IBAction func answerButtonTapped(sender: AnyObject) {
        delegate?.takeVideo()
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
