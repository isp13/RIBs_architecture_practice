//
//  LoginBuilder.swift
//  RIBtheory
//
//  Created by Nikita Kazantsev on 13.04.2021.
//

import RIBs


// LoginDependency is used to inject dependencies into the RIB from its parent. For example, we have a webService that we use to perform a login web-request. We create a WebServicing protocol we want to inject:
protocol LoginDependency: CreateAccountDependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
    var webService: WebServicing { get }
}


// We can declare some local variables that we only use within this Builder, such as settings, or AdMob ID, etc. For our example, we will leave this class as is, because we don’t need any private dependencies.
final class LoginComponent: Component<LoginDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

// The next protocol is a LoginBuildable that has only one method build(with listener:). The listener it takes as a parameter is a parent listener. We are free to add more parameters to this build method, as it’s suitable for our logic.
protocol LoginBuildable: Buildable {
    func build(withListener listener: LoginListener) -> LoginRouting
}


// LoginBuilder class implements LoginBuildable and it’s a major component here. It uses the LoginDependency to create a LoginComponent.
final class LoginBuilder: Builder<LoginDependency>, LoginBuildable {

    override init(dependency: LoginDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: LoginListener) -> LoginRouting {
        // LoginComponent now encapsulates all the dependencies we need for this RIB.
        let component = LoginComponent(dependency: dependency)
        
        // The builder also creates a LoginViewController, LoginInteractor, that is used to create and return a LoginRouter.
        let viewController = LoginViewController()
        let interactor = LoginInteractor(presenter: viewController, webService: component.dependency.webService)
        
        // This is how we connect the parent interactor with a child interactor. For example, we have a LoginRIB that is connected to a RootRIB. In this case RootInteractor will have to implement the methods, that LoginInteractor listener will declare. If LoginInteractor says dismissLogin, root RIB will implement this method to detach Login flow and present a home page.
        interactor.listener = listener
        
        // Note, that we use component.dependency as createAccountBuilder dependency. To do so, we need our LoginDependency to implement CreateAccountDependency protocol. This is how we connect dependencies from the parent to child RIBs:
        let createAccountBuilder = CreateAccountBuilder(dependency: component.dependency)
               
        return LoginRouter(interactor: interactor, viewController: viewController, createAccountBuilder: createAccountBuilder)
    }
}
