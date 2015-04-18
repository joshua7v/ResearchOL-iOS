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
            self.setup()
        }
    }
    
    @IBOutlet weak var choic1ovalConstraint: NSLayoutConstraint!
    @IBOutlet weak var whiteLineVConstraint: NSLayoutConstraint!
    @IBOutlet weak var whiteLineV: UIView!
    @IBOutlet weak var choice8oval: UIImageView!
    @IBOutlet weak var choice7oval: UIImageView!
    @IBOutlet weak var choice6oval: UIImageView!
    @IBOutlet weak var choice5oval: UIImageView!
    @IBOutlet weak var choice4oval: UIImageView!
    @IBOutlet weak var choice8Label: UILabel!
    @IBOutlet weak var choice7Label: UILabel!
    @IBOutlet weak var choice6Label: UILabel!
    @IBOutlet weak var choice5Label: UILabel!
    @IBOutlet weak var choice4Label: UILabel!
    @IBOutlet weak var whiteLine: UIView!
    @IBOutlet weak var choice3oval: UIImageView!
    @IBOutlet weak var choice2oval: UIImageView!
    @IBOutlet weak var choice1oval: UIImageView!
    @IBOutlet weak var choice3Label: UILabel!
    @IBOutlet weak var choice2Label: UILabel!
    @IBOutlet weak var choice1Label: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    // MARK: - private
    override var frame: CGRect {
        set {
            super.frame = CGRectMake(newValue.origin.x, newValue.origin.y, newValue.size.width, newValue.size.height - 15)
        }
        get {
            return super.frame
        }
    }
    
    // MARK: awake
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setup() {
        self.hideAll()
        if self.item.type == 1 {
            switch item.choice.count {
            case 2:
                self.choice2()
            case 3:
                self.choice3()
            case 4:
                self.choice4()
            case 5:
                self.choice5()
            default:
                self.hideAll()
            }
        }
    }
    
    func choice2() {
        self.hideAll()
        
        choice1Label.hidden = false
        choice2Label.hidden = false
        choice1oval.hidden = false
        choice2oval.hidden = false
        whiteLine.hidden = false
        choice1Label.text = self.item.choice[0]
        choice2Label.text = self.item.choice[1]
        self.choic1ovalConstraint.constant = 15
    }
    
    func choice3() {
        self.hideAll()
        
        choice1Label.hidden = false
        choice2Label.hidden = false
        choice3Label.hidden = false
        choice1oval.hidden = false
        choice2oval.hidden = false
        choice3oval.hidden = false
        whiteLine.hidden = false
        choice1Label.text = self.item.choice[0]
        choice2Label.text = self.item.choice[1]
        choice3Label.text = self.item.choice[2]
    }
    
    func choice4() {
        self.hideAll()
        
        choice4Label.hidden = false
        choice5Label.hidden = false
        choice6Label.hidden = false
        choice7Label.hidden = false
        choice4oval.hidden = false
        choice5oval.hidden = false
        choice6oval.hidden = false
        choice7oval.hidden = false
        whiteLineV.hidden = false
        choice4Label.text = self.item.choice[0]
        choice5Label.text = self.item.choice[1]
        choice6Label.text = self.item.choice[2]
        choice7Label.text = self.item.choice[3]
    }
    
    func choice5() {
        self.hideAll()
        
        choice4Label.hidden = false
        choice5Label.hidden = false
        choice6Label.hidden = false
        choice7Label.hidden = false
        choice8Label.hidden = false
        choice4oval.hidden = false
        choice5oval.hidden = false
        choice6oval.hidden = false
        choice7oval.hidden = false
        choice8oval.hidden = false
        whiteLineV.hidden = false
        choice4Label.text = self.item.choice[0]
        choice5Label.text = self.item.choice[1]
        choice6Label.text = self.item.choice[2]
        choice7Label.text = self.item.choice[3]
        choice8Label.text = self.item.choice[4]
        self.whiteLineVConstraint.constant = -28
    }
    
    func hideAll() {
        choice1Label.hidden = true
        choice2Label.hidden = true
        choice3Label.hidden = true
        choice4Label.hidden = true
        choice5Label.hidden = true
        choice6Label.hidden = true
        choice7Label.hidden = true
        choice8Label.hidden = true
        choice1oval.hidden = true
        choice2oval.hidden = true
        choice3oval.hidden = true
        choice4oval.hidden = true
        choice5oval.hidden = true
        choice6oval.hidden = true
        choice7oval.hidden = true
        choice8oval.hidden = true
        whiteLine.hidden = true
        whiteLineV.hidden = true
        choice1Label.text = nil
        choice2Label.text = nil
        choice3Label.text = nil
        choice4Label.text = nil
        choice5Label.text = nil
        choice6Label.text = nil
        choice7Label.text = nil
        choice8Label.text = nil
        self.choic1ovalConstraint.constant = 35
        self.whiteLineVConstraint.constant = -3
    }
    
    // MARK: - public
    // MARK: height
    func heightForQuestionCell() -> CGFloat {
        if self.item.choice.count == 2 {
            return 110
        } else if self.item.choice.count == 3 {
            return 115
        } else if self.item.choice.count == 4 {
            return 165
        } else if self.item.choice.count == 5 {
            return 190
        }
        
        return 110
    }
    
    class func cellWithTableView(tableView: UITableView, indexPath: NSIndexPath) -> ROLQuestionCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(ROLCellIdentifiers.ROLQuestionCell, forIndexPath: indexPath) as! ROLQuestionCell
        
        return cell
    }
    
}
