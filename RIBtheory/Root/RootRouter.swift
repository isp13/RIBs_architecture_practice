//
//  RootRouter.swift
//  RIBtheory
//
//  Created by Nikita Kazantsev on 13.04.2021.
//

import RIBs

protocol RootInteractable: Interactable, LoginListener {
    var router: RootRouting? { get set }
    var listener: RootListener? { get set }
}

protocol RootViewControllable: ViewControllable {
    func replaceScreen(viewController: ViewControllable)
}

final class RootRouter: LaunchRouter<RootInteractable, RootViewControllable>, RootRouting {

    private let loginBuilder: LoginBuildable
    private var loginRouter: LoginRouting?
    
    init(
        interactor: RootInteractable,
        viewController: RootViewControllable,
        loginBuilder: LoginBuildable
    ) {
        self.loginBuilder = loginBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    func attachLogin() {
        guard loginRouter == nil else { return }
        let router = loginBuilder.build(withListener: interactor)
        attachChild(router)
        loginRouter = router
        viewController.replaceScreen(viewController: router.viewControllable)
    }
    
}
