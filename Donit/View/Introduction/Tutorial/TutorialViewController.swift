//
//  TutorialViewController.swift
//  Donit
//
//  Created by Paulo José on 18/12/18.
//  Copyright © 2018 Paulo José. All rights reserved.
//

import UIKit

class TutorialViewController: UIViewController {
    
    var currentPage = 1
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var tutorialCard1: TutorialCard!
    @IBOutlet weak var tutorialCard2: TutorialCard!
    @IBOutlet weak var tutorialCard3: TutorialCard!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nextButton.addRoundedBorder(in: .gradient, colors: [UIColor.lightishBlue, UIColor.greenyBlue], radius: 0, shadowOppacity: 0.5, shadowRadius: 10)
    
        scrollView.contentSize = CGSize(width: scrollView.frame.width * 3, height: scrollView.frame.height)
        scrollView.contentOffset = CGPoint.zero
        
        tutorialCard1.imageView.image = UIImage(named: "Done")
        tutorialCard1.commentLabel.text = "You’ve been doing so much already"
        
        tutorialCard2.imageView.image = UIImage(named: "Todo")
        tutorialCard2.commentLabel.text = "Life is not a endless to-do list"
        
        tutorialCard3.imageView.image = UIImage(named: "Accomplishment")
        tutorialCard3.commentLabel.text = "Look how much you’ve acomplished with Donit"
        
        self.navigationController?.navigationBar.setTransparentBackground()
        
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func nextDidPress(_ sender: Any) {
        
        switch currentPage {
        case 1:
                UIView.animate(withDuration: 0.3) {
                    self.scrollView.contentOffset = CGPoint(x: self.view.frame.width, y: 0)
                }
                currentPage = currentPage + 1
        case 2:
                UIView.animate(withDuration: 0.3) {
                    self.scrollView.contentOffset = CGPoint(x: 375 * self.currentPage, y: 0)
                }
                currentPage = currentPage + 1
                nextButton.titleLabel?.text = "Let's start!"
            
        case 3:
            let navigationController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() as? UINavigationController
            present(navigationController!, animated: true, completion: nil)
        default:
            print("Nao sei")
        }
        
    }
}
