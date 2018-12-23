//
//  TutorialViewController.swift
//  Donit
//
//  Created by Paulo José on 18/12/18.
//  Copyright © 2018 Paulo José. All rights reserved.
//

import UIKit
import CoreData

class TutorialViewController: UIViewController {
    var user: User!
    var managedContext: NSManagedObjectContext!
    var currentPage = 1
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var welcomeLabel: UILabel!
    
    @IBOutlet weak var tutorialCard1: TutorialCard!
    @IBOutlet weak var tutorialCard2: TutorialCard!
    @IBOutlet weak var tutorialCard3: TutorialCard!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if managedContext == nil {
            guard let appDeledate = UIApplication.shared.delegate as? AppDelegate else {
                return
            }
            managedContext = appDeledate.persistentContainer.viewContext
        }
        
        do {
            let users : [User] = try managedContext.fetch(User.fetchRequest())
            user = users[0]
            let username = user.name ?? ""
            welcomeLabel.text = "Welcome to Donit, \(username)"
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
        scrollView.contentSize = CGSize(width: scrollView.frame.width * 3, height: scrollView.frame.height)
        scrollView.contentOffset = CGPoint.zero
        
        tutorialCard1.imageView.image = UIImage(named: "Done")
        tutorialCard1.commentLabel.text = "You’ve been doing so much already"
        
        tutorialCard2.imageView.image = UIImage(named: "Todo")
        tutorialCard2.commentLabel.text = "Life is not a endless to-do list"
        
        tutorialCard3.imageView.image = UIImage(named: "Accomplishment")
        tutorialCard3.commentLabel.text = "Look how much you’ve acomplished with Donit"
        
        self.navigationController?.navigationBar.setTransparentBackground()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        nextButton.addRoundedBorder(in: .gradient, colors: [UIColor.lightishBlue, UIColor.greenyBlue], radius: 0, shadowOppacity: 0.5, shadowRadius: 10)
    }
    
    @IBAction func nextDidPress(_ sender: Any) {
        
        let viewWidth = self.view.frame.width
        
        if scrollView.contentOffset.x >= 0 && scrollView.contentOffset.x < viewWidth {
            currentPage = 1
        } else if scrollView.contentOffset.x >= viewWidth && scrollView.contentOffset.x < viewWidth * 2 {
            currentPage = 2
        } else {
            currentPage = 3
        }
        
        switch currentPage {
        case 1:
                UIView.animate(withDuration: 0.3) {
                    self.scrollView.contentOffset = CGPoint(x: viewWidth, y: 0)
                }
                currentPage = currentPage + 1
        case 2:
                UIView.animate(withDuration: 0.3) {
                    self.scrollView.contentOffset = CGPoint(x: viewWidth * CGFloat(self.currentPage), y: 0)
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
