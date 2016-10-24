//
//  MenuGameViewController.swift
//  Duoi Hinh Bat Chu
//
//  Created by admin on 8/2/16.
//  Copyright © 2016 dotvn. All rights reserved.
//

import UIKit

class MenuGameViewController: UIViewController {
    var gameType:Bool=false
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    private func gotoPlayGame(){
    
    self.performSegueWithIdentifier("PlayGame", sender: nil)

    }
    @IBAction func btTrollClick(sender: AnyObject) {
        gameType=false;
        gotoPlayGame()
    }
    @IBAction func btFolkClick(sender: AnyObject) {
        gameType=true;

        gotoPlayGame()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "PlayGame" {
            let vc = segue.destinationViewController as! PlayGameViewController
            if gameType{
                vc.actionEvent=PlayGameViewController.enumAction.Folk

            }else{
                vc.actionEvent=PlayGameViewController.enumAction.Troll

            }
        }
    }
    @IBAction func btCloseClick(sender: AnyObject) {
    }

}
