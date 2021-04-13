//
//  LoginInteractor.swift
//  RIBtheory
//
//  Created by Nikita Kazantsev on 13.04.2021.
//

import RIBs
import RxSwift
// LoginRouting is the protocol we use to navigate from Login RIB to subsequent RIBs. Let’s say, we want to be able to navigate to CreateAccount screen:
protocol LoginRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
    func routeToCreateAccount()
}


// LoginPresentable is used to update the Login view in response to business logic, performed within the interactor. If you open LoginViewController, you will notice, that it implements this protocol. LoginPresentable also owns a LoginPresentableListener . This is a way that LoginViewController will communicate with the interactor and invoke business logic. In other words, here is how Interactor and ViewController communicate with each other
protocol LoginPresentable: Presentable {
    var listener: LoginPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
    
    // As we discussed above, we want our view controller to show an activity indicator when the web-task is in progress. To implement this, we add a new method showActivityIndicator to LoginPresentable:
    func showActivityIndicator(_ isLoading: Bool)
    func showErrorAlert()
}

// Finally, we have a LoginListener . Remember this line of code in LoginBuilder?
//
// interactor.listener = listener
//
// This is a listener that a Root RIB will implement. This is a way for a child RIB to communicate back to its parent. We need to notify the Root RIB when login is finished, so login flow can be dismissed:
protocol LoginListener: class {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
    func dismissLoginFlow()
}


// Now we look at LoginInteractor class. It has two weak variables, router, and listener. This is how the interactor is connected to its router and parent interactor respectively. You’ve seen about, that interactor also owns a presenter.

// Here is how we use interactor to control the app flow:
// we invoke presenter methods to update Login UI (we have showActivityIndicator in our example)
// we invoke router methods to navigate to the child RIBs (we have routeToCreateAccount in our example)
// we invoke listener methods to talk to parent RIB (we have dismissLoginFlow in our example)
final class LoginInteractor: PresentableInteractor<LoginPresentable>, LoginInteractable, LoginPresentableListener {
    
    weak var router: LoginRouting?
    weak var listener: LoginListener?
    
    private let webService: WebServicing
    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    // To invoke a login web-task we need access to WebServicing login method, that we created before. We will pass WerServicing to LoginInteractor init:
    init(presenter: LoginPresentable, webService: WebServicing) {
        self.webService = webService
        super.init(presenter: presenter)
        presenter.listener = self
    }
    
    // Next we see a few lifecycle-managed methods, didBecomeActive and willResignActive . These methods are self-explanatory, and we don’t call them directly. For example, we can perform a web-task in didBecomeActive to fetch required data, or make an initial view setup depending on our business logic.
    override func didBecomeActive() {
        super.didBecomeActive()
        // TODO: Implement business logic here.
    }
    
    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
    
    // MARK: - LoginPresentableListener
    
    // Because we added a few methods to LoginPresentableListener , and LoginInteractor implements this protocol, we need to add missing methods to interactor
    // Having a WebServicing in interactor, we can complete the login method:
    // Inside this method we implement all the login business logic, showing and hiding activity indicator, dismiss LoginFlow on login success, and log an error in case of login failure. Let’s also add another LoginPresentable method showErrorAlert that will notify the user if login is failed:
    func didTapLogin(username: String, password: String) {
        presenter.showActivityIndicator(true)
        webService.login(userName: username, password: password) { [weak self] result in
            self?.presenter.showActivityIndicator(false)
            switch result {
            case let .success(userID):
                // do something with userID if needed
                self?.listener?.dismissLoginFlow()
            case let .failure(error):
                // log error
                self?.presenter.showErrorAlert()
            }
        }
    }
    
    // didTapCreateAccount has to route to CreateAccount RIB, so we just need to invoke an existing LoginRouting method:
    func didTapCreateAccount() {
        router?.routeToCreateAccount()
    }

}
