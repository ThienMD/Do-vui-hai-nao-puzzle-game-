//
//  BaseViewController.swift
//  Duoi Hinh Bat Chu
//
//  Created by admin on 7/30/16.
//  Copyright © 2016 dotvn. All rights reserved.
//

import UIKit
import AVFoundation

class BaseViewController: UIViewController {
    var player: AVAudioPlayer?
    var playerBackground: AVAudioPlayer?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func trueSoundPlay() {
        SoundUtils.sharedHelper.playSound("True")

         }
    

    func failSoundPlay() {
        SoundUtils.sharedHelper.playSound("Fail")
    }
    
    func stopSound(){
        SoundUtils.sharedHelper.stopPlaySound()
    }
    func popSoundPlay() {

        SoundUtils.sharedHelper.playSound("Pop")

    }
    
    func backGroundPlay() {
        SoundUtils.sharedHelper.playBackgroundMusic("music_background_ingame")

    }
    func getAppDelegate () -> AppDelegate
    {
        return UIApplication.sharedApplication().delegate as! AppDelegate
    }
    func showErrorMessage(msg:String){
        SweetAlert().showAlert("Thông báo!", subTitle: msg, style: AlertStyle.Error)
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
