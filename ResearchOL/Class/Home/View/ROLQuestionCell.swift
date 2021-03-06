//
//  ROLQuestionCell.swift
//  ResearchOL
//
//  Created by Joshua on 15/4/18.
//  Copyright (c) 2015年 SigmaStudio. All rights reserved.
//

import UIKit

protocol ROLQuestionCellDelegate: NSObjectProtocol {
    func questionCellDidSelectAnswer(questionCell: ROLQuestionCell, indexPath: NSIndexPath)
    func questionCellDidDeSelectAnswer(questionCell: ROLQuestionCell, indexPath: NSIndexPath)
}

class ROLQuestionCell: UITableViewCell {
    var delegate: ROLQuestionCellDelegate?
    var index = 0
    var answer: ROLAnswer = ROLAnswer()
    var ovalPurpleImg = UIImage(named: "oval_purple")
    var ovalPwhiteImg = UIImage(named: "oval_white")
    var item: ROLQuestion = ROLQuestion() {
        didSet {
            titleLabel.text = item.title
            self.setup()
        }
    }
    var cachedAnswer: ROLAnswer = ROLAnswer() {
        didSet {
            println(cachedAnswer)
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
        self.answerTextField.delegate = self
        var view = UIView()
        view.backgroundColor = UIColor.whiteColor()
        view.frame = CGRectMake(0, 0, 10, self.answerTextField.frame.size.height)
        self.answerTextField.leftView = view
        self.answerTextField.leftViewMode = UITextFieldViewMode.Always
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
//        self.retriveCachedAnswer()
    }
    
    
    func setup() {
        
        self.hideAll()
        self.resetOvalSelection()
        
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
            case 5 ..< 99:
                self.choiceGreaterThan5()
            default:
                self.hideAll()
            }
            self.retriveBtnState()
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
        self.whiteLineVConstraint.constant = CGFloat(30 * (self.item.choice.count - 2))
    }
    
    func choice5() {
        self.choice4()
        
        choice8oval.hidden = false
        choice8Label.hidden = false
        choice8Label.text = self.item.choice[4]
    }
    
