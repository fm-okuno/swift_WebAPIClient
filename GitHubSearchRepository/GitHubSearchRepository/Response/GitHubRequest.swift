//
//  GitHubRequest.swift
//  GitHubSearchRepository
//
//  Created by 開発アカウント on 2020/04/21.
//  Copyright © 2020 開発アカウント. All rights reserved.
//

import Foundation

//URLは共通の部分が多いので、URLをベースURLとパスの2つに分け、GitHubRequestプロトコルに定義
protocol GitHubRequest {
    //レスポンスの方をリクエストの方に紐付け、
    //リクエストの型からレスポンスの型を決定できるよう、連想型Responseを追加
    associatedtype Response: JSONDecodable
    
    var baseURL: URL { get }
    var path: String { get }
    //HTTPMethod.swiftでHTTPメソッドを設定したのでHTTPMethod型プロパティmethodを追加
    var method: HTTPMethod { get }
    //リクエストのパラメータを送信する為のプロパティparametersを追加
    var parameters: Any? { get }
}


//プロトコルエクステンションで全てのリクエストに共通のbaseURLのデフォルト実装を定義
extension GitHubRequest {
    var baseURL: URL {
        return URL(string: "https://api.github.com")!
    }
}
