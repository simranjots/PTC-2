
import Foundation
import UIKit

class MainNavigationController: UINavigationController {
    
    var userObject : userModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        let currentUser = CurrentUser()
        userObject = currentUser.checkLoggedIn()
        if (userObject != nil) {
            perform( #selector(MainNavigationController.showHome), with: nil, afterDelay: 0.01 )
        } else {
            perform(#selector(MainNavigationController.showLogin), with: nil, afterDelay: 0.01)
        }

    }
    
    @objc func showHome() {
        let homeController = UINavigationController()
        present(homeController, animated: true, completion: {
        })
    }
    
    @objc func showLogin() {
        let login = UINavigationController()
        present(login, animated: true, completion: {
            
        })
    }
}
