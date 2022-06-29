//
//  ReactiveComponent.swift
//  OpenTweet
//
//  Created by Luis Eduardo Moreno Nava on 27/06/22.
//  Copyright © 2022 OpenTable, Inc. All rights reserved.
//

import Foundation

class Observable<T>{
    var value: T? {
        didSet{
            listener?(value)
        }
    }

    init(_ value: T?) {
        self.value = value
    }

    private var listener: ((T?) -> Void)?

    func bind(_ listener:@escaping (T?) -> Void){
        listener(value)
        self.listener = listener
    }
}
