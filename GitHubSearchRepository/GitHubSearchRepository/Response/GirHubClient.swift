//
//  GirHubClient.swift
//  GitHubSearchRepository
//
//  Created by 開発アカウント on 2020/04/22.
//  Copyright © 2020 開発アカウント. All rights reserved.
//

import Foundation

//HTTPクライアントの実装
class GitHubClient {
    private let session: URLSession = {
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        return session
    }()
    
    //APIクライアントのインターフェースの定義
    func send<Request : GitHubRequest> (
        request: Request,
        completion: (Result<Request.Response, GitHubClientError>) -> Void) {
    }
}
