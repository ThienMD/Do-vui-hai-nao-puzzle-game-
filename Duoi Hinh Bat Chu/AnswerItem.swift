//
//  AnswerItem.swift
//  Duoi Hinh Bat Chu
//
//  Created by admin on 7/29/16.
//  Copyright © 2016 dotvn. All rights reserved.
//

import UIKit

class AnswerItem: UIButton {
    private let ICON_EMPTY="support_popup_tile_empty"
    private let ICON_HOVER="support_popup_tile_hover"
    private let ICON_TRUE="support_popup_tile_true"
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        
    }
    internal func setText(tile:String){
        self.setTitle(tile, forState: UIControlState.Normal)
    }
    override init(frame: CGRect) {
        // set myValue before super.init is called
        super.init(frame: frame)
        self.titleEdgeInsets = UIEdgeInsetsMake(-10, 0, 0.0, 0.0)
        self.setBackgroundImage(UIImage(named: ICON_HOVER), forState: UIControlState.Normal);
        self.titleLabel?.font = UIFont(name: FontUtils.Constants.FONT_COOKIE, size: 20)
        self.titleLabel?.textAlignment = NSTextAlignment.Center
        self.contentVerticalAlignment = UIControlContentVerticalAlignment.Center;
        // set other operations after super.init, if required
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }



}
