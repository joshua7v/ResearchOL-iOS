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
            participants.text = String(item.participants)
            point.text = String(format: "%d 积分", item.point)
        }
    }
    
    struct TableViewCellIdentifiers {
        static let ROLHomeCell = "ROLHomeCell"
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var questionCount: UILabel!
    @IBOutlet weak var participants: UILabel!
    @IBOutlet weak var point: UILabel!
    
    // MARK: - public
    // MARK: override frame
    override var frame: CGRect {
        set {
            super.frame = CGRectMake(newValue.origin.x, newValue.origin.y, newValue.size.width, newValue.size.height - 10)
        }
        get {
            return super.frame
        }
    }
    
    class func cellWithTableView(tableView: UITableView) -> ROLHomeCell {
        tableView.registerNib(UINib(nibName: TableViewCellIdentifiers.ROLHomeCell, bundle: nil), forCellReuseIdentifier: TableViewCellIdentifiers.ROLHomeCell)
        var cell = tableView.dequeueReusableCellWithIdentifier(TableViewCellIdentifiers.ROLHomeCell) as! ROLHomeCell
        
        return cell
    }
    
    // MARK: - private
    // MARK: awake
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    // MARK: height
    class func heightForHomeCell() -> CGFloat {
        return 70
    }
    
}
