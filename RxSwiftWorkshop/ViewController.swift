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

    override func viewDidLoad() {
        super.viewDidLoad()

        let usernameValid = usernameTextField.rx.textInput.text.map { $0.characters.count >= 3 }
        let passwordValid = passwordTextField.rx.textInput.text.map { $0.characters.count >= 4 }

        let isValid = Observable.combineLatest(usernameValid, passwordValid) { $0 && $1 }

        isValid.bindTo(button.rx.enabled).addDisposableTo(disposeBag)
    }

    @IBAction func buttonTapped(_ sender: AnyObject) {
        print("the user tapped the button!")
    }
}
