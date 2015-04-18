//
//  ROLQuestionCell.swift
//  ResearchOL
//
//  Created by Joshua on 15/4/18.
//  Copyright (c) 2015年 SigmaStudio. All rights reserved.
//

import UIKit

class ROLQuestionCell: UITableViewCell {
    
    var item: ROLQuestion = ROLQuestion() {
        didSet {
            titleLabel.text = item.title
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    class func cellWithTableView(tableView: UITableView, indexPath: NSIndexPath) -> ROLQuestionCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(ROLCellIdentifiers.ROLQuestionCell, forIndexPath: indexPath) as! ROLQuestionCell
        
        return cell
    }
    
    // MARK: - private
    // MARK: awake
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    // MARK: height
    class func heightForQuestionCell() -> CGFloat {
        return 70
    }
    
}
