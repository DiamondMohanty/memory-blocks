//
//  InfoViewController.swift
//  MemoryBlocks
//
//  Created by Diamond Mohanty on 31/08/21.
//

import UIKit

class InfoViewController: UIViewController {

    @IBOutlet weak var infoScrollView: UIScrollView!
    
    private var appNameImageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect.zero)
        imageView.image = UIImage(named: "app-name")
        imageView.contentMode = .scaleAspectFit
        return imageView
    } ()
    
    private var tutorialImageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect.zero)
        imageView.image = UIImage(named: "game-screenshot")
        imageView.contentMode = .scaleAspectFit
        return imageView
    } ()
    
    private var gameInfoTextView: UILabel = {
        let textView = UILabel(frame: CGRect.zero)
        textView.textColor = UIColor(red: 22/255, green: 156/255, blue: 173/255, alpha: 1.0)
        textView.numberOfLines = 10
        textView.lineBreakMode = .byWordWrapping
        textView.textAlignment = .justified
        return textView
    } ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gameInfoTextView.text = "1. Tap on any two blocks consecutively.\n2.Blocks are removed if they have same face.\n3.Blocks are flipped if the faces are different. \n4.You goal is to remove all the blocks. The lower the time taken and number of flips used the higher the score.\nGood Luck !!!"

        self.infoScrollView.addSubview(appNameImageView)
        self.infoScrollView.addSubview(gameInfoTextView)
        self.infoScrollView.addSubview(tutorialImageView)
    }
    
    
    override func viewDidLayoutSubviews() {
        
        appNameImageView.translatesAutoresizingMaskIntoConstraints = false
        appNameImageView.topAnchor.constraint(equalTo: self.infoScrollView.topAnchor, constant: 12).isActive = true
        appNameImageView.centerXAnchor.constraint(equalTo: self.infoScrollView.centerXAnchor).isActive = true
        appNameImageView.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
        
        gameInfoTextView.translatesAutoresizingMaskIntoConstraints = false
        gameInfoTextView.topAnchor.constraint(equalTo: self.appNameImageView.bottomAnchor, constant: 12).isActive = true
        gameInfoTextView.widthAnchor.constraint(equalTo: self.infoScrollView.superview!.widthAnchor, constant: -50).isActive = true
        gameInfoTextView.heightAnchor.constraint(equalToConstant: 200.0).isActive = true
        
        tutorialImageView.translatesAutoresizingMaskIntoConstraints = false
        tutorialImageView.topAnchor.constraint(equalTo: self.gameInfoTextView.bottomAnchor, constant: 12).isActive = true
        tutorialImageView.centerXAnchor.constraint(equalTo: self.infoScrollView.superview!.centerXAnchor).isActive = true
        tutorialImageView.heightAnchor.constraint(equalToConstant: 400.0).isActive = true
        
    }
    
    

    

}
