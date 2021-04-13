//
//  CreateAccountBuilder.swift
//  RIBtheory
//
//  Created by Nikita Kazantsev on 13.04.2021.
//

import RIBs

protocol CreateAccountDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class CreateAccountComponent: Component<CreateAccountDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol CreateAccountBuildable: Buildable {
    func build(withListener listener: CreateAccountListener) -> CreateAccountRouting
}

final class CreateAccountBuilder: Builder<CreateAccountDependency>, CreateAccountBuildable {

    override init(dependency: CreateAccountDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: CreateAccountListener) -> CreateAccountRouting {
        let component = CreateAccountComponent(dependency: dependency)
        let viewController = CreateAccountViewController()
        let interactor = CreateAccountInteractor(presenter: viewController)
        interactor.listener = listener
        return CreateAccountRouter(interactor: interactor, viewController: viewController)
    }
}
