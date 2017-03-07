//
//  ViewController.swift
//  deepdiveAnimations
//
//  Created by Qiao Lin on 3/7/17.
//  Copyright © 2017 Qiao Lin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var alphaView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        animateImage()
//        animateRedCircles()
        dissolveViewIntoAnother()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func animateImage() {
        let mars = UIImage(named: "mars")!
        let r = UIGraphicsImageRenderer(size: mars.size)
        let empty = r.image {_ in}
        let arr = [mars, empty, mars, empty, mars]
        let iv = UIImageView(image: empty)
        iv.frame.origin = CGPoint(x: 100, y: 100)
        self.view.addSubview(iv)
        iv.animationImages = arr
        iv.animationDuration = 2
        iv.animationRepeatCount = 1
        iv.startAnimating()
    }
    
    @IBOutlet weak var placeholderButton: UIButton!
    private func animateRedCircles() {
        // a sequence of red circles of different sizes animates in a UIButton
        var arr = [UIImage]()
        let w : CGFloat = 18
        for i in 0 ..< 6 {
            let r = UIGraphicsImageRenderer(size: CGSize(width: w, height: w))
            arr += [r.image { ctx in
                let context = ctx.cgContext
                context.setFillColor(UIColor.red.cgColor)
                let ii = CGFloat(i)
                context.addEllipse(in: CGRect(x: 0+ii, y: 0+ii, width: w-ii*2, height: w-ii*2))
                context.fillPath()
            }]
        }
        
        let img = UIImage.animatedImage(with: arr, duration: 0.5)
        placeholderButton.setImage(img, for: .normal)
        

    }
    
    private func basicAnimations(){
        
        // style 1 - initialize within one block
        let animation = UIViewPropertyAnimator(duration: 10, curve: .linear) {
            self.alphaView.backgroundColor = .green
            self.alphaView.center.y += 100
        }
        
        animation.startAnimation()
        
        
        // style 2 - initialize then append
        let anim = UIViewPropertyAnimator(duration: 1, curve: .linear)
        
        anim.addAnimations {
            self.alphaView.backgroundColor = .red
        }
        anim.addAnimations {
            self.alphaView.center.y += 100
        }
        
        anim.startAnimation()
    }
    
    @IBOutlet weak var firstView: UIView!
    private func dissolveViewIntoAnother() {
        let secondView = UIView()
        secondView.backgroundColor = .black
        secondView.alpha = 0
        secondView.frame = self.firstView.frame
        self.firstView.superview!.addSubview(secondView)
        let anim = UIViewPropertyAnimator(duration: 10, curve: .linear) {
            self.firstView.alpha = 0
            secondView.alpha = 1
            
            UIView.performWithoutAnimation {
                self.firstView.center.y += 100
            }
        }
        
        anim.addCompletion { _ in
            self.firstView.removeFromSuperview()
        }
//        anim.startAnimation()
        
        // try with options
//        let opts: UIViewAnimationOptions = .autoreverse
//        let xorigin = self.firstView.center.x
//        UIView.animate(withDuration: 5, delay: 0, options: opts, animations: {
//            UIView.setAnimationRepeatCount(3)
//            self.firstView.center.x += 100
//        }, completion: { _ in
//            // make sure it is back to the original position
//            self.firstView.center.x = xorigin
//        })
        
        // two animationas directly oppse one another, with a smooth transition 
        let yorigin = self.firstView.center.y
        let animation2 = UIViewPropertyAnimator(duration:2, curve: .easeInOut) {
            self.firstView.center.y += 100
        }
        
        animation2.addAnimations({
            self.firstView.center.y = yorigin
        }, delayFactor: 0.5)
        
        animation2.startAnimation()
    }
    
    // timeing curves 
    private func timeCurvesAnimate() {
        let anim = UIViewPropertyAnimator(duration: 1, timingParameters: UICubicTimingParameters( controlPoint1: CGPoint(x: 0.9, y:0.1), controlPoint2: CGPoint(x:0.7, y:0.9)))
        
        
    }
}

