//
//  ViewController.swift
//  Soasis
//
//  Created by Alex on 22.08.19.
//  Copyright © 2019 ShyMemoriees. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var gameSettingsView: UIView!
    @IBOutlet weak var scoreTimeSeg: UISegmentedControl!
    @IBOutlet weak var difficultySeg: UISegmentedControl!
    @IBOutlet weak var musicSeg: UISegmentedControl!
    @IBOutlet weak var gestureLabel: UILabel!
    @IBOutlet weak var animePic1: UIImageView!
    @IBOutlet weak var animePic2: UIImageView!
    @IBOutlet weak var animePic3: UIImageView!
    @IBOutlet weak var animePic4: UIImageView!
    @IBOutlet weak var animePic5: UIImageView!
    @IBOutlet weak var mistakeImage: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var motionShakeSwitch: UISwitch!
    @IBOutlet weak var soasisLogo: UIImageView!
    @IBOutlet weak var startGameButton: UIButton!
    @IBOutlet weak var timeMenuLabel: UILabel!
    @IBOutlet weak var difficultyMenuLabel: UILabel!
    @IBOutlet weak var shakeGestureMenuLabel: UILabel!
    @IBOutlet weak var InGameMusicMenuLabel: UILabel!
    @IBOutlet weak var backgroundButton: UIButton!
    @IBOutlet weak var UIColorButton: UIButton!
    @IBOutlet weak var creditsButton: UIButton!
    @IBOutlet weak var backgroundSettingsView: UIView!
    @IBOutlet weak var backgroundImagePreview: UIImageView!
    @IBOutlet weak var changeBackgroundImageSeg: UISegmentedControl!
    @IBOutlet weak var backgroundBlurEffect: UIVisualEffectView!
    @IBOutlet weak var backgroundPreviewBlurEffect: UIVisualEffectView!
    @IBOutlet weak var backgroundBlurLabel: UILabel!
    @IBOutlet weak var backgroundBlurToggle: UISwitch!
    @IBOutlet weak var buyingView: UIView!
    @IBOutlet weak var buyingLabel: UILabel!
    
    
    
    
    var timer = Timer()
    var gameTimer = Timer()
    var scoreLabelTimer = Timer()
    var revertScoreLabelTimer = Timer()
    
    var timeInt = 0
    var difficultyInt = 0.0
    var scoreInt = 0
    var selectedMusic = 0
    var coins = 0
    var costs = Int()
    var itemNumber = Int()
    
    var whatToBuy = String()
    
    var playing = false
    var harderByScore = false
    var musicIsSelected = false
    var inMainMenu = true
    var lightState = false
    var backgroundViewIsHidden = true
    var blurEnabled = false
    
    var time1Unlocked = false
    var time2Unlocked = false
    var time3Unlocked = false
    var time4Unlocked = false
    var difficulty1Unlocked = false
    var difficulty2Unlocked = false
    var difficulty3Unlocked = false
    var shakeSwitchUnlocked = false
    var music1Unlocked = false
    var music2Unlocked = false
    var UIColorUnlocked = false
    var wallpaper1Unlocked = false
    var wallpaper2Unlocked = false
    var wallpaper3Unlocked = false
    var wallpaperBlurUnlocked = false
    
    var highscore = 0
    
    let defaults = UserDefaults.standard
    
    struct Keys {
        
        static let highscore = "HighScore"
        static let UIColorState = "UIColorState"
        static let Wallpaper = "SelectedWallpaper"
        static let blurState = "WallpaperBlurEnabled"
        static let coinAmount = "Coins"
        
        static let time1Unlock = "time1Unlocked"
        static let time2Unlock = "time2Unlocked"
        static let time3Unlock = "time3Unlocked"
        static let time4Unlock = "time4Unlocked"
        static let difficulty1Unlock = "difficulty1Unlocked"
        static let difficulty2Unlock = "difficulty2Unlocked"
        static let difficulty3Unlock = "difficulty3Unlocked"
        static let shakeSwitchUnlock = "shakeSwitchUnlocked"
        static let music1Unlock = "music1Unlocked"
        static let music2Unlock = "music2Unlocked"
        static let music3Unlock = "music3Unlocked"
        static let UIColorUnlock = "UIColorUnlocked"
        static let wallpaper1Unlock = "wallpaper1Unlocked"
        static let wallpaper2Unlock = "wallpaper2Unlocked"
        static let wallpaper3Unlock = "wallpaper3Unlocked"
        static let wallpaperBlurUnlock = "wallpaperBlurUnlocked"
        
    }

    
    var player1: AVAudioPlayer = AVAudioPlayer()
    let mainBackgroundMusic = Bundle.main.path(forResource: "mainBackgroundMusic", ofType: "wav")
    
    var player2: AVAudioPlayer = AVAudioPlayer()
    let playingBackgroundMusic = Bundle.main.path(forResource: "gameBackgroundMusic1", ofType: "wav")
    let playingBackgroundMusic2 = Bundle.main.path(forResource: "gameBackgroundMusic2", ofType: "wav")
    let playingBackgroundMusic3 = Bundle.main.path(forResource: "gameBackgroundMusic3", ofType: "wav")
    
    var player3:AVAudioPlayer = AVAudioPlayer()
    let buttonTapped = Bundle.main.path(forResource: "buttonSound", ofType: "wav")
    let gameOver = Bundle.main.path(forResource: "gameOver", ofType: "wav")
    let gameStart = Bundle.main.path(forResource: "gameStart", ofType: "wav")
    let gettingPoint = Bundle.main.path(forResource: "gettingAPoint", ofType: "wav")
    let losingPoint = Bundle.main.path(forResource: "losingAPoint", ofType: "wav")
    let gettingFaster = Bundle.main.path(forResource: "harderByScore", ofType: "wav")
    let switchToggled = Bundle.main.path(forResource: "motionShakeToggle", ofType: "wav")
    let buySuccessful = Bundle.main.path(forResource: "buySuccessful", ofType: "wav")
    let buyUnsuccessful = Bundle.main.path(forResource: "buyUnsuccessful", ofType: "wav")

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(swipeGestures))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        self.view.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(swipeGestures))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
        self.view.addGestureRecognizer(swipeLeft)
        
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(swipeGestures))
        swipeUp.direction = UISwipeGestureRecognizer.Direction.up
        self.view.addGestureRecognizer(swipeUp)
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(swipeGestures))
        swipeDown.direction = UISwipeGestureRecognizer.Direction.down
        self.view.addGestureRecognizer(swipeDown)
        
        self.homeBackgroundMusic()
        self.checkForScoreAtViewDidLoad()
        self.setCoinAmountOnViewDidLoad()
        self.setBoughtItemsOnViewDidLoad()
        self.setUIColorOnViewDidLoad()
        self.setWallpaperOnViewDidLoad()
        self.setBlurStateOnViewDidLoad()
        self.changeScoreLabel()
        
        
        self.animePic1.alpha = 0
        self.animePic2.alpha = 0
        self.animePic3.alpha = 0
        self.animePic4.alpha = 0
        self.animePic5.alpha = 0
        self.mistakeImage.alpha = 0
        self.gameSettingsView.layer.cornerRadius = 10
        self.gestureLabel.layer.cornerRadius = 10
        self.backgroundSettingsView.layer.cornerRadius = 10
        self.buyingView.layer.cornerRadius = 10
        self.backgroundSettingsView.isHidden = true
        self.buyingView.isHidden = true
        self.gestureLabel.alpha = 0
        self.timeLabel.alpha = 0
        self.backgroundImage.alpha = 0.4
        self.menuButton.isHidden = true
        self.inMainMenu = true
        
        self.becomeFirstResponder()
        
    }
    
    override func becomeFirstResponder() -> Bool {
        
        return true
        
    }
    
    
    
    @IBAction func timeSelection(_ sender: Any) {
        
        if (self.scoreTimeSeg.selectedSegmentIndex == 0) {
            
            timeInt = 20
            self.buttonSound()
            
        } else if (self.scoreTimeSeg.selectedSegmentIndex == 1) {
            
            if (time1Unlocked) {
                
                timeInt = 35
                self.buttonSound()
                
            } else if (!(time1Unlocked)) {
                
                whatToBuy = "35 Seconds"
                costs = 500
                itemNumber = 1
                self.wantToBuy()
                self.scoreTimeSeg.selectedSegmentIndex = 0
                timeInt = 20
                
            }
            
        } else if (self.scoreTimeSeg.selectedSegmentIndex == 2) {
            
            if (time2Unlocked) {
                
                timeInt = 50
                
            } else if (!(time2Unlocked)) {
                
                whatToBuy = "50 Seconds"
                costs = 1000
                itemNumber = 2
                self.wantToBuy()
                self.scoreTimeSeg.selectedSegmentIndex = 0
                timeInt = 20
                
            }
            
        } else if (self.scoreTimeSeg.selectedSegmentIndex == 3) {
            
            if (time3Unlocked) {
                
                timeInt = 60
                self.buttonSound()
                
            } else if (!(time3Unlocked)) {
                
                whatToBuy = "60 Seconds"
                costs = 1500
                itemNumber = 3
                self.wantToBuy()
                self.scoreTimeSeg.selectedSegmentIndex = 0
                timeInt = 20
                
            }
            
        } else if (self.scoreTimeSeg.selectedSegmentIndex == 4) {
            
            if (time4Unlocked) {
                
                timeInt = 999999999
                self.buttonSound()
                
            } else if (!(time4Unlocked)) {
                
                whatToBuy = "∞ Seconds"
                costs = 2000
                itemNumber = 4
                self.wantToBuy()
                self.scoreTimeSeg.selectedSegmentIndex = 0
                timeInt = 20
                
            }
            
        }
        
    }
    
    @IBAction func difficultySelection(_ sender: Any) {
        
        if (self.difficultySeg.selectedSegmentIndex == 0) {
            
            difficultyInt = 2.0
            self.buttonSound()
            
        } else if (self.difficultySeg.selectedSegmentIndex == 1) {
            
            if (difficulty1Unlocked) {
                
                difficultyInt = 1.0
                self.buttonSound()
                
            } else if (!(difficulty1Unlocked)) {
                
                whatToBuy = "^-^"
                costs = 800
                itemNumber = 5
                self.wantToBuy()
                self.difficultySeg.selectedSegmentIndex = 0
                difficultyInt = 2.0
                
            }
            
        } else if (self.difficultySeg.selectedSegmentIndex == 2) {
            
            if (difficulty2Unlocked) {
                
                difficultyInt = 0.5
                self.buttonSound()
                
            } else if (!(difficulty2Unlocked)) {
                
                whatToBuy = "HACKZ"
                costs = 1600
                itemNumber = 6
                self.wantToBuy()
                self.difficultySeg.selectedSegmentIndex = 0
                difficultyInt = 2.0
                
            }
            
        } else if (self.difficultySeg.selectedSegmentIndex == 3) {
            
            if (difficulty3Unlocked) {
                
                difficultyInt = 2.5
                harderByScore = true
                self.buttonSound()
                
            } else if (!(difficulty3Unlocked)) {
                
                whatToBuy = "By Score"
                costs = 2400
                itemNumber = 7
                self.wantToBuy()
                self.difficultySeg.selectedSegmentIndex = 0
                difficultyInt = 2.0
                
            }
            
        }
        
    }
    
    @IBAction func musicSelection(_ sender: Any) {
        
        if (self.musicSeg.selectedSegmentIndex == 0) {
            
            musicIsSelected = true
            selectedMusic = 1
            self.buttonSound()
            
        } else if (musicSeg.selectedSegmentIndex == 1) {
            
            if (music1Unlocked) {
                
                musicIsSelected = true
                selectedMusic = 2
                self.buttonSound()
                
            } else if (!(music1Unlocked)) {
                
                whatToBuy = "Big Skies"
                costs = 1000
                itemNumber = 8
                self.wantToBuy()
                self.musicSeg.selectedSegmentIndex = 0
                selectedMusic = 1
                musicIsSelected = true
                
            }
            
        } else if (musicSeg.selectedSegmentIndex == 2) {
            
            if (music2Unlocked) {
                
                musicIsSelected = true
                selectedMusic = 3
                self.buttonSound()
                
            } else if (!(music2Unlocked)) {
                
                whatToBuy = "Tokyo Rain"
                costs = 2000
                itemNumber = 9
                self.wantToBuy()
                self.musicSeg.selectedSegmentIndex = 0
                selectedMusic = 1
                musicIsSelected = true
                
            }
            
        }
        
    }
    
    @IBAction func motionShakeToggled(_ sender: Any) {
        
        if (shakeSwitchUnlocked) {
            
            if (motionShakeSwitch.isOn) {
                
                motionShakeToggledSound()
                
            } else if (!(motionShakeSwitch.isOn)) {
                
                motionShakeToggledSound()
                
            }
            
        } else if (!(shakeSwitchUnlocked)) {
            
            whatToBuy = "Motion Shake"
            costs = 1300
            itemNumber = 10
            self.wantToBuy()
            motionShakeSwitch.isOn = false
            
        }
        
    }
    
    
    
    
    
    
    
    @IBAction func startGame(_ sender: Any) {
        
        if (timeInt == 20 || timeInt == 35 || timeInt == 50 || timeInt == 60 || timeInt == 999999999) {
            if (difficultyInt != 0.0) {
                if (musicIsSelected) {
                    inMainMenu = false
                    
                    scoreInt = 0
                    scoreLabelTimer.invalidate()
                    scoreLabel.text = "Score: \(scoreInt)"

                    if (!(self.scoreTimeSeg.selectedSegmentIndex == 4)) {
                        
                        timeLabel.text = String("Time: \(timeInt)")
                        
                    } else {
                        
                        timeLabel.text = "∞"
                        
                    }
                    
                    scoreLabel.text = "Score: 0"
                    player1.stop()
                    self.gameBackgroundMusic()
                    self.gameStartSound()
                    
                    UIView.animate(withDuration: 1.0, animations: {
                        
                        self.backgroundImage.alpha = 1
                        self.gameSettingsView.isHidden = true
                        self.gestureLabel.alpha = 1
                        self.timeLabel.alpha = 1
                        self.menuButton.isHidden = false
                        self.soasisLogo.alpha = 0
                        
                    }, completion: nil)
                    
                    timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
                    
                    self.gestures()
                    
                    playing = true
                    
                } else {
                    
                    self.warning()
                    
                }
                
            } else {
                
                self.warning()
                
            }
            
        } else {
            
            self.warning()
            
        }
        
    }
    
    @objc func updateTimer() {
        
        timeInt -= 1
        
        if (!(self.scoreTimeSeg.selectedSegmentIndex == 4)) {
            
            timeLabel.text = String("Time: \(timeInt)")
            
        } else {
            
            timeLabel.text = "∞"
            
        }
        
        if (timeInt == 0) {
            
            self.saveHighScore()
            self.saveCoins()
            self.gameEnded()
            
        }
        
    }
    
    @objc func gestures() {
        
        var array = ["⇠", "⇢", "⇡", "⇣"]
        
        if (motionShakeSwitch.isOn) {
            
            array.append("⌁")
            
        }
        
        if (!(motionShakeSwitch.isOn)) {
            
            if (array.count == 4) {
                
                array.removeAll()
                array = ["⇠", "⇢", "⇡", "⇣"]
                
            }
            
        }
        
        let randomGesture = Int(arc4random_uniform(UInt32(array.count)))
        gestureLabel.text = array[randomGesture]
        
        if (scoreLabel.text == "Score: 5" && harderByScore) {
            
            difficultyInt = 2.0
            self.gettingFasterSound()
            
        } else if (scoreLabel.text == "Score: 10" && harderByScore) {
            
            difficultyInt = 1.5
            self.gettingFasterSound()
            
        } else if (scoreLabel.text == "Score: 15" && harderByScore) {
            
            difficultyInt = 1.0
            self.gettingFasterSound()
            
        } else if (scoreLabel.text == "Score: 20" && harderByScore) {
            
            difficultyInt = 0.5
            self.gettingFasterSound()
            
        } else if (scoreLabel.text == "Score: 25" && harderByScore) {
            
            difficultyInt = 0.3
            self.gettingFasterSound()
            
        }
        
        gameTimer = Timer.scheduledTimer(timeInterval: difficultyInt, target: self, selector: #selector(gestures), userInfo: nil, repeats: false)
        
    }
    
    @objc func swipeGestures(sender: UISwipeGestureRecognizer) {
        
        if (playing) {
            
            if (sender.direction == UISwipeGestureRecognizer.Direction.right) {
                
                gameTimer.invalidate()
                
                if (gestureLabel.text == "⇢") {
                    
                    scoreInt += 1
                    if (difficultySeg.selectedSegmentIndex == 0) {
                        
                        if (scoreInt < 10) {
                            
                            coins += 2
                            
                        } else if (scoreInt >= 20) {
                            
                            coins += 3
                            
                        } else if (scoreInt >= 40) {
                            
                            coins += 4
                            
                        } else if (scoreInt >= 60) {
                            
                            coins += 5
                            
                        } else if (scoreInt >= 80) {
                            
                            coins += 6
                            
                        } else if (scoreInt >= 100) {
                            
                            coins += 7
                            
                        }
                        
                    } else if (difficultySeg.selectedSegmentIndex == 1) {
                        
                        if (scoreInt < 10) {
                            
                            coins += 3
                            
                        } else if (scoreInt >= 20) {
                            
                            coins += 4
                            
                        } else if (scoreInt >= 40) {
                            
                            coins += 5
                            
                        } else if (scoreInt >= 60) {
                            
                            coins += 6
                            
                        } else if (scoreInt >= 80) {
                            
                            coins += 7
                            
                        } else if (scoreInt >= 100) {
                            
                            coins += 8
                            
                        }
                        
                    } else if (difficultySeg.selectedSegmentIndex == 2) {
                        
                        if (scoreInt < 10) {
                            
                            coins += 6
                            
                        } else if (scoreInt >= 20) {
                            
                            coins += 7
                            
                        } else if (scoreInt >= 40) {
                            
                            coins += 8
                            
                        } else if (scoreInt >= 60) {
                            
                            coins += 9
                            
                        } else if (scoreInt >= 80) {
                            
                            coins += 10
                            
                        } else if (scoreInt >= 100) {
                            
                            coins += 11
                            
                        }
                        
                    } else if (difficultySeg.selectedSegmentIndex == 3) {
                        
                        if (scoreInt < 10) {
                            
                            coins += 9
                            
                        } else if (scoreInt >= 20) {
                            
                            coins += 10
                            
                        } else if (scoreInt >= 40) {
                            
                            coins += 11
                            
                        } else if (scoreInt >= 60) {
                            
                            coins += 12
                            
                        } else if (scoreInt >= 80) {
                            
                            coins += 13
                            
                        } else if (scoreInt >= 100) {
                            
                            coins += 14
                            
                        }
                        
                    }
                    scoreLabel.text = String("Score: \(scoreInt)")
                    self.gettingPointSound()
                    
                    self.showRender1()
                    
                    self.gestures()
                    
                } else {
                    
                    scoreInt -= 1
                    if (difficultySeg.selectedSegmentIndex == 0) {
                        
                        coins -= 3
                        
                    } else if (difficultySeg.selectedSegmentIndex == 1) {
                        
                        coins -= 6
                        
                    } else if (difficultySeg.selectedSegmentIndex == 2) {
                        
                        coins -= 9
                        
                    } else if (difficultySeg.selectedSegmentIndex == 3) {
                        
                        coins -= 12
                        
                    }
                    scoreLabel.text = String("Score: \(scoreInt)")
                    self.showMistakeImage()
                    self.losingPointSound()
                    
                    
                    self.gestures()
                    
                }
                
            }
            
            if (sender.direction == UISwipeGestureRecognizer.Direction.left) {
                
                gameTimer.invalidate()
                
                if (gestureLabel.text == "⇠") {
                    
                    scoreInt += 1
                    if (difficultySeg.selectedSegmentIndex == 0) {
                        
                        if (scoreInt < 10) {
                            
                            coins += 3
                            
                        } else if (scoreInt >= 20) {
                            
                            coins += 4
                            
                        } else if (scoreInt >= 40) {
                            
                            coins += 5
                            
                        } else if (scoreInt >= 60) {
                            
                            coins += 6
                            
                        } else if (scoreInt >= 80) {
                            
                            coins += 7
                            
                        } else if (scoreInt >= 100) {
                            
                            coins += 8
                            
                        }
                        
                    } else if (difficultySeg.selectedSegmentIndex == 1) {
                        
                        if (scoreInt < 10) {
                            
                            coins += 5
                            
                        } else if (scoreInt >= 20) {
                            
                            coins += 4
                            
                        } else if (scoreInt >= 40) {
                            
                            coins += 6
                            
                        } else if (scoreInt >= 60) {
                            
                            coins += 7
                            
                        } else if (scoreInt >= 80) {
                            
                            coins += 8
                            
                        } else if (scoreInt >= 100) {
                            
                            coins += 9
                            
                        }
                        
                    } else if (difficultySeg.selectedSegmentIndex == 2) {
                        
                        if (scoreInt < 10) {
                            
                            coins += 7
                            
                        } else if (scoreInt >= 20) {
                            
                            coins += 8
                            
                        } else if (scoreInt >= 40) {
                            
                            coins += 9
                            
                        } else if (scoreInt >= 60) {
                            
                            coins += 10
                            
                        } else if (scoreInt >= 80) {
                            
                            coins += 11
                            
                        } else if (scoreInt >= 100) {
                            
                            coins += 12
                            
                        }
                        
                    } else if (difficultySeg.selectedSegmentIndex == 3) {
                        
                        if (scoreInt < 10) {
                            
                            coins += 9
                            
                        } else if (scoreInt >= 20) {
                            
                            coins += 10
                            
                        } else if (scoreInt >= 40) {
                            
                            coins += 11
                            
                        } else if (scoreInt >= 60) {
                            
                            coins += 12
                            
                        } else if (scoreInt >= 80) {
                            
                            coins += 13
                            
                        } else if (scoreInt >= 100) {
                            
                            coins += 14
                            
                        }
                        
                    }
                    scoreLabel.text = String("Score: \(scoreInt)")
                    self.gettingPointSound()
                    
                    self.showRender2()
                    
                    self.gestures()
                    
                } else {
                    
                    scoreInt -= 1
                    if (difficultySeg.selectedSegmentIndex == 0) {
                        
                        coins -= 3
                        
                    } else if (difficultySeg.selectedSegmentIndex == 1) {
                        
                        coins -= 6
                        
                    } else if (difficultySeg.selectedSegmentIndex == 2) {
                        
                        coins -= 9
                        
                    } else if (difficultySeg.selectedSegmentIndex == 3) {
                        
                        coins -= 12
                        
                    }
                    scoreLabel.text = String("Score: \(scoreInt)")
                    self.showMistakeImage()
                    self.losingPointSound()
                    
                    self.gestures()
                    
                }
                
            }
            
            if (sender.direction == UISwipeGestureRecognizer.Direction.up) {
                
                gameTimer.invalidate()
                
                if (gestureLabel.text == "⇡") {
                    
                    scoreInt += 1
                    if (difficultySeg.selectedSegmentIndex == 0) {
                        
                        if (scoreInt < 10) {
                            
                            coins += 3
                            
                        } else if (scoreInt >= 20) {
                            
                            coins += 4
                            
                        } else if (scoreInt >= 40) {
                            
                            coins += 5
                            
                        } else if (scoreInt >= 60) {
                            
                            coins += 6
                            
                        } else if (scoreInt >= 80) {
                            
                            coins += 7
                            
                        } else if (scoreInt >= 100) {
                            
                            coins += 8
                            
                        }
                        
                    } else if (difficultySeg.selectedSegmentIndex == 1) {
                        
                        if (scoreInt < 10) {
                            
                            coins += 4
                            
                        } else if (scoreInt >= 20) {
                            
                            coins += 5
                            
                        } else if (scoreInt >= 40) {
                            
                            coins += 6
                            
                        } else if (scoreInt >= 60) {
                            
                            coins += 7
                            
                        } else if (scoreInt >= 80) {
                            
                            coins += 8
                            
                        } else if (scoreInt >= 100) {
                            
                            coins += 9
                            
                        }
                        
                    } else if (difficultySeg.selectedSegmentIndex == 2) {
                        
                        if (scoreInt < 10) {
                            
                            coins += 7
                            
                        } else if (scoreInt >= 20) {
                            
                            coins += 4
                            
                        } else if (scoreInt >= 40) {
                            
                            coins += 8
                            
                        } else if (scoreInt >= 60) {
                            
                            coins += 9
                            
                        } else if (scoreInt >= 80) {
                            
                            coins += 10
                            
                        } else if (scoreInt >= 100) {
                            
                            coins += 11
                            
                        }
                        
                    } else if (difficultySeg.selectedSegmentIndex == 3) {
                        
                        if (scoreInt < 10) {
                            
                            coins += 9
                            
                        } else if (scoreInt >= 20) {
                            
                            coins += 10
                            
                        } else if (scoreInt >= 40) {
                            
                            coins += 11
                            
                        } else if (scoreInt >= 60) {
                            
                            coins += 12
                            
                        } else if (scoreInt >= 80) {
                            
                            coins += 13
                            
                        } else if (scoreInt >= 100) {
                            
                            coins += 14
                            
                        }
                        
                    }
                    scoreLabel.text = String("Score: \(scoreInt)")
                    self.gettingPointSound()
                    
                    self.showRender3()
                    
                    self.gestures()
                    
                } else {
                    
                    scoreInt -= 1
                    if (difficultySeg.selectedSegmentIndex == 0) {
                        
                        coins -= 3
                        
                    } else if (difficultySeg.selectedSegmentIndex == 1) {
                        
                        coins -= 6
                        
                    } else if (difficultySeg.selectedSegmentIndex == 2) {
                        
                        coins -= 9
                        
                    } else if (difficultySeg.selectedSegmentIndex == 3) {
                        
                        coins -= 12
                        
                    }
                    scoreLabel.text = String("Score: \(scoreInt)")
                    self.showMistakeImage()
                    self.losingPointSound()
                    
                    self.gestures()
                    
                }
                
            }
            
            if (sender.direction == UISwipeGestureRecognizer.Direction.down) {
                
                gameTimer.invalidate()
                
                if (gestureLabel.text == "⇣") {
                    
                    scoreInt += 1
                    if (difficultySeg.selectedSegmentIndex == 0) {
                        
                        if (scoreInt < 10) {
                            
                            coins += 3
                            
                        } else if (scoreInt >= 20) {
                            
                            coins += 4
                            
                        } else if (scoreInt >= 40) {
                            
                            coins += 5
                            
                        } else if (scoreInt >= 60) {
                            
                            coins += 6
                            
                        } else if (scoreInt >= 80) {
                            
                            coins += 7
                            
                        } else if (scoreInt >= 100) {
                            
                            coins += 8
                            
                        }
                        
                    } else if (difficultySeg.selectedSegmentIndex == 1) {
                        
                        if (scoreInt < 10) {
                            
                            coins += 5
                            
                        } else if (scoreInt >= 20) {
                            
                            coins += 6
                            
                        } else if (scoreInt >= 40) {
                            
                            coins += 7
                            
                        } else if (scoreInt >= 60) {
                            
                            coins += 8
                            
                        } else if (scoreInt >= 80) {
                            
                            coins += 9
                            
                        } else if (scoreInt >= 100) {
                            
                            coins += 10
                            
                        }
                        
                    } else if (difficultySeg.selectedSegmentIndex == 2) {
                        
                        if (scoreInt < 10) {
                            
                            coins += 7
                            
                        } else if (scoreInt >= 20) {
                            
                            coins += 8
                            
                        } else if (scoreInt >= 40) {
                            
                            coins += 9
                            
                        } else if (scoreInt >= 60) {
                            
                            coins += 10
                            
                        } else if (scoreInt >= 80) {
                            
                            coins += 11
                            
                        } else if (scoreInt >= 100) {
                            
                            coins += 12
                            
                        }
                        
                    } else if (difficultySeg.selectedSegmentIndex == 3) {
                        
                        if (scoreInt < 10) {
                            
                            coins += 9
                            
                        } else if (scoreInt >= 20) {
                            
                            coins += 10
                            
                        } else if (scoreInt >= 40) {
                            
                            coins += 11
                            
                        } else if (scoreInt >= 60) {
                            
                            coins += 12
                            
                        } else if (scoreInt >= 80) {
                            
                            coins += 13
                            
                        } else if (scoreInt >= 100) {
                            
                            coins += 14
                            
                        }
                        
                    }
                    scoreLabel.text = String("Score: \(scoreInt)")
                    self.gettingPointSound()
                    
                    self.showRender4()
                    
                    self.gestures()
                    
                } else {
                    
                    scoreInt -= 1
                    if (difficultySeg.selectedSegmentIndex == 0) {
                        
                        coins -= 3
                        
                    } else if (difficultySeg.selectedSegmentIndex == 1) {
                        
                        coins -= 6
                        
                    } else if (difficultySeg.selectedSegmentIndex == 2) {
                        
                        coins -= 9
                        
                    } else if (difficultySeg.selectedSegmentIndex == 3) {
                        
                        coins -= 12
                        
                    }
                    scoreLabel.text = String("Score: \(scoreInt)")
                    self.showMistakeImage()
                    self.losingPointSound()
                    
                    self.gestures()
                    
                }
                
            }
            
        }
        
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        
        if (motion == .motionShake) {
            
            if (motionShakeSwitch.isOn) {
                
                if (playing) {
                            
                            gameTimer.invalidate()
                            
                            if (gestureLabel.text == "⌁") {
                                
                                scoreInt += 2
                                if (difficultySeg.selectedSegmentIndex == 0) {
                                    
                                    if (scoreInt < 10) {
                                        
                                        coins += 5
                                        
                                    } else if (scoreInt >= 20) {
                                        
                                        coins += 6
                                        
                                    } else if (scoreInt >= 40) {
                                        
                                        coins += 7
                                        
                                    } else if (scoreInt >= 60) {
                                        
                                        coins += 8
                                        
                                    } else if (scoreInt >= 80) {
                                        
                                        coins += 9
                                        
                                    } else if (scoreInt >= 100) {
                                        
                                        coins += 10
                                        
                                    }
                                    
                                } else if (difficultySeg.selectedSegmentIndex == 1) {
                                    
                                    if (scoreInt < 10) {
                                        
                                        coins += 7
                                        
                                    } else if (scoreInt >= 20) {
                                        
                                        coins += 8
                                        
                                    } else if (scoreInt >= 40) {
                                        
                                        coins += 9
                                        
                                    } else if (scoreInt >= 60) {
                                        
                                        coins += 10
                                        
                                    } else if (scoreInt >= 80) {
                                        
                                        coins += 11
                                        
                                    } else if (scoreInt >= 100) {
                                        
                                        coins += 12
                                        
                                    }
                                    
                                } else if (difficultySeg.selectedSegmentIndex == 2) {
                                    
                                    if (scoreInt < 10) {
                                        
                                        coins += 9
                                        
                                    } else if (scoreInt >= 20) {
                                        
                                        coins += 10
                                        
                                    } else if (scoreInt >= 40) {
                                        
                                        coins += 11
                                        
                                    } else if (scoreInt >= 60) {
                                        
                                        coins += 12
                                        
                                    } else if (scoreInt >= 80) {
                                        
                                        coins += 13
                                        
                                    } else if (scoreInt >= 100) {
                                        
                                        coins += 14
                                        
                                    }
                                    
                                } else if (difficultySeg.selectedSegmentIndex == 3) {
                                    
                                    if (scoreInt < 10) {
                                        
                                        coins += 11
                                        
                                    } else if (scoreInt >= 20) {
                                        
                                        coins += 12
                                        
                                    } else if (scoreInt >= 40) {
                                        
                                        coins += 13
                                        
                                    } else if (scoreInt >= 60) {
                                        
                                        coins += 14
                                        
                                    } else if (scoreInt >= 80) {
                                        
                                        coins += 15
                                        
                                    } else if (scoreInt >= 100) {
                                        
                                        coins += 16
                                        
                                    }
                                    
                                }
                                scoreLabel.text = String("Score: \(scoreInt)")
                                self.gettingPointSound()
                                
                                self.showRender5()
                                
                                self.gestures()
                                
                            } else {
                                
                                scoreInt -= 1
                                if (difficultySeg.selectedSegmentIndex == 0) {
                                    
                                    coins -= 3
                                    
                                } else if (difficultySeg.selectedSegmentIndex == 1) {
                                    
                                    coins -= 6
                                    
                                } else if (difficultySeg.selectedSegmentIndex == 2) {
                                    
                                    coins -= 9
                                    
                                } else if (difficultySeg.selectedSegmentIndex == 3) {
                                    
                                    coins -= 12
                                    
                                }
                                scoreLabel.text = String("Score: \(scoreInt)")
                                self.showMistakeImage()
                                self.losingPointSound()
                                
                                self.gestures()
                                
                            }
                            
                        }
                        
                    }
                    
                }
                
            }
    
    func saveCoins() {
        
        defaults.set(coins, forKey: Keys.coinAmount)
        
    }
    
    func setCoinAmountOnViewDidLoad() {
        
        coins = defaults.integer(forKey: Keys.coinAmount)
        
    }
    
    func gameEnded() {
        
        playing = false
        inMainMenu = true
        timer.invalidate()
        gameTimer.invalidate()
        player2.stop()
            
            scoreLabelTimer = Timer.scheduledTimer(timeInterval: 4.0, target: self, selector: #selector(changeScoreLabel), userInfo: nil, repeats: false)
        
        UIView.animate(withDuration: 1.0, animations: {
            
            self.backgroundImage.alpha = 0.4
            self.gameSettingsView.isHidden = false
            self.gestureLabel.alpha = 0
            self.timeLabel.alpha = 0
            self.menuButton.isHidden = true
            self.soasisLogo.alpha = 1
            
        }, completion: nil)
        
        if (self.scoreTimeSeg.selectedSegmentIndex == 0) {
            
            timeInt = 20
            
        } else if (self.scoreTimeSeg.selectedSegmentIndex == 1) {
            
            timeInt = 35
            
        } else if (self.scoreTimeSeg.selectedSegmentIndex == 2) {
            
            timeInt = 50
            
        } else if (self.scoreTimeSeg.selectedSegmentIndex == 3) {
            
            timeInt = 60
            
        } else if (self.scoreTimeSeg.selectedSegmentIndex == 4) {
                              
            timeInt = 999999999
            self.buttonSound()
                              
        }
        
        if (self.difficultySeg.selectedSegmentIndex == 0) {
            
            difficultyInt = 2.0
            
        } else if (self.difficultySeg.selectedSegmentIndex == 1) {
            
            difficultyInt = 1.0
            
        } else if (self.difficultySeg.selectedSegmentIndex == 2) {
            
            difficultyInt = 0.5
            
        } else if (self.difficultySeg.selectedSegmentIndex == 3) {
            
            difficultyInt = 2.0
            harderByScore = true
            
        }
        
        if (musicSeg.selectedSegmentIndex == 0) {
            
            selectedMusic = 1
            musicIsSelected = true
            
        } else if (musicSeg.selectedSegmentIndex == 1) {
            
            selectedMusic = 2
            musicIsSelected = true
            
        } else if (musicSeg.selectedSegmentIndex == 2) {
            
            selectedMusic = 3
            musicIsSelected = true
            
        }
        
    }
    
    func homeBackgroundMusic() {
        
        do {
            
            try player1 = AVAudioPlayer(contentsOf: URL(fileURLWithPath: mainBackgroundMusic!))
            
        }
        
        catch {
            
            print(error)
            
        }
        
        player1.play()
        
    }
    
    func gameBackgroundMusic() {
        
        if (selectedMusic == 1) {
            
            do {
                
                try player2 = AVAudioPlayer(contentsOf: URL(fileURLWithPath: playingBackgroundMusic!))
                
            }
            
            catch {
                
                print(error)
                
            }
            
        } else if (selectedMusic == 2) {
            
            do {
                
                try player2 = AVAudioPlayer(contentsOf: URL(fileURLWithPath: playingBackgroundMusic2!))
                
            }
            
            catch {
                
                print(error)
                
            }
            
        } else if (selectedMusic == 3) {
            
            do {
                
                try player2 = AVAudioPlayer(contentsOf: URL(fileURLWithPath: playingBackgroundMusic3!))
                
            }
            
            catch {
                
                print(error)
                
            }
            
        }
        
        player2.play()
        
    }
    
    func buttonSound() {
        
        do {
            
            try player3 = AVAudioPlayer(contentsOf: URL(fileURLWithPath: buttonTapped!))
            
        }
        
        catch {
            
            print(error)
            
        }
        
        player3.play()
        
    }
    
    func gameOverSound() {
        
        do {
            
            try player3 = AVAudioPlayer(contentsOf: URL(fileURLWithPath: gameOver!))
            
        }
        
        catch {
            
            print(error)
            
        }
        
        player3.play()
        
    }
    
    func gameStartSound() {
        
        do {
            
            try player3 = AVAudioPlayer(contentsOf: URL(fileURLWithPath: gameStart!))
            
        }
        
        catch {
            
            print(error)
            
        }
        
        player3.play()
        
    }
    
    func gettingPointSound() {
        
        do {
            
            try player3 = AVAudioPlayer(contentsOf: URL(fileURLWithPath: gettingPoint!))
            
        }
        
        catch {
            
            print(error)
            
        }
        
        player3.play()
        
    }
    
    func losingPointSound() {
        
        do {
            
            try player3 = AVAudioPlayer(contentsOf: URL(fileURLWithPath: losingPoint!))
            
        }
        
        catch {
            
            print(error)
            
        }
        
        player3.play()
        
    }
    
    func gettingFasterSound() {
        
        do {
            
            try player3 = AVAudioPlayer(contentsOf: URL(fileURLWithPath: gettingFaster!))
            
        }
        
        catch {
            
            print(error)
            
        }
        
        player3.play()
        
    }
    
    func motionShakeToggledSound() {
        
        do {
            
            try player3 = AVAudioPlayer(contentsOf: URL(fileURLWithPath: switchToggled!))
            
        }
        
        catch {
            
            print(error)
            
        }
        
        player3.play()
        
    }
    
    func buySuccessfulSound() {
        
        do {
            
            try player3 = AVAudioPlayer(contentsOf: URL(fileURLWithPath: buySuccessful!))
            
        }
        
        catch {
            
            print(error)
            
        }
        
        player3.play()
        
    }
    
    func buyUnsuccessfulSound() {
        
        do {
            
            try player3 = AVAudioPlayer(contentsOf: URL(fileURLWithPath: buyUnsuccessful!))
            
        }
        
        catch {
            
            print(error)
            
        }
        
        player3.play()
        
    }
    
    func showRender1() {
        
        UIView.animate(withDuration: 0.2, animations: {
            
            self.animePic1.alpha = 1
            Timer.scheduledTimer(timeInterval: 0.4, target: self, selector: #selector(self.hideRender1), userInfo: nil, repeats: false)
            
        }, completion: nil)
        
    }
    
    @objc func hideRender1() {
        
        UIView.animate(withDuration: 0.2, animations: {
            
            self.animePic1.alpha = 0
            
        }, completion: nil)
        
    }
    
    func showRender2() {
        
        UIView.animate(withDuration: 0.2, animations: {
            
            self.animePic2.alpha = 1
            Timer.scheduledTimer(timeInterval: 0.4, target: self, selector: #selector(self.hideRender2), userInfo: nil, repeats: false)
            
        }, completion: nil)
        
    }
    
    @objc func hideRender2() {
        
        UIView.animate(withDuration: 0.2, animations: {
            
            self.animePic2.alpha = 0
            
        }, completion: nil)
        
    }
    
    func showRender3() {
        
        UIView.animate(withDuration: 0.2, animations: {
            
            self.animePic3.alpha = 1
            Timer.scheduledTimer(timeInterval: 0.4, target: self, selector: #selector(self.hideRender3), userInfo: nil, repeats: false)
            
        }, completion: nil)
        
    }
    
    @objc func hideRender3() {
        
        UIView.animate(withDuration: 0.2, animations: {
            
            self.animePic3.alpha = 0
            
        }, completion: nil)
        
    }
    
    func showRender4() {
        
        UIView.animate(withDuration: 0.2, animations: {
            
            self.animePic4.alpha = 1
            Timer.scheduledTimer(timeInterval: 0.4, target: self, selector: #selector(self.hideRender4), userInfo: nil, repeats: false)
            
        }, completion: nil)
        
    }
    
    @objc func hideRender4() {
        
        UIView.animate(withDuration: 0.2, animations: {
        
            self.animePic4.alpha = 0
            
        }, completion: nil)
        
    }
    
    func showRender5() {
        
        UIView.animate(withDuration: 0.2, animations: {
            
            self.animePic5.alpha = 1
            Timer.scheduledTimer(timeInterval: 0.4, target: self, selector: #selector(self.hideRender5), userInfo: nil, repeats: false)
            
        }, completion: nil)
        
    }
    
    @objc func hideRender5() {
        
        UIView.animate(withDuration: 0.2, animations: {
            
            self.animePic5.alpha = 0
            
        }, completion: nil)
        
    }
    
    func showMistakeImage() {
        
        UIView.animate(withDuration: 0.2, animations: {
            
          self.mistakeImage.alpha = 1
            Timer.scheduledTimer(timeInterval: 0.4, target: self, selector: #selector(self.hideMistakeImage), userInfo: nil, repeats: false)
            
        })
        
    }
    
    @objc func hideMistakeImage() {
        
        UIView.animate(withDuration: 0.2, animations: {
            
            self.mistakeImage.alpha = 0
            
        }, completion: nil)
        
    }
    
    func warning() {
        
        let alert = UIAlertController(title: "Notice:", message: "You Must Select Your Play-Time, Difficulty And Game-Music.", preferredStyle: .alert)
        
        let dismissButton = UIAlertAction(title: "Okay", style: .cancel, handler: {
            
            (alert: UIAlertAction!) -> Void in
            
        })
        
        alert.addAction(dismissButton)
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func credits(_ sender: Any) {
        
            let alert = UIAlertController(title: "Credits:", message: "Background Image: by kjpargeter \n Anime Render: \n Home Music: Tomoya Naka & Shintaro Aoki - Water Surface Arabesque \n Game Music: Really Slow Motion - Big Skies, Irotori - Sunset Day, Marcus Warner - Tokyo Rain \n Mental Help: @ItsiAli @KirbApple @DylanMcD8 @KurrtDev @Beppevoto @DaveWijk \n Idea: Udemy Course Project \n Lines of Code: 2601 \n Developer: @ShyMemoriees \n \n Last Words: It doesn't matter how you made things when they work in the end.. \n \n love continues as memories grow \n \n love, @ShyMemoriees", preferredStyle: .alert)
            
            let dismissButton = UIAlertAction(title: "love continues..", style: .cancel, handler: {
                
                (alert: UIAlertAction!) -> Void in
                
            })
            
            alert.addAction(dismissButton)
            
            self.present(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func backToMenu(_ sender: Any) {
        
        if (menuButton.titleLabel?.text == "Menu") {
            
            self.saveHighScore()
            self.saveCoins()
            self.gameEnded()
            
        } else if (menuButton.titleLabel?.text == "Back") {
            
            self.backgroundSettingsView.isHidden = true
            self.menuButton.setTitle("Menu", for: UIControl.State.normal)
            self.menuButton.isHidden = true
            
        }
        
    }
    
    func saveHighScore() {
        
        if (scoreInt > highscore) {
            
            highscore = scoreInt
            defaults.set(highscore, forKey: Keys.highscore)
            
        } else {
            
            defaults.set(highscore, forKey: Keys.highscore)
            
        }
        
    }
    
    func checkForScoreAtViewDidLoad() {
        
        if (highscore == 0) {
            
            highscore = defaults.integer(forKey: Keys.highscore)
            scoreLabel.text = String("Highscore: \(highscore)")
            
        }
        
    }
    
    @objc func changeScoreLabel() {
        
        if (inMainMenu) {
            
            scoreLabel.text = String("Highscore: \(highscore)")
            Timer.scheduledTimer(timeInterval: 4.0, target: self, selector: #selector(changeLabelToCoinsAmount), userInfo: nil, repeats: false)
            
        }
        
    }
    
    @objc func changeLabelToCoinsAmount() {
        
        scoreLabel.text = String("Coins: \(coins)")
        Timer.scheduledTimer(timeInterval: 4.0, target: self, selector: #selector(revertScoreLabel), userInfo: nil, repeats: false)
        
    }
    
    @objc func revertScoreLabel() {
        
        if (inMainMenu) {
            
            scoreLabel.text = "Score: \(scoreInt)"
            Timer.scheduledTimer(timeInterval: 4.0, target: self, selector: #selector(changeScoreLabel), userInfo: nil, repeats: false)
            
        }
        
    }
    
    @IBAction func changeUIColor(_ sender: Any) {
        
        if (UIColorUnlocked) {
            
            if (lightState == false) {
                
                self.lightUIColor()
                saveUIColorState()
                
            } else {
                
                self.darkUIColor()
                saveUIColorState()
                
            }
            
        } else if (!(UIColorUnlocked)) {
            
            whatToBuy = "Dark Mode"
            costs = 1700
            itemNumber = 11
            self.wantToBuy()
            
        }
        
    }
    
    func darkUIColor() {
            
            UIView.animate(withDuration: 0.5, animations: {
                
                self.gameSettingsView.backgroundColor = UIColor.white
                self.startGameButton.setTitleColor(UIColor.black, for: UIControl.State.normal)
                self.timeMenuLabel.textColor = UIColor.black
                self.scoreTimeSeg.tintColor = UIColor.black
                self.difficultyMenuLabel.textColor = UIColor.black
                self.difficultySeg.tintColor = UIColor.black
                self.shakeGestureMenuLabel.textColor = UIColor.black
                self.InGameMusicMenuLabel.textColor = UIColor.black
                self.musicSeg.tintColor = UIColor.black
                self.backgroundButton.setTitleColor(UIColor.black, for: UIControl.State.normal)
                self.UIColorButton.setTitleColor(UIColor.black, for: UIControl.State.normal)
                self.creditsButton.setTitleColor(UIColor.black, for: UIControl.State.normal)
                self.backgroundSettingsView.backgroundColor = UIColor.white
                self.changeBackgroundImageSeg.tintColor = UIColor.black
                self.backgroundBlurLabel.textColor = UIColor.black
                
            }, completion: nil)
            
            self.UIColorButton.setTitle("DarkUI", for: UIControl.State.normal)
        
        lightState = false
        saveUIColorState()
            
        }
    
    func lightUIColor() {
        
        UIView.animate(withDuration: 0.5, animations: {
            
            self.gameSettingsView.backgroundColor = UIColor.black
            self.startGameButton.setTitleColor(UIColor.white, for: UIControl.State.normal)
            self.timeMenuLabel.textColor = UIColor.white
            self.scoreTimeSeg.tintColor = UIColor.white
            self.difficultyMenuLabel.textColor = UIColor.white
            self.difficultySeg.tintColor = UIColor.white
            self.shakeGestureMenuLabel.textColor = UIColor.white
            self.InGameMusicMenuLabel.textColor = UIColor.white
            self.musicSeg.tintColor = UIColor.white
            self.backgroundButton.setTitleColor(UIColor.white, for: UIControl.State.normal)
            self.UIColorButton.setTitleColor(UIColor.white, for: UIControl.State.normal)
            self.creditsButton.setTitleColor(UIColor.white, for: UIControl.State.normal)
            self.backgroundSettingsView.backgroundColor = UIColor.black
            self.changeBackgroundImageSeg.tintColor = UIColor.white
            self.backgroundBlurLabel.textColor = UIColor.white
            
        }, completion: nil)
        
        self.UIColorButton.setTitle("LightUI", for: UIControl.State.normal)
        
        lightState = true
        saveUIColorState()
        
    }
    
    func saveUIColorState() {
        
        if (lightState) {
            
            lightState = true
            defaults.set(lightState, forKey: Keys.UIColorState)
            
        } else if (lightState == false) {
            
            lightState = false
            defaults.set(lightState, forKey: Keys.UIColorState)
            
        }
        
    }
    
    func setUIColorOnViewDidLoad() {
        
        lightState = defaults.bool(forKey: Keys.UIColorState)
        if (lightState) {
            
            lightUIColor()
            
        } else {
            
            darkUIColor()
            
        }
        
    }
    
    @IBAction func changeBGImage(_ sender: Any) {
        
            self.backgroundSettingsView.isHidden = false
            self.backgroundViewIsHidden = false
            
            self.menuButton.setTitle("Back", for: UIControl.State.normal)
            self.menuButton.isHidden = false
        
    }
    
    @IBAction func changeBackgroundImage(_ sender: Any) {
        
        if (changeBackgroundImageSeg.selectedSegmentIndex == 0) {
            
            self.backgroundImage.image = UIImage(named: "background")
            self.backgroundImagePreview.image = UIImage(named: "background")
            self.saveWallpaper()
            
        } else if (changeBackgroundImageSeg.selectedSegmentIndex == 1) {
            
            if (wallpaper1Unlocked) {
                
                self.backgroundImage.image = UIImage(named: "background2")
                self.backgroundImagePreview.image = UIImage(named: "background2")
                self.saveWallpaper()
                
            } else if (!(wallpaper1Unlocked)) {
                
                whatToBuy = "Wallpaper1"
                costs = 1200
                itemNumber = 12
                self.wantToBuy()
                self.changeBackgroundImageSeg.selectedSegmentIndex = 0
                self.backgroundImage.image = UIImage(named: "background")
                self.backgroundImagePreview.image = UIImage(named: "background")
                
            }
            
        } else if (changeBackgroundImageSeg.selectedSegmentIndex == 2) {
            
            if (wallpaper2Unlocked) {
                
                self.backgroundImage.image = UIImage(named: "background3")
                self.backgroundImagePreview.image = UIImage(named: "background3")
                self.saveWallpaper()
                
            } else if (!(wallpaper2Unlocked)) {
                
                whatToBuy = "Wallpaper2"
                costs = 1800
                itemNumber = 13
                self.wantToBuy()
                self.changeBackgroundImageSeg.selectedSegmentIndex = 0
                self.backgroundImage.image = UIImage(named: "background")
                self.backgroundImagePreview.image = UIImage(named: "background")
                
            }
            
        } else if (changeBackgroundImageSeg.selectedSegmentIndex == 3) {
            
            if (wallpaper3Unlocked) {
                
                self.backgroundImage.image = UIImage(named: "background4")
                self.backgroundImagePreview.image = UIImage(named: "background4")
                self.saveWallpaper()
                
            } else if (!(wallpaper3Unlocked)) {
                
                whatToBuy = "Wallpaper3"
                costs = 2400
                itemNumber = 14
                self.wantToBuy()
                self.changeBackgroundImageSeg.selectedSegmentIndex = 0
                self.backgroundImage.image = UIImage(named: "background")
                self.backgroundImagePreview.image = UIImage(named: "background")
                
            }
            
        }
        
    }
    
    @IBAction func enableBackgroundBlur(_ sender: Any) {
        
        if (wallpaperBlurUnlocked) {
            
            if (self.backgroundBlurEffect.alpha == 0) {
                
                self.backgroundBlurEffect.alpha = 1
                self.backgroundPreviewBlurEffect.alpha = 1
                self.blurEnabled = true
                self.saveUIBlurState()
                
            } else {
                
                self.backgroundBlurEffect.alpha = 0
                self.backgroundPreviewBlurEffect.alpha = 0
                self.blurEnabled = false
                self.saveUIBlurState()
                
            }
            
        } else if (!(wallpaperBlurUnlocked)) {
            
            whatToBuy = "Background Blur"
            costs = 7000
            itemNumber = 15
            self.wantToBuy()
            self.backgroundBlurEffect.alpha = 0
            self.backgroundPreviewBlurEffect.alpha = 0
            self.blurEnabled = false
            backgroundBlurToggle.isOn = false
            
        }
        
    }
    
    func saveWallpaper() {
        
        defaults.set(changeBackgroundImageSeg.selectedSegmentIndex, forKey: Keys.Wallpaper)
        
    }
    
    func setWallpaperOnViewDidLoad() {
        
        changeBackgroundImageSeg.selectedSegmentIndex = defaults.integer(forKey: Keys.Wallpaper)
        
        if (changeBackgroundImageSeg.selectedSegmentIndex == 0) {
            
            self.backgroundImage.image = UIImage(named: "background")
            self.backgroundImagePreview.image = UIImage(named: "background")
            self.saveWallpaper()
            
        } else if (changeBackgroundImageSeg.selectedSegmentIndex == 1) {
            
            self.backgroundImage.image = UIImage(named: "background2")
            self.backgroundImagePreview.image = UIImage(named: "background2")
            self.saveWallpaper()
            
        } else if (changeBackgroundImageSeg.selectedSegmentIndex == 2) {
            
            self.backgroundImage.image = UIImage(named: "background3")
            self.backgroundImagePreview.image = UIImage(named: "background3")
            self.saveWallpaper()
            
        } else if (changeBackgroundImageSeg.selectedSegmentIndex == 3) {
            
            self.backgroundImage.image = UIImage(named: "background4")
            self.backgroundImagePreview.image = UIImage(named: "background4")
            self.saveWallpaper()
            
        }
        
    }
    
    func saveUIBlurState() {
        
        defaults.set(blurEnabled, forKey: Keys.blurState)
        
    }
    
    func setBlurStateOnViewDidLoad() {
        
        blurEnabled = defaults.bool(forKey: Keys.blurState)
        
        if (blurEnabled) {
            
            backgroundBlurToggle.isOn = true
            backgroundBlurEffect.alpha = 1
            backgroundPreviewBlurEffect.alpha = 1
            
        } else {
            
            backgroundBlurToggle.isOn = false
            backgroundBlurEffect.alpha = 0
            backgroundPreviewBlurEffect.alpha = 0
            
        }
        
    }
    
    func wantToBuy() {
        
        self.gameSettingsView.isHidden = true
        self.backgroundSettingsView.isHidden = true
        self.menuButton.isHidden = true
        
        self.buyingView.isHidden = false
        buyingLabel.text = String("Buy \(whatToBuy) for \(costs) Coins?")
        
    }
    
    @IBAction func yesAction(_ sender: Any) {
        
        if (!(time1Unlocked) && itemNumber == 1) {
            
            if (coins >= costs) {
                
                coins -= costs
                self.saveCoins()
                time1Unlocked = true
                self.buyingView.isHidden = true
                self.gameSettingsView.isHidden = false
                self.buySuccessfulSound()
                
            } else {
                
                self.buyingLabel.text = "Not enough Coins :("
                
            }
            
        }
        
        if (!(time2Unlocked) && itemNumber == 2) {
            
            if (coins >= costs) {
                
                coins -= costs
                self.saveCoins()
                time2Unlocked = true
                self.buyingView.isHidden = true
                self.gameSettingsView.isHidden = false
                self.buySuccessfulSound()
                
            } else {
                
                self.buyingLabel.text = "Not enough Coins :("
                
            }
            
        }

        if (!(time3Unlocked) && itemNumber == 3) {
            
            if (coins >= costs) {
                
                coins -= costs
                self.saveCoins()
                time3Unlocked = true
                self.buyingView.isHidden = true
                self.gameSettingsView.isHidden = false
                self.buySuccessfulSound()
                
            } else {
                
                self.buyingLabel.text = "Not enough Coins :("
                
            }
            
        }
        
        if (!(time4Unlocked) && itemNumber == 4) {
            
            if (coins >= costs) {
                
                coins -= costs
                self.saveCoins()
                time4Unlocked = true
                self.buyingView.isHidden = true
                self.gameSettingsView.isHidden = false
                self.buySuccessfulSound()
                
            } else {
                
                self.buyingLabel.text = "Not enough Coins :("
                
            }
            
        }
        
        if (!(difficulty1Unlocked) && itemNumber == 5) {
            
            if (coins >= costs) {
                
                coins -= costs
                self.saveCoins()
                difficulty1Unlocked = true
                self.buyingView.isHidden = true
                self.gameSettingsView.isHidden = false
                self.buySuccessfulSound()
                
            } else {
                
                self.buyingLabel.text = "Not enough Coins :("
                
            }
            
        }
        
        if (!(difficulty2Unlocked) && itemNumber == 6) {
            
            if (coins >= costs) {
                
                coins -= costs
                self.saveCoins()
                difficulty2Unlocked = true
                self.buyingView.isHidden = true
                self.gameSettingsView.isHidden = false
                self.buySuccessfulSound()
                
            } else {
                
                self.buyingLabel.text = "Not enough Coins :("
                
            }
            
        }
        
        if (!(difficulty3Unlocked) && itemNumber == 7) {
            
            if (coins >= costs) {
                
                coins -= costs
                self.saveCoins()
                difficulty3Unlocked = true
                self.buyingView.isHidden = true
                self.gameSettingsView.isHidden = false
                self.buySuccessfulSound()
                
            } else {
                
                self.buyingLabel.text = "Not enough Coins :("
                
            }
            
        }
        
        if (!(shakeSwitchUnlocked) && itemNumber == 8) {
            
            if (coins >= costs) {
                
                coins -= costs
                self.saveCoins()
                shakeSwitchUnlocked = true
                self.buyingView.isHidden = true
                self.gameSettingsView.isHidden = false
                self.buySuccessfulSound()
                
            } else {
                
                self.buyingLabel.text = "Not enough Coins :("
                
            }
            
        }
        
        if (!(music1Unlocked) && itemNumber == 9) {
            
            if (coins >= costs) {
                
                coins -= costs
                self.saveCoins()
                music1Unlocked = true
                self.buyingView.isHidden = true
                self.gameSettingsView.isHidden = false
                self.buySuccessfulSound()
                
            } else {
                
                self.buyingLabel.text = "Not enough Coins :("
                
            }
            
        }
        
        if (!(music2Unlocked) && itemNumber == 10) {
            
            if (coins >= costs) {
                
                coins -= costs
                self.saveCoins()
                music2Unlocked = true
                self.buyingView.isHidden = true
                self.gameSettingsView.isHidden = false
                self.buySuccessfulSound()
                
            } else {
                
                self.buyingLabel.text = "Not enough Coins :("
                
            }
            
        }
        
        if (!(UIColorUnlocked) && itemNumber == 11) {
            
            if (coins >= costs) {
                
                coins -= costs
                self.saveCoins()
                UIColorUnlocked = true
                self.buyingView.isHidden = true
                self.gameSettingsView.isHidden = false
                self.buySuccessfulSound()
                
            } else {
                
                self.buyingLabel.text = "Not enough Coins :("
                
            }
            
        }
        
        if (!(wallpaper1Unlocked) && itemNumber == 12) {
            
            if (coins >= costs) {
                
                coins -= costs
                self.saveCoins()
                wallpaper1Unlocked = true
                self.buyingView.isHidden = true
                self.gameSettingsView.isHidden = false
                self.buySuccessfulSound()
                
            } else {
                
                self.buyingLabel.text = "Not enough Coins :("
                
            }
            
        }
        
        if (!(wallpaper2Unlocked) && itemNumber == 13) {
            
            if (coins >= costs) {
                
                coins -= costs
                self.saveCoins()
                wallpaper2Unlocked = true
                self.buyingView.isHidden = true
                self.gameSettingsView.isHidden = false
                self.buySuccessfulSound()
                
            } else {
                
                self.buyingLabel.text = "Not enough Coins :("
                
            }
            
        }
        
        if (!(wallpaper3Unlocked) && itemNumber == 14) {
            
            if (coins >= costs) {
                
                coins -= costs
                self.saveCoins()
                wallpaper3Unlocked = true
                self.buyingView.isHidden = true
                self.gameSettingsView.isHidden = false
                self.buySuccessfulSound()
                
            } else {
                
                self.buyingLabel.text = "Not enough Coins :("
                
            }
            
        }
        
        if (!(wallpaperBlurUnlocked) && itemNumber == 15) {
            
            if (coins >= costs) {
                
                coins -= costs
                self.saveCoins()
                wallpaperBlurUnlocked = true
                self.buyingView.isHidden = true
                self.gameSettingsView.isHidden = false
                self.buySuccessfulSound()
                
            } else {
                
                self.buyingLabel.text = "Not enough Coins :("
                
            }
            
        }
        
        self.saveBoughtItems()
        
    }
    
    @IBAction func noAction(_ sender: Any) {
            
        self.buyingView.isHidden = true
        self.gameSettingsView.isHidden = false
        whatToBuy = ""
        costs = 0
        self.buyUnsuccessfulSound()
        
    }
    
    func saveBoughtItems() {
        
        defaults.set(time1Unlocked, forKey: Keys.time1Unlock)
        defaults.set(time2Unlocked, forKey: Keys.time2Unlock)
        defaults.set(time3Unlocked, forKey: Keys.time3Unlock)
        defaults.set(time4Unlocked, forKey: Keys.time4Unlock)
        defaults.set(difficulty1Unlocked, forKey: Keys.difficulty1Unlock)
        defaults.set(difficulty2Unlocked, forKey: Keys.difficulty2Unlock)
        defaults.set(difficulty3Unlocked, forKey: Keys.difficulty3Unlock)
        defaults.set(shakeSwitchUnlocked, forKey: Keys.shakeSwitchUnlock)
        defaults.set(music1Unlocked, forKey: Keys.music1Unlock)
        defaults.set(music2Unlocked, forKey: Keys.music2Unlock)
        defaults.set(UIColorUnlocked, forKey: Keys.UIColorUnlock)
        defaults.set(wallpaper1Unlocked, forKey: Keys.wallpaper1Unlock)
        defaults.set(wallpaper2Unlocked, forKey: Keys.wallpaper2Unlock)
        defaults.set(wallpaper3Unlocked, forKey: Keys.wallpaper3Unlock)
        defaults.set(wallpaperBlurUnlocked, forKey: Keys.wallpaperBlurUnlock)
        
    }
    
    func setBoughtItemsOnViewDidLoad() {
        
        time1Unlocked = defaults.bool(forKey: Keys.time1Unlock)
        time2Unlocked = defaults.bool(forKey: Keys.time2Unlock)
        time3Unlocked = defaults.bool(forKey: Keys.time3Unlock)
        time4Unlocked = defaults.bool(forKey: Keys.time4Unlock)
        difficulty1Unlocked = defaults.bool(forKey: Keys.difficulty1Unlock)
        difficulty2Unlocked = defaults.bool(forKey: Keys.difficulty2Unlock)
        difficulty3Unlocked = defaults.bool(forKey: Keys.difficulty3Unlock)
        shakeSwitchUnlocked = defaults.bool(forKey: Keys.shakeSwitchUnlock)
        music1Unlocked = defaults.bool(forKey: Keys.music1Unlock)
        music2Unlocked = defaults.bool(forKey: Keys.music2Unlock)
        UIColorUnlocked = defaults.bool(forKey: Keys.UIColorUnlock)
        wallpaper1Unlocked = defaults.bool(forKey: Keys.wallpaper1Unlock)
        wallpaper2Unlocked = defaults.bool(forKey: Keys.wallpaper2Unlock)
        wallpaper3Unlocked = defaults.bool(forKey: Keys.wallpaper3Unlock)
        wallpaperBlurUnlocked = defaults.bool(forKey: Keys.wallpaperBlurUnlock)
        
    }
    
}

