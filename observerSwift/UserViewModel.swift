//
//  UserViewModel.swift
//  observerSwift
//
//  Created by Keshav Raj Kashyap on 29/11/21.
//

import Foundation
import RxSwift
import RxCocoa
//1
struct LoginViewModel {
//    2
    let email = BehaviorRelay<String>(value: "")
//    3
    let password = BehaviorRelay<String>(value: "")
//    4
    let isValid: Observable<Bool>
    
    init() {
//        5
        isValid = Observable.combineLatest(self.email.asObservable(), self.password.asObservable())
        { (email, password) in
//            6
            return email.isValidEmail()
                && password.isValidPassword()
        }
    }
}
