//
//  GameCenterViewController.swift
//  Duoi Hinh Bat Chu
//
//  Created by admin on 8/29/16.
//  Copyright © 2016 dotvn. All rights reserved.
//

import UIKit
import GameKit
class GameCenterViewController: BaseViewController,GKGameCenterControllerDelegate {
    
    
    @IBOutlet var lblScore: UILabel!
    var score=Int()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        authPlayer()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btAddScoreClick(sender: AnyObject) {
        score++
        lblScore.text="\(score)"
    }
    
    
    
    @IBAction func btGameCenterClick(sender: AnyObject) {
        saveHighScore(score)
        showLeaderBoard()
    }
    
    func authPlayer(){
        let localPlayer=GKLocalPlayer.localPlayer()
        localPlayer.authenticateHandler={
            (view,error) in
            if view != nil{
                self.presentViewController(view!, animated: true, completion: nil)
            }else{
                print(GKLocalPlayer.localPlayer().authenticated)
            }
        }
    }
    func saveHighScore(number:Int){
        if GKLocalPlayer.localPlayer().authenticated{
           let scoreReporter=GKScore(leaderboardIdentifier: "GameLeader")
            scoreReporter.value=Int64(number)
            let scoreArray:[GKScore]=[scoreReporter]
            GKScore.reportScores(scoreArray, withCompletionHandler: nil)
        }
    }
    func showLeaderBoard(){
        let viewController=self.view.window?.rootViewController
        let gcvc=GKGameCenterViewController()
        gcvc.gameCenterDelegate=self
        viewController?.presentViewController(gcvc, animated: true, completion: nil)
    }
    func gameCenterViewControllerDidFinish(gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismissViewControllerAnimated(true, completion: nil)
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
