//
//  LoginViewController.swift
//  RIBtheory
//
//  Created by Nikita Kazantsev on 13.04.2021.
//

import RIBs
import RxSwift
import UIKit

protocol LoginPresentableListener: class {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
    
    //We just need to know what actions we want to perform on this ViewController. We are going to add two methods to LoginPresentableListener:
    func didTapLogin(username: String, password: String)
    func didTapCreateAccount()
}


// Class LoginViewController implements LoginPresentable protocol, that we configured before (so the interactor can communicate to viewController). It means, LoginViewController has to implement showActivityIndicator method
//
// The next protocol the viewController implements is LoginViewControllable (so the router can modify the view hierarchy). To conform, LoginViewController has to implement present method:
final class LoginViewController: UIViewController, LoginPresentable, LoginViewControllable {
    
    
    
    weak var listener: LoginPresentableListener?
    
    // MARK: - LoginPresentable
    
    func showActivityIndicator(_ isLoading: Bool) {
    }
    
    func showErrorAlert() {
        
    }
    
    // MARK: - LoginViewControllable
    
    func present(_ viewController: ViewControllable) {
        present(viewController.uiviewController, completion: nil)
    }
}
