//
//  Result.swift
//  GitHubSearchRepository
//
//  Created by 開発アカウント on 2020/04/22.
//  Copyright © 2020 開発アカウント. All rights reserved.
//

import Foundation

//APIクライアントのインターフェースで使用するメソッドで発生するエラーに対処する
enum Result<T, Error : Swift.Error> {
    case success(T)
    case failure(Error)
    
    init(value: T) {
        self = .success(value)
    }
    
    init(error: Error) {
        self = .failure(error)
    }
}
