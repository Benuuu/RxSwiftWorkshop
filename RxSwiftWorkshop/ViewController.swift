//
//  ViewController.swift
//  RxSwiftWorkshop
//
//  Created by Ben Wu on 9/26/16.
//  Copyright © 2016 Ben Wu. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    let disposeBag = DisposeBag()

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var button: UIButton!

    let viewModel = LoginViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        usernameTextField.rx.textInput.text.bindTo(viewModel.username).addDisposableTo(disposeBag)
        passwordTextField.rx.textInput.text.bindTo(viewModel.password).addDisposableTo(disposeBag)

        viewModel.buttonEnabled.bindTo(button.rx.enabled).addDisposableTo(disposeBag)
    }

    @IBAction func buttonTapped(_ sender: AnyObject) {
        print("the user tapped the button!")
    }
}


class LoginViewModel {
    let username = Variable<String>("")
    let password = Variable<String>("")
    let buttonEnabled: Observable<Bool>

    init() {
        let usernameValid = username.asObservable().map { $0.characters.count >= 3 }
        let passwordValid = password.asObservable().map { $0.characters.count >= 4 }

        buttonEnabled = Observable.combineLatest(usernameValid, passwordValid) { $0 && $1 }
    }


}
