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

    @IBOutlet weak var textField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        let textFieldNonEmptyObservable = textField.rx.textInput.text.map { $0.characters.count > 0 }
        textFieldNonEmptyObservable.subscribe(onNext: { (notEmpty) in
            print(notEmpty)
            }).addDisposableTo(disposeBag)
    }

}

