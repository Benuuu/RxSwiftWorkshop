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
        let oneToTen = Observable.from([1,2,3,4,5,6,7,8,9,10])
        let mapped = oneToTen.map { $0 * 10 }.map { "counting to 100 by tens: \($0)" }
        let observableToPrint = mapped
        observableToPrint.subscribe(onNext: { i in
            print(i)
        }).addDisposableTo(disposeBag)
    }

}

