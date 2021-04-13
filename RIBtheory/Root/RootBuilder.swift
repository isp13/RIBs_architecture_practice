//
//  RootBuilder.swift
//  RIBtheory
//
//  Created by Nikita Kazantsev on 13.04.2021.
//

import RIBs

protocol RootDependency: LoginDependency {
    var webService: WebServicing { get }
}

final class RootComponent: Component<RootDependency> {

    private let rootViewController: RootViewController

    init(dependency: RootDependency,
         rootViewController: RootViewController) {
        self.rootViewController = rootViewController
        super.init(dependency: dependency)
    }
}

// MARK: - Builder
protocol RootBuildable: Buildable {
    func build() -> LaunchRouting
}

final class RootBuilder: Builder<RootDependency>, RootBuildable {

    override init(dependency: RootDependency) {
        super.init(dependency: dependency)
    }

    // The few differences will be in RootRouter and RootBuilder, because it’s a top-level RIB that doesn’t have a parent.
    // Instead of creating RootRouting we need to create a LaunchRouting (specific RIB component designed for the top-level RIB):
    func build() -> LaunchRouting {
        let viewController = RootViewController()
        let component = RootComponent(
            dependency: dependency,
            rootViewController: viewController
        )
        
        let loginBuilder = LoginBuilder(dependency: component.dependency)

        let interactor = RootInteractor(presenter: viewController)
        return RootRouter(
            interactor: interactor,
            viewController: viewController,
            loginBuilder: loginBuilder
        )
    }
}
