//
//  SoundUtils.swift
//  Duoi Hinh Bat Chu
//
//  Created by admin on 8/28/16.
//  Copyright © 2016 dotvn. All rights reserved.
//

import UIKit
import AVFoundation

class SoundUtils: NSObject {

    static let sharedHelper=SoundUtils()
    var audioPlayer:AVAudioPlayer?
    var backgroundAudioPlayer:AVAudioPlayer?

    func playBackgroundMusic(sound:String){
       let app = UIApplication.sharedApplication().delegate as! AppDelegate
        if !app.commonData.sound{
            return
        }
        let aSound=NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource(sound, ofType: "mp3")!)
        do{
            backgroundAudioPlayer=try AVAudioPlayer(contentsOfURL: aSound)
            backgroundAudioPlayer!.numberOfLoops = -1
            backgroundAudioPlayer!.prepareToPlay()
            backgroundAudioPlayer!.play()
                
            
        }catch{
            print("cannot play the file")
        }
    }
    
    func stopPlaySound(){
        backgroundAudioPlayer?.stop()
        audioPlayer?.stop()
    }
    
 
    func playSound(sound:String){
        let app = UIApplication.sharedApplication().delegate as! AppDelegate
        if !app.commonData.sound{
            return
        }
        
        let aSound=NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource(sound, ofType: "mp3")!)
        do{
            audioPlayer=try AVAudioPlayer(contentsOfURL: aSound)
            audioPlayer!.prepareToPlay()
            audioPlayer!.play()
            
            
        }catch{
            print("cannot play the file")
        }
    }

}
