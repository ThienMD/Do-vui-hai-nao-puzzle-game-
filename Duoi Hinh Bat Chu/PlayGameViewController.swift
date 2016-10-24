//
//  PlayGameViewController.swift
//  Duoi Hinh Bat Chu
//
//  Created by admin on 7/24/16.
//  Copyright © 2016 dotvn. All rights reserved.
//

import UIKit

class PlayGameViewController: BaseViewController,AnswerPanelDelegate,TileButtonDelegate,GameOverViewControllerDelegate,CompleteLevelViewControllerDelegate {
    enum enumAction {
        case Folk
        case Troll
        
    }
    
    
    @IBOutlet var lblLevel: UILabel!
    @IBOutlet var lblRuby: UILabel!
    @IBOutlet var lblQuestion: UILabel!
    @IBOutlet var lblType: UILabel!
    var answerView :UIView=UIView(frame: CGRectMake(0, 0, 0, 0))
    var questionDTO:QuestionDTO!
    var arrayAnswerView:Array<TileButton>=Array()
    var arrayQuestion:Array<QuestionDTO>!
    var answerPanel :AnswerPanel!
    var hint:Int=0
    var ruby=0
    var actionEvent:enumAction!
    var level:Int=0
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
        self.performSelector(Selector("getData"), withObject: nil, afterDelay: 0.1)
//        getData()
       
        
        
    }
    
    func getData(){
        if actionEvent==enumAction.Folk{
            let table:FolkTable=FolkTable()
            arrayQuestion=table.getAll()
            level=getAppDelegate().getCurrentLevelFolk()
        }else{
            let table:TrollTable=TrollTable()
            arrayQuestion=table.getAll()
            level=getAppDelegate().getCurrentLevelTroll()

        }
        ruby=getAppDelegate().getRuby()
        lblRuby.text=String (ruby)
        
        if arrayQuestion.count-1<=level{
            self.performSegueWithIdentifier("Complete", sender: nil)
            return
        }
        getDataForLevel(level)
        getAnswerPanel()
        
        getViewForAnswer()
        self.view.addSubview(answerView)
        
    }
    
    func getDataForLevel(level:Int){
        questionDTO=arrayQuestion[level]
        lblQuestion.text=questionDTO.cauHoi
        lblType.text=questionDTO.theLoai
        lblLevel.text=String(level+1)

        
    }
    
    //view de hien thi o tra loi
    func getAnswerPanel(){
       answerPanel = AnswerPanel(frame: CGRectMake(10, self.view.frame.size.height-90, self.view.frame.width, 90), answer: questionDTO.dapAn)
        answerPanel.delegate=self
        self.view.addSubview(answerPanel)
    }
    
    //Xoa toan bo cau tra loi
    
    @IBAction func btClearClick(sender: AnyObject) {
        popSoundPlay()

        for var button1:TileButton  in arrayAnswerView{
            
                button1.removeText()
            
            
        }
        
    }
    
    
    @IBAction func btnBackClick(sender: AnyObject) {
        popSoundPlay()

        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    //Lay view de hien thi ket qua da nhap

    private func getViewForAnswer()->UIView{
        var marginLeftRow1:Int=0
        var marginLeftRow2:Int=0
        var total:Int=questionDTO.dapAn.characters.count
        var row1:Int=0
        var row2:Int=0
        if total>7{
            row1=7
            row2=total-7
        }else{
            row1=total
            row2=0
        }
        marginLeftRow1=(Int(self.view.frame.width)-(45*row1))/2
        marginLeftRow2=(Int(self.view.frame.width)-(45*row2-5))/2

        answerView=UIView(frame: CGRectMake(10,self.view.frame.size.height*2/3-30,400, 100))
        for var i:Int=0;i<questionDTO.dapAn.characters.count;++i{
            if(i>6){
                let button:TileButton=TileButton(frame: CGRectMake(CGFloat(45*(i%7)+marginLeftRow2), 55, 40, 40))
                button.tag=i;
                button.delegate=self
                arrayAnswerView.append(button)
                answerView.addSubview(button)
            }else{
                let button:TileButton=TileButton(frame: CGRectMake(CGFloat(45*i+marginLeftRow1), 10, 40, 40))
                button.tag=i;
                button.delegate=self
                arrayAnswerView.append(button)
                answerView.addSubview(button)

            }
            
        }
        return view
    }
    //button hien thi dap an click
    func tileButtonClick (){
        popSoundPlay()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func didContinue(){
        //increase level
        
        getDataForLevel(level)
        //increase ruby
        ruby+=10
        getAppDelegate().saveRuby(ruby)
        lblRuby.text=String (ruby)
        answerPanel.initWithAnswer(questionDTO.dapAn)
        answerView.removeFromSuperview()
        //remove all subview answerview
        arrayAnswerView.removeAll()
        for view in answerView.subviews{
            view.removeFromSuperview()
        }
        getViewForAnswer()
        self.view.addSubview(answerView)
        
    }
    func checkAnswer(){
        var isComplete:Bool=true
        var yourAnswer:String=""
        for var button1:TileButton  in arrayAnswerView{
            
            let title=button1.currentTitle
            if ((title) != nil){
                yourAnswer = yourAnswer+button1.currentTitle!
                
            }
            
            if !button1.isSet(){
                isComplete=false
            }
        }
        //Xu li khi so luong o chu tren man hinh da nhap het
        if yourAnswer.characters.count==questionDTO.dapAn.characters.count{
            if (isComplete){ //finish and check answer
                
                if (yourAnswer==questionDTO.dapAn.uppercaseString){
                    trueSoundPlay()
                    level++
                    if (actionEvent==enumAction.Folk){
                        getAppDelegate().saveLevelFolk(level)
                        
                    }else{
                        getAppDelegate().saveLevelTroll(level)
                        
                    }
                    //Kiem tra so luong cau hoi hien tai so voi level, neu lon hon, thi goto complete
                    if arrayQuestion.count-1<=level{
                        self.performSegueWithIdentifier("Complete", sender: nil)

                    }else{
                        self.performSegueWithIdentifier("FinishLevel", sender: nil)

                    }
                }else{
                    
                    failSoundPlay()
                    //animation button
                    for var button1:TileButton  in arrayAnswerView{
                      button1.animationWrong()
                    }
                    
                }
                
            }else{ // false
            }
        }

    }
    //delegate
    func btnAnswerClick(sender:AnyObject){
        
        let  bt:UIButton = sender as! UIButton
        for var button:TileButton  in arrayAnswerView{
            if !button.isSet(){
                popSoundPlay()
                button.addButton(bt)
                break
            }
        }
        //check answer
        checkAnswer()
    }
    
  
    private func alertForSuggest(){
        SweetAlert().showAlert("Thông báo!", subTitle: "Mở một ô với 20 ruby!", style: AlertStyle.Warning ,buttonTitle:"    Huỷ   ", buttonColor:UIColor.orangeColor() , otherButtonTitle:  "Đồng ý", otherButtonColor: UIColor.redColor()){ (isOtherButton) -> Void in
            if isOtherButton == true {
                
            }
            else {
                self.showHintButton()

            }
        }
    }
   private func showHintButton(){
    if ruby>=20{
        ruby-=20
        getAppDelegate().saveRuby(ruby)
        lblRuby.text=String (ruby)

        
    }else{
        self.failSoundPlay()
        SweetAlert().showAlert("Không đủ Ruby!", subTitle: "Bạn không đủ ruby để hiện gợi ý! \n Coi video quảng cáo để nhận ngay 50 ruby", style: AlertStyle.Error ,buttonTitle:"    Huỷ   ", buttonColor:UIColor.orangeColor() , otherButtonTitle:  "Đồng ý", otherButtonColor: UIColor.greenColor()){ (isOtherButton) -> Void in
            if isOtherButton == true {
                
            }
            else {
                
            }
        }

        
        return
    }
    
        //Loai bo tat ca cac ket qua khong lien quan toi suggest
        for var button1:TileButton  in arrayAnswerView{
            
            if !button1.isHint&&button1.isSet() {
                
                button1.removeText()
                //                    button1.setTitle(String(c), forState: UIControlState.Normal)
            }
            
        }
        //them vao suggest
        if (hint < questionDTO.dapAn.characters.count){
            var arr:Array<Character> = Array(questionDTO.dapAn.characters)
            
            let c:Character=arr[hint]
            var button = answerPanel.buttonWithHint(String(c))
            for var button1:TileButton  in arrayAnswerView{
                
                if !button1.isHint {
                    button1.addHint(button)
                    
                    //                    button1.setTitle(String(c), forState: UIControlState.Normal)
                    break
                }
                
            }
            hint++
            
        }
        if(hint == questionDTO.dapAn.characters.count){
            checkAnswer()
        }

    }
    @IBAction func btSuggestClick(sender: AnyObject) {
        popSoundPlay()

        alertForSuggest()
        return
       //        var searchText:String=questionDTO.dapAn.sub
    }
    override func viewWillAppear(animated: Bool) {
        hint=0
    }
    
    //===============protocol complete level==============
    func gotoHome() {
        self.dismissViewControllerAnimated(false, completion: nil)
    }
    
    func resetLevel() {
        level=0;
        if (actionEvent==enumAction.Folk){
            getAppDelegate().saveLevelFolk(level)
            
        }else{
            getAppDelegate().saveLevelTroll(level)
            
        }
        getDataForLevel(level)
        getAnswerPanel()
        getViewForAnswer()
        self.view.addSubview(answerView)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "FinishLevel" {
            let vc = segue.destinationViewController as! GameOverViewController
            vc.questionDTO=questionDTO
            vc.delegate=self
        }else   if segue.identifier == "Complete" {
            let vc1 = segue.destinationViewController as! CompleteLevelViewController
            vc1.delegate=self
        }
    }


}
extension UIColor {
    class func colorFromHex(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
