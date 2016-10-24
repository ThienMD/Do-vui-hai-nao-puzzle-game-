//
//  GameOverViewController.swift
//  Duoi Hinh Bat Chu
//
//  Created by admin on 7/30/16.
//  Copyright © 2016 dotvn. All rights reserved.
//

import UIKit
protocol GameOverViewControllerDelegate{
    func didContinue()
}
class GameOverViewController: BaseViewController {
    var delegate:GameOverViewControllerDelegate!
    var questionDTO:QuestionDTO!
    @IBOutlet var lblAnswer: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    lblAnswer.text=questionDTO.dapAnCuoiCung
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btShareClick(sender: AnyObject) {
        popSoundPlay()

    }

    @IBAction func btContinueClick(sender: AnyObject) {
        popSoundPlay()

        self.dismissViewControllerAnimated(true, completion: {
            if self.delegate != nil{
                self.delegate.didContinue()
            }
        })
      
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
