//
//  Tile.swift
//  Duoi Hinh Bat Chu
//
//  Created by admin on 7/24/16.
//  Copyright © 2016 dotvn. All rights reserved.
//

import UIKit
protocol TileButtonDelegate{
    func tileButtonClick ()
}
class TileButton: UIButton {
    private let ICON_EMPTY="support_popup_tile_empty"
    private let ICON_HOVER="support_popup_tile_hover"
    private let ICON_TRUE="support_popup_tile_true"
    private let ICON_FALSE="support_popup_tile_false"
    private let ICON_HINT="tile_hint"

    public var isHint:Bool=false
    private var isText:Bool=false
    private var btAdd:UIButton!
    var delegate:TileButtonDelegate!
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
          self.setBackgroundImage(UIImage(named: ICON_EMPTY), forState: UIControlState.Normal)
        self.addTarget(self, action: Selector("removeText"), forControlEvents: UIControlEvents.TouchUpInside)
        self.titleLabel?.font = UIFont(name: FontUtils.Constants.FONT_COOKIE, size: 20)
        self.titleLabel?.textAlignment = NSTextAlignment.Center
        self.contentVerticalAlignment = UIControlContentVerticalAlignment.Center;
        self.titleEdgeInsets = UIEdgeInsetsMake(-10, 0, 0.0, 0.0)


    }
    func isSet()->Bool{
        return isText
    }
    func addButton(button:UIButton){
        button.hidden=true
        isText=true
        btAdd=button
        self.setTitle(btAdd.currentTitle, forState: UIControlState.Normal)
        setHighLighted(true)
       
    }
    func addHint(button:UIButton){
        button.hidden=true
        isHint = true
        isText = true
        btAdd=button
        self.setTitle(btAdd.currentTitle, forState: UIControlState.Normal)
        self.setBackgroundImage(UIImage(named: ICON_TRUE), forState: UIControlState.Normal)
        
    }
    func setText(text:String){
        isText=true
        self.setTitle(text, forState: UIControlState.Normal)
        setHighLighted(true)
    }
    func removeText(){
        if isHint{
            return
        }
        if ((btAdd) != nil){
            btAdd.hidden=false
        }
        if delegate != nil{
            delegate.tileButtonClick()
        }
        isText=false
        self.setTitle("", forState: UIControlState.Normal)
        setHighLighted(false)
    }
    func setHighLighted(check:Bool){
        if check{
            self.setBackgroundImage(UIImage(named: ICON_HOVER), forState: UIControlState.Normal)
        }else{
             self.setBackgroundImage(UIImage(named: ICON_EMPTY), forState: UIControlState.Normal)
        }
    }
    
    func changeImageAnimation(){
        //add images to the array
        var imagesListArray : [UIImage]
        //use for loop
   
            
        var strImageName : String = "support_popup_tile_false"
        var image  = UIImage(named:strImageName)!
        strImageName="support_popup_tile_hover"
        var image1  = UIImage(named:strImageName)!
        imagesListArray=[image,image1]
        self.imageView!.animationImages = imagesListArray;
        self.imageView!.animationDuration = 2.0
        self.imageView!.startAnimating()
    
    }

    func animationWrong(){
        changeImageAnimation()
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 4
        animation.autoreverses = true
        animation.fromValue = NSValue(CGPoint: CGPointMake(self.center.x - 10, self.center.y))
        animation.toValue = NSValue(CGPoint: CGPointMake(self.center.x + 10, self.center.y))
        self.layer.addAnimation(animation, forKey: "position")
        
    }


}
