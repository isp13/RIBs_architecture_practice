//
//  CreateAccountInteractor.swift
//  RIBtheory
//
//  Created by Nikita Kazantsev on 13.04.2021.
//

import RIBs
import RxSwift

protocol CreateAccountRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol CreateAccountPresentable: Presentable {
    var listener: CreateAccountPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol CreateAccountListener: class {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class CreateAccountInteractor: PresentableInteractor<CreateAccountPresentable>, CreateAccountInteractable, CreateAccountPresentableListener {

    weak var router: CreateAccountRouting?
    weak var listener: CreateAccountListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: CreateAccountPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        // TODO: Implement business logic here.
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
}
