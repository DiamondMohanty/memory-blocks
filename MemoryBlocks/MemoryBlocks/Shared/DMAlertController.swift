//
//  DMAlertController.swift
//  MemoryBlocks
//
//  Created by Diamond Mohanty on 30/08/21.
//

import UIKit

extension UIViewController {
    
    func showAlert(title: String?, message: String?, successButtonTitle: String?, cancelButtonTitle: String?, completionHandler: ((UIAlertAction) -> Void)?) {
        
        // Dismiss first any other alerts on the screen
        
        self.dismiss(animated: true) { [unowned self] in
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            if successButtonTitle != nil {
                let successAction = UIAlertAction(title: successButtonTitle, style: .default, handler: completionHandler)
                alert.addAction(successAction)
            }
            
            if cancelButtonTitle != nil {
                let cancelAction = UIAlertAction(title: cancelButtonTitle, style: .cancel, handler: completionHandler)
                alert.addAction(cancelAction)
            }
            
            self.present(alert, animated: true, completion: nil)
        }
        
        
    }
    
    
    
}
