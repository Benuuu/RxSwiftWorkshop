//
//  ViewController.swift
//  RxSwiftWorkshop
//
//  Created by Ben Wu on 9/26/16.
//  Copyright © 2016 Ben Wu. All rights reserved.
//

import UIKit
import RxSwift

class ViewController: UIViewController {

    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        doRxStuff()
    }

    func doRxStuff() {
        let var1 = Variable<Int>(0)
        let var2 = Variable<Int>(1)

        let zipped = Observable.zip(var1.asObservable(), var2.asObservable()) { (v1, v2) -> String in
            return "the pair: \(v1), \(v2)"
        }
        let observableToPrint = zipped
        observableToPrint.subscribe(onNext: { i in
            print(i)
        }).addDisposableTo(disposeBag)


        var1.value = 2
        var1.value = 0
        var2.value = 3
        var1.value = 4
        var2.value = 5
    }

}

