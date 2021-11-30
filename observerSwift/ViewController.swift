//
//  ViewController.swift
//  observerSwift
//
//  Created by Keshav Raj Kashyap on 29/11/21.
//

import UIKit
import RxSwift
import RxCocoa



class ViewController: UIViewController {
    
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var txtpassword: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    
    let viewModel = LoginViewModel()  // 1
    let disposeBag = DisposeBag()  // 2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtEmail.rx.text.orEmpty.bind(to: viewModel.email)
            .disposed(by: disposeBag)
        txtpassword.rx.text.orEmpty.bind(to: viewModel.password)
            .disposed(by: disposeBag)
        viewModel.isValid.map { $0 }
        .bind(to: btnLogin.rx.isEnabled)
        .disposed(by: disposeBag)
    }
    
  ///button to login
    @IBAction func btnLogin(_ sender: UIButton) {
        let alert = UIAlertController(title: "Login", message: "Login Button Enabled/Tapped!", preferredStyle: .alert)
              let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
              alert.addAction(okAction)
              self.present(alert, animated: true, completion: nil)
    }
    
}






//MARK :- EXTENSION FOR PASSWORD AND EMAIL VALIDATION
extension String {
    /// Used to validate if the given string is valid email or not
    ///
    /// - Returns: Boolean indicating if the string is valid email or not
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        print("emailTest.evaluate(with: self): \(emailTest.evaluate(with: self))")
        return emailTest.evaluate(with: self)
    }
    
    /// Used to validate if the given string matches the password requirements
    ///
    /// - Returns: Boolean indicating the comparison result
    func isValidPassword() -> Bool {
        print("self.count >= 6: \(self.count >= 6)")
        return self.count >= 6
    }
}
 



