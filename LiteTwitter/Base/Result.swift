//
//  Result.swift
//  LiteTwitter
//
//  Created by Dinh Thanh An on 12/8/18.
//  Copyright © 2018 Dinh Thanh An. All rights reserved.
//

import Foundation

enum Result<T> {
    case success(T)
    case failed(Error)
}
