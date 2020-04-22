//
//  GitHubAPI.swift
//  GitHubSearchRepository
//
//  Created by 開発アカウント on 2020/04/21.
//  Copyright © 2020 開発アカウント. All rights reserved.
//

import Foundation

//オーバーライドを想定しない為、finalキーワードでオーバーライドを禁止
final class GitHubAPI {
    //
    struct SearchRepositories : GitHubRequest {
        let keyword: String
        
        //GitHubRequestが要求する連想型
        typealias Response = SearchResponse<Repository>
        
        var method: HTTPMethod {
            return .get
        }
        
        var path: String {
            return "/search/repositories"
        }
        
        var parameters: Any? {
            return ["q": keyword]
        }
    }
    
    struct SearchUsers : GitHubRequest {
        let keyword: String
        
        typealias Response = SearchResponse<User>
        
        var method: HTTPMethod {
            return .get
        }
        
        var path: String {
            return "/search/users"
        }
        
        var parameters: Any? {
            return ["q": keyword]
        }
    }
}
