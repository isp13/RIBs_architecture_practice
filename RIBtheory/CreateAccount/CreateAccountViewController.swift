//
//  CreateAccountViewController.swift
//  RIBtheory
//
//  Created by Nikita Kazantsev on 13.04.2021.
//

import RIBs
import RxSwift
import UIKit

protocol CreateAccountPresentableListener: class {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class CreateAccountViewController: UIViewController, CreateAccountPresentable, CreateAccountViewControllable {

    weak var listener: CreateAccountPresentableListener?
}
