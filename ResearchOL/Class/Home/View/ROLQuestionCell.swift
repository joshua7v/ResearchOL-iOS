//
//  ROLQuestionCell.swift
//  ResearchOL
//
//  Created by Joshua on 15/4/18.
//  Copyright (c) 2015年 SigmaStudio. All rights reserved.
//

import UIKit

class ROLQuestionCell: UITableViewCell {
    
    var index = 0
    var answers: [ROLAnswer] = []
    var answer: ROLAnswer = ROLAnswer()
    
    var item: ROLQuestion = ROLQuestion() {
        didSet {
            titleLabel.text = item.title
            self.setup()
        }
    }
    
    @IBAction func choice1BtnClicked(sender: UIButton) {
        self.setSelectedState(sender)
    }
    @IBAction func choice2BtnClicked(sender: UIButton) {
        self.setSelectedState(sender)
    }
    @IBAction func choice3BtnClicked(sender: UIButton) {
        self.setSelectedState(sender)
    }
    @IBAction func choice4BtnClicked(sender: UIButton) {
        self.setSelectedState(sender)
    }
    @IBAction func choice5BtnClicked(sender: UIButton) {
        self.setSelectedState(sender)
    }
    
    
    @IBOutlet weak var choice2Constraint: NSLayoutConstraint!
    @IBOutlet weak var choic1ovalConstraint: NSLayoutConstraint!
    @IBOutlet weak var whiteLineVConstraint: NSLayoutConstraint!
    @IBOutlet weak var whiteLineV: UIView!
    
    @IBOutlet weak var choice8Label: UILabel!
    @IBOutlet weak var choice7Label: UILabel!
    @IBOutlet weak var choice6Label: UILabel!
    @IBOutlet weak var choice5Label: UILabel!
    @IBOutlet weak var choice4Label: UILabel!
    @IBOutlet weak var whiteLine: UIView!
    
    @IBOutlet weak var choice8oval: UIButton!
    @IBOutlet weak var choice7oval: UIButton!
    @IBOutlet weak var choice6oval: UIButton!
    @IBOutlet weak var choice5oval: UIButton!
    @IBOutlet weak var choice4oval: UIButton!
    @IBOutlet weak var choice3oval: UIButton!
    @IBOutlet weak var choice2oval: UIButton!
    @IBOutlet weak var choice1oval: UIButton!
    
    @IBOutlet weak var choice3Label: UILabel!
    @IBOutlet weak var choice2Label: UILabel!
    @IBOutlet weak var choice1Label: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var answerTextField: UITextField!
    
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
        self.resetOvalSelection()
        self.retriveBtnState()
        
        if self.item.type == 1 || self.item.type == 2 {
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
        } else if self.item.type == 3 {
            self.fillInBlanks()
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
        choice3Label.text = self.item.choice[1]
        choice2Label.text = self.item.choice[2]
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
        self.whiteLineVConstraint.constant = CGFloat(27 * (self.item.choice.count - 2))
    }
    
    func choice5() {
        self.choice4()
        
        choice8oval.hidden = false
        choice8Label.hidden = false
        choice8Label.text = self.item.choice[4]
    }
    
    func choiceGreaterThan5() {
        // TODO
    }
    
    func fillInBlanks() {
        self.hideAll()
        
        answerTextField.hidden = false
    }
    
    func hideAll() {
        for i: UIView in self.contentView.subviews as! [UIView] {
            if i.tag == 999 { // title should not be hide
                continue
            }
            if i.isKindOfClass(UILabel.classForCoder()) {
                var label = i as! UILabel
                label.text = nil
            }
            i.hidden = true
        }
        
        self.choic1ovalConstraint.constant = 30
        self.whiteLineVConstraint.constant = 0
        self.choice2Constraint.constant = 5
    }
    
    func setSelectedState(sender: UIButton) {
        self.resetOvalSelection()
        sender.setImage(UIImage(named: "oval_purple"), forState: UIControlState.Normal)
        self.answer.type = self.item.type
        if self.answer.type == 1 {
            self.answer.choice = sender.tag
            if self.item.choice.count == 2 { // fix 2 answer condition
                self.answer.choice -= 1
                if self.answer.choice < 0 { self.answer.choice = 0 }
            }
        }
        println(self.index)
        ROLQuestionManager.sharedManager.setAnswer(self.answer, index: self.index)
    }
    
    func resetOvalSelection() {
        var subviews: [UIView] = self.contentView.subviews as! [UIView]
        for i: UIView in subviews {
            if i.isKindOfClass(UIButton.classForCoder()) {
                var btn = i as! UIButton
                btn.setImage(UIImage(named: "oval_white"), forState: .Normal)
            }
        }
    }
    
    func retriveBtnState() {
        var answer = ROLQuestionManager.sharedManager.getAnswerWithIndex(self.index)
        var subviews: [UIView] = self.contentView.subviews as! [UIView]
        var tag = 0
        if answer.type == 1 {
            tag = answer.choice
            if self.item.choice.count == 2 { // fix 2 answer condition
                if answer.choice == 1 { tag = 2 }
            }
            
            for i: UIView in subviews {
                if i.isKindOfClass(UIButton.classForCoder()) {
                    var btn = i as! UIButton
                    if btn.tag == tag {
                        btn.setImage(UIImage(named: "oval_purple"), forState: UIControlState.Normal)
                    }
                }
            }
        }
    }
    
    func getRectWithStr(string: String, width: CGFloat, attributes: Dictionary<NSObject, AnyObject>) -> CGRect {
        var str: NSString = string
        var size = CGSize(width: width, height: CGFloat.max)
        return str.boundingRectWithSize(size, options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: attributes, context: nil)
    }
    
    func fixTooLongChoice(height: CGFloat) -> CGFloat {
        var attributes = [ NSFontAttributeName: UIFont.systemFontOfSize(14) ]
        var rect = self.getRectWithStr(self.choice1Label.text!, width: self.choice1Label.bounds.width, attributes: attributes)
        var tempH = height
        if rect.width > UIScreen.mainScreen().bounds.width / 2 {
            self.choice2Constraint.constant += rect.height + 5
            tempH += rect.height
        }
        return tempH
    }
    
    // MARK: - public
    // MARK: height
    func heightForQuestionCell() -> CGFloat {
        var height: CGFloat = 110
        
        var attributes = [ NSFontAttributeName: UIFont.systemFontOfSize(15) ]
        var rect = self.getRectWithStr(self.titleLabel.text!, width: self.titleLabel.bounds.width, attributes: attributes)
        if rect.height > 17 {
            height += rect.height - 17
        }
        
        if self.item.choice.count == 2 {
            return self.fixTooLongChoice(height) + 10
        } else if self.item.choice.count == 3 {
            return self.fixTooLongChoice(height) + 25
        } else if self.item.choice.count == 4 {
            return height + 65
        } else if self.item.choice.count == 5 {
            return height + 90
        }
        
        return height
    }
    
    class func cellWithTableView(tableView: UITableView, indexPath: NSIndexPath) -> ROLQuestionCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(ROLCellIdentifiers.ROLQuestionCell, forIndexPath: indexPath) as! ROLQuestionCell
        
        return cell
    }
    
}
