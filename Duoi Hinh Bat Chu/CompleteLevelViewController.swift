//
//  CompleteLevelViewController.swift
//  Duoi Hinh Bat Chu
//
//  Created by admin on 8/28/16.
//  Copyright © 2016 dotvn. All rights reserved.
//

import UIKit

protocol CompleteLevelViewControllerDelegate{
    func gotoHome()
    func resetLevel()
}
class CompleteLevelViewController: BaseViewController {
    var delegate:CompleteLevelViewControllerDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func btResetLevel(sender: AnyObject) {
        popSoundPlay()

        self.dismissViewControllerAnimated(true, completion: {
            if self.delegate != nil{
                self.delegate.resetLevel()
            }
        })
    }
    @IBAction func btBackClick(sender: AnyObject) {
        popSoundPlay()

        self.dismissViewControllerAnimated(true, completion: {
            if self.delegate != nil{
                self.delegate.gotoHome()
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
