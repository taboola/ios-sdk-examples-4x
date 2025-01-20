//
//  ClassicMainScrollViewController.swift
//  TaboolaSDKExampleSwift
//
//  Created by Sasa Jovanovic on 14.1.25..
//

import UIKit

class ClassicMainScrollViewController: UIViewController {
    
    var isForMetaAds:Bool = false

    //     MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //     MARK: - Actions
    @IBAction func didTapFrames(_ sender: UIButton) {
        if isForMetaAds { // Go to Taboola with Meta integration screen
            let framesMetaAdController = ClassicFrameMetaAdController()
            self.navigationController?.pushViewController(framesMetaAdController, animated: true)
        } else { // Go to Taboola only screen
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "ClassicFrameScrollViewController") as? ClassicFrameScrollViewController
            navigationController?.pushViewController(viewController!, animated: true)
        }
    }
    
    @IBAction func didTapConstraints(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if isForMetaAds { // Go to Taboola with Meta integration screen
            let viewController = storyboard.instantiateViewController(withIdentifier: "ClassicConstraintsMetaAdViewController") as? ClassicConstraintsMetaAdViewController
            navigationController?.pushViewController(viewController!, animated: true)
        } else { // Go to Taboola only screen
            let viewController = storyboard.instantiateViewController(withIdentifier: "ClassicConstraintsScrollViewController") as? ClassicConstraintsScrollViewController
            navigationController?.pushViewController(viewController!, animated: true)
            
        }
    }
    
}

