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
import Intrepid

class ViewController: UIViewController {

    let disposeBag = DisposeBag()

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var button: UIButton!

    let viewModel = LoginViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.username <- usernameTextField.rx.textInput.text >>> disposeBag
        viewModel.password <- passwordTextField.rx.textInput.text >>> disposeBag

        button.rx.enabled <- viewModel.buttonEnabled >>> disposeBag
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