    func choiceGreaterThan5() {
        // TODO
        choice5()
        let count = self.item.choice.count - 5
        
        for i in 1 ... count {
            var choiceoval = UIButton()
            choiceoval.addTarget(self, action: "setSelectedState:", forControlEvents: UIControlEvents.TouchDown)
            choiceoval.tag = (i + 4)
            choiceoval.setTranslatesAutoresizingMaskIntoConstraints(false)
            choiceoval.setImage(ovalPwhiteImg, forState: UIControlState.Normal)
            //        choiceoval.center = CGPoint(x: 20, y: 20)
            self.contentView.addSubview(choiceoval)
            choiceoval.addConstraints([
                NSLayoutConstraint(item: choiceoval, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: 25),
                NSLayoutConstraint(item: choiceoval, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: 25)
                ])
            let constant: CGFloat = CGFloat(25 * (i-1)) + CGFloat(5 * i)
            choiceoval.superview?.addConstraints([
                NSLayoutConstraint(item: choiceoval, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self.choice4oval, attribute: NSLayoutAttribute.Left, multiplier: 1.0, constant: 0),
                NSLayoutConstraint(item: choiceoval, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.choice8oval, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: constant)
                ])
            
            var choicelabel = UILabel()
            choicelabel.setTranslatesAutoresizingMaskIntoConstraints(false)
            choicelabel.font = UIFont.systemFontOfSize(14)
            choicelabel.text = self.item.choice[i + 4]
            choicelabel.numberOfLines = 0
            self.contentView.addSubview(choicelabel)
            self.contentView.addConstraints([
                NSLayoutConstraint(item: choicelabel, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: self.contentView, attribute: NSLayoutAttribute.Trailing, multiplier: 1.0, constant: -20),
                NSLayoutConstraint(item: choicelabel, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: choiceoval, attribute: NSLayoutAttribute.Trailing, multiplier: 1.0, constant: 15),
                NSLayoutConstraint(item: choicelabel, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: choiceoval, attribute: NSLayoutAttribute.CenterY, multiplier: 1.0, constant: 0)
                ])
        }
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
            if i.tag > 6 && i.tag < 99 {
//                println(i.tag)
//                i.removeFromSuperview()
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
        self.endEditing(true)
        if self.item.type == 1 { // single choice
            self.resetOvalSelection()
            sender.setImage(ovalPurpleImg, forState: UIControlState.Normal)
            self.answer.choice = sender.tag
            if self.item.choice.count == 2 { // fix 2 answer condition
                self.answer.choice -= 1
                if self.answer.choice < 0 { self.answer.choice = 0 }
            }
        } else if self.item.type == 2 { // multi choice
            if (sender.currentImage == ovalPwhiteImg) {
                sender.setImage(ovalPurpleImg, forState: UIControlState.Normal)
                self.answer.choices.append(sender.tag)
                self.answer.choices.sort(<)
            } else {
                sender.setImage(ovalPwhiteImg, forState: UIControlState.Normal)
                var temp: Int?
                for i in enumerate(self.answer.choices) {
                    if i.element == sender.tag {
                        temp = i.index
                    }
                }
                if temp != nil {
                    self.answer.choices.removeAtIndex(temp!)
                }
            }
        }
        self.saveAnswerToManager()
    }
    
    func resetOvalSelection() {
        self.answer = ROLAnswer()
        var subviews: [UIView] = self.contentView.subviews as! [UIView]
        for i: UIView in subviews {
            if i.isKindOfClass(UIButton.classForCoder()) {
                var btn = i as! UIButton
                btn.setImage(ovalPwhiteImg, forState: .Normal)
            }
        }
    }
    
//    func retriveCachedAnswer() {
//        if self.cachedAnswer.type == 0 { return }
//        var answer = self.cachedAnswer
//        if answer.type == 1 {
//            for i in self.contentView.subviews {
//                if i.isKindOfClass(UIButton.classForCoder()) {
//                    var btn = i as! UIButton
//                    if btn.tag == answer.choice {
//                        self.setSelectedState(btn)
//                    }
//                }
//                println(i)
//            }
//        }
//    }
    
    func retriveBtnState() {
        var answer = ROLQuestionManager.sharedManager.getAnswerWithIndex(self.index)
        var subviews: [UIView] = self.contentView.subviews as! [UIView]
        var tag = 0
        if (answer != nil) {
            self.answer = answer!
            if answer!.type == 1 {
                tag = answer!.choice
                if self.item.choice.count == 2 { // fix 2 answer condition
                    if answer!.choice == 1 { tag = 2 }
                }
                
                for i: UIView in subviews {
                    if i.isKindOfClass(UIButton.classForCoder()) {
                        var btn = i as! UIButton
                        if btn.tag == tag {
                            btn.setImage(ovalPurpleImg, forState: UIControlState.Normal)
                        }
                    }
                }
            } else if answer!.type == 2 {
                for i in enumerate(answer!.choices) {
                    for x: UIView in subviews {
                        if x.isKindOfClass(UIButton.classForCoder()) {
                            var btn = x as! UIButton
                            if btn.tag == i.element {
                                btn.setImage(ovalPurpleImg, forState: UIControlState.Normal)
                            }
                        }
                    }
                }
            } else if answer!.type == 3 {
                self.answerTextField.text = answer!.text
            }
        }
        
    }
    
    func saveAnswerToManager() {
        
        var indexPath = NSIndexPath(forRow: 0, inSection: self.index)
        if (self.answer.type == 2 && self.answer.choices.count == 0) {
            if (self.delegate?.respondsToSelector("questionCellDidDeSelectAnswer:") != nil) {
                self.delegate?.questionCellDidDeSelectAnswer(self, indexPath: indexPath)
            }
        } else if (self.delegate?.respondsToSelector("questionCellDidSelectAnswer:") != nil) {
            self.delegate?.questionCellDidSelectAnswer(self, indexPath: indexPath)
            self.answer.type = self.item.type
        }
        ROLQuestionManager.sharedManager.setAnswer(self.answer, index: self.index)
        
    }
    
    func fixTooLongChoice(height: CGFloat) -> CGFloat {
        var attributes = [ NSFontAttributeName: UIFont.systemFontOfSize(14) ]
        var rect = ROLStringTool.getRectWithStr(self.choice1Label.text!, width: self.choice1Label.bounds.width, attributes: attributes)
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
        var rect = ROLStringTool.getRectWithStr(self.titleLabel.text!, width: self.titleLabel.bounds.width, attributes: attributes)
        if rect.height > 17 {
            height += rect.height - 17
        }
        
        if self.item.choice.count == 2 {
            return self.fixTooLongChoice(height) + 10
        } else if self.item.choice.count == 3 {
            return self.fixTooLongChoice(height) + 25
        } else if self.item.choice.count == 4 {
            return height + 85
        } else if self.item.choice.count == 5 {
            return height + 110
        } else if self.item.choice.count > 5 {
            return height + CGFloat(self.item.choice.count - 5) * 35 + 110
        }
        
        return height
    }
    
    class func cellWithTableView(tableView: UITableView, indexPath: NSIndexPath) -> ROLQuestionCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(ROLCellIdentifiers.ROLQuestionCell, forIndexPath: indexPath) as! ROLQuestionCell
        
        return cell
    }
    
}

extension ROLQuestionCell: UITextFieldDelegate {
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        NSNotificationCenter.defaultCenter().postNotificationName("beginEditing", object: self.index)
        
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        self.answer.text = textField.text
        self.saveAnswerToManager()
    }
}
