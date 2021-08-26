//
//  ViewController.swift
//  MemoryBlocks
//
//  Created by Diamond Mohanty on 25/08/21.
//

import UIKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let theme = (UIApplication.shared.delegate as? AppDelegate)?.theme ?? .normal
        
        switch theme {
        case .halloween:
            self.view.backgroundColor = .black
        case .normal:
            self.view.backgroundColor = .white
        }
        
        let aCardView = CardView(frame: CGRect(x: 0, y: 0, width: 100, height: 100), faceImage: UIImage(systemName: "doc.plaintext"), andColor: theme.getColor())
        
        self.view.addSubview(aCardView)
    }
    
    

}

