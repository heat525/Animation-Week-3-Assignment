//
//  MailboxViewController.swift
//  Animation Week 3 Assignment
//
//  Created by Prime, Heather(AWF) on 9/30/15.
//  Copyright © 2015 Prime, Heather. All rights reserved.
//

import UIKit

class MailboxViewController: UIViewController {
    
    var messageOriginalCenter: CGPoint!
    var messageOrigin: CGPoint!
    var messageRight: CGPoint!
    var messageLeft: CGPoint!
    var firstBackground: CGPoint!
    
    @IBOutlet weak var dismissListButton: UIButton!
    @IBOutlet weak var rescheduleView: UIImageView!
    @IBOutlet weak var feedView: UIImageView!
    @IBOutlet weak var listView: UIImageView!
    @IBOutlet weak var listIconImage: UIImageView!
    @IBOutlet weak var deleteIconImage: UIImageView!
    @IBOutlet weak var archiveIconImage: UIImageView!
    @IBOutlet weak var laterIconImage: UIImageView!
    @IBOutlet weak var messageView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var backgroundView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        messageRight = CGPoint(x: messageView.center.x + 320, y: messageView.center.y)
        messageLeft = CGPoint(x: messageView.center.x - 320, y: messageView.center.y)
        
        firstBackground = CGPoint(x: messageView.center.x + 60, y: messageView.center.y)
        
        
        scrollView.contentSize = CGSize(width: 320, height: 1432)
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func onTapGesture(sender: UITapGestureRecognizer) {
        NSLog("tapped")
    }
    @IBAction func onPanGesture(sender: UIPanGestureRecognizer) {
        
        let point = sender.locationInView(view)
        let velocity = sender.velocityInView(view)
        let translation = sender.translationInView(view)
        let position = velocity.x > 0 ? messageRight: messageLeft
        
        
        
        //BEGAN
        if sender.state == UIGestureRecognizerState.Began {
            
            messageOriginalCenter = messageView.center
            messageOrigin = messageView.frame.origin
            
            self.backgroundView.backgroundColor = UIColor(red: 226/255, green: 226/255, blue: 226/255, alpha: 1.0)
            
            print("Gesture began at: \(point)")
            
            //CHANGED
        } else if sender.state == UIGestureRecognizerState.Changed {
            
            messageView.center = CGPoint(x:messageOriginalCenter.x + translation.x, y:messageOriginalCenter.y)
            
            
            //MESSAGE IS MOVING RIGHT
            
            
            if messageView.frame.origin.x > 0 && messageView.frame.origin.x < 60 {
                
                self.backgroundView.backgroundColor = UIColor(red: 226/255, green: 226/255, blue: 226/255, alpha: 1.0)
                
                archiveIconImage.frame.origin.x = messageView.frame.origin.x - 30
                
            }
            
            if messageView.frame.origin.x > 60 && messageView.frame.origin.x < 200 {
                self.backgroundView.backgroundColor = UIColor(red: 116/255, green: 214/255, blue: 104/255, alpha: 1.0)
                archiveIconImage.alpha = 1
                
                archiveIconImage.frame.origin.x = messageView.frame.origin.x - 30
            }
            
            if messageView.frame.origin.x > 200 {
                self.backgroundView.backgroundColor = UIColor(red: 233/255, green: 85/255, blue: 59/255, alpha: 1.0)
                archiveIconImage.alpha = 0
                deleteIconImage.alpha = 1
                
                deleteIconImage.frame.origin.x = messageView.frame.origin.x - 30

            }
            
            
            
            //MESSAGE IS MOVING LEFT
            
            
            if messageView.frame.origin.x < 0 && messageView.frame.origin.x > -60{
                 self.backgroundView.backgroundColor = UIColor(red: 226/255, green: 226/255, blue: 226/255, alpha: 1.0)
                laterIconImage.alpha = 1
                listIconImage.alpha = 0
            }
            
            if messageView.frame.origin.x < -60 && messageView.frame.origin.x > -200 {
                
                self.backgroundView.backgroundColor = UIColor(red: 249/255, green: 210/255, blue: 70.0/255, alpha: 1.0)

                laterIconImage.frame.origin.x = messageView.frame.origin.x + 320 + 20
                
                laterIconImage.alpha = 1
                listIconImage.alpha = 0
                
            }
            
            if messageView.frame.origin.x < -200 {
                
                self.backgroundView.backgroundColor = UIColor(red: 215/255, green: 166/255, blue: 120/255, alpha: 1.0)
                
                listIconImage.frame.origin.x = messageView.frame.origin.x + 320 + 20
                
                //list icon appear
                listIconImage.alpha = 1
                //later icon disappear
                laterIconImage.alpha = 0
                
            }
            
            
            //ENDED
        } else if sender.state == UIGestureRecognizerState.Ended {
            
            
            
            //ANIMATIONS GESTURE
            
            //yellow to dismiss
            if messageView.center.x < 260 {

                UIView.animateWithDuration(0.3, animations: { () -> Void in
                    self.messageView.frame.origin.x = self.messageView.frame.origin.x - 320
                    self.listView.alpha = 1
            
                })
            }
            
            if messageView.frame.origin.x > 260 && messageView.frame.origin.x < 320 {
                
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                    self.messageView.frame.origin = CGPoint(x:320,y:self.messageView.frame.origin.y)
                    self.listView.alpha = 0
                    })
                }
            
            if messageView.frame.origin.x > 60 && messageView.frame.origin.x < 100 {
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                    self.messageView.frame.origin.x = self.messageView.frame.origin.x - 320
                    self.rescheduleView.alpha = 1
                    self.listView.alpha = 0

                    })
            }
            
            if messageView.frame.origin.x > 60 {
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                    self.messageView.frame.origin.x = self.messageView.frame.origin.x + 320
                    self.listView.alpha = 0
                    self.feedView.center.y = self.feedView.center.y - 90
                    self.backgroundView.alpha = 0
                })
                
            }

            
                //MY TACTIC
                /*
                if velocity.x < 0 && messageView.frame.origin.x <= -60 {
                
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                self.messageView.center = CGPoint(x: self.messageView.center.x - 360, y: self.messageView.center.y)
                }, completion: nil)
                }
                */
                
            }
            
        }
    @IBAction func onButtonPress(sender: AnyObject) {
        listView.alpha = 0

        }


    }
    
        /*
        // MARK: - Navigation
        
        // In a storyboard-based application, you will often want to do a little preparation before navigation
        override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        }
        */
        
        
