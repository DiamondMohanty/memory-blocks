//
//  WelcomeViewController.swift
//  MemoryBlocks
//
//  Created by Diamond Mohanty on 30/08/21.
//

import UIKit
import MessageUI

class WelcomeViewController: UIViewController {

    @IBAction func shareGame(_ sender: UIButton) {
        let message = "View the source code of this game."
        if let link = NSURL(string: "https://github.com/DiamondMohanty/memory-blocks/tree/main") {
            let objectsToShare = [message, link] as [Any]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            self.present(activityVC, animated: true)
        }
    }
    
}
