//
//  TutorialViewController.swift
//  Donit
//
//  Created by Paulo José on 18/12/18.
//  Copyright © 2018 Paulo José. All rights reserved.
//

import UIKit

class TutorialViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nextButton.addRoundedBorder(in: .gradient, colors: [UIColor.lightishBlue, UIColor.greenyBlue], radius: 0, shadowOppacity: 0.5, shadowRadius: 10)
        self.navigationController?.navigationBar.setTransparentBackground()
        
        scrollView.contentSize = CGSize(width: scrollView.frame.width * 3, height: scrollView.frame.height)
        scrollView.contentOffset = CGPoint.zero
        
//        tutorialCard1.imageView.image = UIImage(named: "Done")
//        tutorialCard2.imageView.image = UIImage(named: "Todo")
//        tutorialCard3.imageView.image = UIImage(named: "Accomplishment")

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

}
