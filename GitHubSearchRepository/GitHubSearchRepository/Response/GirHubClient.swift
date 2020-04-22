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
        completion: @escaping (Result<Request.Response, GitHubClientError>) -> Void) {
        //HTTPリクエストの送信
        let urlRequest = request.buildURLRequest()
        let task = session.dataTask(with: urlRequest) {
            data, response, error in
            
            switch (data, response, error) {
            case (_, _, let error?):
                completion(Result(error: .connectionError(error)))
            case(let data?, let response?, _):
                do {
                    let response = try request.response(
                        from: data, urlResponse: response)
                    completion(Result(value: response))
                } catch let error as GitHubAPIError {
                    completion(Result(error: .responseParseError(error)))
                } catch {
                    completion(Result(error: .responseParseError(error)))
                }
            default:
                fatalError("invalid response combination\(data), \(response), \(error).")
            }
        }
        
        task.resume()
    }
}
