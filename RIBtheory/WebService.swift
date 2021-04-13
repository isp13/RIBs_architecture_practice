//
//  WebService.swift
//  RIBtheory
//
//  Created by Nikita Kazantsev on 13.04.2021.
//

import Foundation

protocol WebServicing: class {
    func login(userName: String, password: String, handler: (Result<String, Error>) -> Void)
}
