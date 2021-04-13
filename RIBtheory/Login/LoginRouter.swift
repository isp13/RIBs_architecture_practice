//
//  LoginRouter.swift
//  RIBtheory
//
//  Created by Nikita Kazantsev on 13.04.2021.
//

import RIBs

protocol LoginInteractable: Interactable, CreateAccountListener {
    var router: LoginRouting? { get set }
    var listener: LoginListener? { get set }
}

// LoginViewControllable is used to manipulate the view hierarchy. So when the Interactor tells a router to navigate to CreateAccount using LoginRouting , the router will eventually need to present a CreateAccount screen. We need to add the following method:
protocol LoginViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
    func present(_ viewController: ViewControllable)
}

final class LoginRouter: ViewableRouter<LoginInteractable, LoginViewControllable>, LoginRouting {
    
    // To build a CreateAccount RIB, LoginRouter needs to have CreateAccountBuilder. Declare a private variable of type CreateAccountBuildable
    private let createAccountBuilder: CreateAccountBuildable
    
    private var createAccountRouter: CreateAccountRouting?
    

    // TODO: Constructor inject child builder protocols to allow building children.
    // also update LoginRouter init, injecting CreateAccountBuildable.
    init(
        interactor: LoginInteractable,
        viewController: LoginViewControllable,
        createAccountBuilder: CreateAccountBuildable
    ) {
        self.createAccountBuilder = createAccountBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    func routeToCreateAccount() {
        // Now we update routeToCreateAccount method. We need to save createAccountRouter to a local variable.
        // As a bonus, we can guard ourselves against creating a router and presenting a child view controller, if a child router has already been created:
        guard createAccountRouter == nil else { return }
        // We use createAccountBuilder to build a createAccountRouter . We need to pass the current interactor as a listener in build method.
        let router = createAccountBuilder.build(withListener: interactor)
        
        
        createAccountRouter = router
        
        // We attach the createAccountRouter as a child to the current router. This is how we build s RIBs tree.
        
        // Here is another important thing to remember. We use attachChild method to attach createAccountRouter . Going forward, you will eventually need another method to dismiss CreateAccount screen. Once the child screen is dismissed, we have to detach its router from the current tree.
        // We don’t want to see ourselves in the state, when the viewController is no longer available, but the corresponding RIB is still in the tree. This may eventually cause memory leaks and unexpected behavior.
        // To avoid this, we will keep a reference to CreateAccountRouter . Create a variable within LoginRouter (createAccountBuilder createAccountRouter)
        attachChild(router)
        
        // We invoke LoginViewControllable method to present CreateAccount view controller.
        viewController.present(router.viewControllable)
    }
    
    // Finally, when we want to dismiss CreateAccount screen, we have to detach its router after we manipulate with a view hierarchy:
    func detachCreateAccount() {
        guard let createAccountRouter = createAccountRouter else { return }
        createAccountRouter.viewControllable.uiviewController.dismiss(animated: true, completion: nil)
        detachChild(createAccountRouter)
        self.createAccountRouter = nil
    }
}
