//
//  AnswerPanel.swift
//  Duoi Hinh Bat Chu
//
//  Created by admin on 7/29/16.
//  Copyright © 2016 dotvn. All rights reserved.
//

import UIKit
import GameplayKit

protocol AnswerPanelDelegate{
    func btnAnswerClick(sender:AnyObject)
}

class AnswerPanel: UIView {
    var BUTTON_HEIGHT=0
    var BUTTON_WIDTH=0
    var ans:String!
    var delegate:AnswerPanelDelegate!
    convenience init(frame: CGRect ,answer:String) {
        self.init(frame:frame)
        //calculate size button

        BUTTON_WIDTH =  (Int(frame.width)-60)/7
        BUTTON_HEIGHT=BUTTON_WIDTH
        self.ans=answer
        drawView()
      
        
        
    }
    
    func  addRandomCharForAnswer(var arr:Array<Character>)->Array<Character>{
        let util:StringUtils=StringUtils()
        arr.append(util.randomAlphaNumericCharacter())
        if arr.count<14{
            return self.addRandomCharForAnswer(arr)
        }else{
            return arr
        }
    
    }
    //tra ve button voi dau vao la hint
    func buttonWithHint(str:String)->AnswerItem{
        var button:AnswerItem!
        for var v in self.subviews {
            if v.isKindOfClass(AnswerItem){
                let item:AnswerItem = v as! AnswerItem

                if (item.currentTitle==str&&item.hidden==false){
                    button=item
                    break
                }
                
            }
        }
        return button
    }
    func initWithAnswer(str:String){
        var characters = Array(str.characters)
         characters = characters.shuffle()

        if characters.count<14{
            characters = self.addRandomCharForAnswer(characters)
        }
        var index:Int=0
        for var v in self.subviews {
            if v.isKindOfClass(AnswerItem){
                let item:AnswerItem = v as! AnswerItem
                item.setText(String(characters[index]).uppercaseString)
                item.hidden=false
                index++
            }
        }
    }
    
    func drawView(){
        var characters = Array(ans.characters)
        characters = characters.shuffle()
        
        if characters.count<14{
           characters = self.addRandomCharForAnswer(characters)
        }
        var index:Int=0
        for var row=0;row<2;++row{
            for var i=0;i<7;++i{
                let button :AnswerItem=AnswerItem(frame: CGRectMake(CGFloat(i)%7*CGFloat(BUTTON_WIDTH+5),CGFloat(row)*CGFloat(BUTTON_HEIGHT), CGFloat(BUTTON_WIDTH), CGFloat(BUTTON_HEIGHT)));
                button.setText(String(characters[index]).uppercaseString)

              
                button.tag=i
                button.addTarget(self, action: "btnAnswerClick:", forControlEvents: UIControlEvents.TouchUpInside)
                self.addSubview(button)
                index++
                
            }
        }
        
    }
    func btnAnswerClick(sender:AnyObject){
        if (delegate != nil){
            delegate.btnAnswerClick(sender)
        }
    }
    override init(frame: CGRect) {
        // set myValue before super.init is called
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    

}
extension CollectionType {
    func shuffle() -> Array<Generator.Element> {
        var indexArray = Array(indices)
        
        let indexGenerator: AnyGenerator<Index> = anyGenerator {
            if indexArray.count == 0 { return nil }
            let count = UInt32(indexArray.count)
            let index = Int(arc4random_uniform(count))
            return indexArray.removeAtIndex(index)
        }
        return Array(PermutationGenerator(elements: self, indices: AnySequence(indexGenerator)))
    }
}
