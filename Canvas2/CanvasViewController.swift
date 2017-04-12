//
//  CanvasViewController.swift
//  Canvas2
//
//  Created by Richard Du on 4/12/17.
//  Copyright © 2017 Richard. All rights reserved.
//

import UIKit

class CanvasViewController: UIViewController {

    @IBOutlet weak var trayView: UIView!
    
    var trayDownOffset: CGFloat!
    var trayUp: CGPoint!
    var trayDown: CGPoint!
    var trayOriginalCenter: CGPoint!
    var newlyCreatedFace: UIImageView!
    var newlyCreatedFaceOriginalCenter: CGPoint!
    
    @IBOutlet weak var arrowView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        trayDownOffset = 144
        trayUp = trayView.center
        trayDown = CGPoint(x: trayView.center.x ,y: trayView.center.y + trayDownOffset)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func didPanTray(_ sender: AnyObject) {
        let translation = sender.translation(in: view)
        
        if sender.state == UIGestureRecognizerState.began {
            trayOriginalCenter = trayView.center
        } else if sender.state == UIGestureRecognizerState.changed {
            trayView.center = CGPoint(x: trayOriginalCenter.x, y: trayOriginalCenter.y + translation.y)
        } else if sender.state == UIGestureRecognizerState.ended {
            let velocity = sender.velocity(in: view)
            
            
            if velocity.y > 0 { //moving down
                UIView.animate(withDuration: 0.5, animations: {
                    self.arrowView.transform = self.arrowView.transform.rotated(by: CGFloat(180 * M_PI / 180))
                    self.trayView.center = self.trayDown
                })
            } else { //moving up
                UIView.animate(withDuration: 0.5, animations: {
                    self.arrowView.transform = self.arrowView.transform.rotated(by: CGFloat(180 * M_PI / 180))
                    self.trayView.center = self.trayUp
                })
            }
        }
        
    }
    @IBAction func didPanFace(_ sender: AnyObject) {
        let translation = sender.translation(in: view)
        
        if sender.state == UIGestureRecognizerState.began {
            let imageView = sender.view! as! UIImageView
            newlyCreatedFace = UIImageView(image: imageView.image)
            view.addSubview(newlyCreatedFace)
            newlyCreatedFace.center = imageView.center
            newlyCreatedFace.center.y += trayView.frame.origin.y
            newlyCreatedFaceOriginalCenter = newlyCreatedFace.center
            
            let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(didPan(sender:)))
            newlyCreatedFace.isUserInteractionEnabled = true
            newlyCreatedFace.addGestureRecognizer(panGestureRecognizer)
            
        } else if sender.state == UIGestureRecognizerState.changed {
            newlyCreatedFace.center = CGPoint(x: newlyCreatedFaceOriginalCenter.x + translation.x, y: newlyCreatedFaceOriginalCenter.y + translation.y)
        } else if sender.state == UIGestureRecognizerState.ended {
            
        }
    }
    
    func didPan(sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        
        if sender.state == UIGestureRecognizerState.began {
            newlyCreatedFace = sender.view! as! UIImageView
            newlyCreatedFaceOriginalCenter = newlyCreatedFace.center
        } else if sender.state == UIGestureRecognizerState.changed {
            newlyCreatedFace.center = CGPoint(x: newlyCreatedFaceOriginalCenter.x + translation.x, y: newlyCreatedFaceOriginalCenter.y + translation.y)
        } else if sender.state == UIGestureRecognizerState.ended {
            
        }

    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
