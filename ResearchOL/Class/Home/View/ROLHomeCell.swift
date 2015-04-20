//
//  ROLHomeCell.swift
//  ResearchOL
//
//  Created by Joshua on 15/4/16.
//  Copyright (c) 2015年 SigmaStudio. All rights reserved.
//

import UIKit

class ROLHomeCell: UITableViewCell {
    
     var item: ROLQuestionare = ROLQuestionare() {
        didSet {
            titleLabel.text = item.title
            dateLabel.text = item.fireDate
            questionCount.text = String(item.questionCount)
            participant.text = String(item.participant)
            point.text = String(format: "%d 积分", item.point)
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var questionCount: UILabel!
    @IBOutlet weak var participant: UILabel!
    @IBOutlet weak var point: UILabel!
    
    // MARK: - public
    // MARK: height
    func heightForHomeCell() -> CGFloat {
        var height: CGFloat = 70
        var attributes = [ NSFontAttributeName: UIFont.systemFontOfSize(15) ]
        var rect = ROLStringTool.getRectWithStr(item.title, width: self.titleLabel.bounds.width, attributes: attributes)
        
        if rect.width > 300 {
            height += 15 * (rect.width / 300)
        }
        
        return height
    }
    
    // MARK: override frame
    override var frame: CGRect {
        set {
            super.frame = CGRectMake(newValue.origin.x, newValue.origin.y, newValue.size.width, newValue.size.height - 10)
        }
        get {
            return super.frame
        }
    }
    
    class func cellWithTableView(tableView: UITableView, indexPath: NSIndexPath) -> ROLHomeCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(ROLCellIdentifiers.ROLHomeCell, forIndexPath: indexPath) as! ROLHomeCell
        
        return cell
    }
    
    // MARK: - private
    // MARK: awake
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    
    
}
