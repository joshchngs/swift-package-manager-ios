//
//  ViewController.swift
//  SwiftPackagesWithiOS
//
//  Created by Josh Channings on 17/08/2017.
//  Copyright © 2017 Music Group Innovation UK Ltd. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

class ViewController: UIViewController {
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var progressView: UIProgressView!

    let bag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        slider.rx.value
            .bind(to: progressView.rx.progress)
            .disposed(by: bag)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

