//
//  ROLNeedToLoginCell.swift
//  ResearchOL
//
//  Created by Joshua on 15/4/20.
//  Copyright (c) 2015年 SigmaStudio. All rights reserved.
//

import UIKit

protocol ROLNeedToLoginCellDelegate: NSObjectProtocol {
    func needToLoginCellLoginBtnDidClicked(cell: ROLNeedToLoginCell)
}

class ROLNeedToLoginCell: UITableViewCell {
    
    var delegate: ROLNeedToLoginCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - public
    class func cellWithTableView(tableView: UITableView, indexPath: NSIndexPath) -> ROLNeedToLoginCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(ROLCellIdentifiers.ROLNeedToLoginCell, forIndexPath: indexPath) as! ROLNeedToLoginCell
        
        return cell
    }
    
    class func heightForNeedToLoginCel() -> CGFloat {
        return UIScreen.mainScreen().bounds.height - 64 - 44
    }
    
    // MARK: - action
    @IBAction func LoginBtnClicked(sender: UIButton) {
        if (self.delegate?.respondsToSelector("needToLoginCellLoginBtnDidClicked") != nil) {
            self.delegate?.needToLoginCellLoginBtnDidClicked(self)
        }
    }
    
}
