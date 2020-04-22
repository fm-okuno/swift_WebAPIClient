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
    
    func buildURLRequest() -> URLRequest {
        //baseURLプロパティとpathプロパティの値を結合した値を取得する為のappendingPathComponent()メソッド
        let url = baseURL.appendingPathComponent(path)
        //結合した値を用いてURLComponents型の値を生成
        var components = URLComponents(
            url: url, resolvingAgainstBaseURL: true)
        
        switch method {
            //methodプロパティの値がgetだった場合
        case .get:
            //GitHubRequestプロトコルのparametersプロパティの値っをURLQueryItem型の値に変換
            let dictionary = parameters as? [String : Any]
            let queryItems = dictionary?.map {
                key, value in return URLQueryItem(name: key,
                                                  value: String(describing: value))
            }
            //変換した値をURLComponents型のプロパティqueryItemsにセット
            components?.queryItems = queryItems
            
        //今回の例ではget以外のHTTPメソッドは考慮しないので、デフォルトケースではfatalError
        default:
            fatalError("Unsupported method \(method)")
        }
        
        //URLRequest型の値を戻り値として返却
        var urlRequest = URLRequest(url: url)
        
        //URLComponents型の値から取得可能なURL型の値をurlプロパティにセット
        urlRequest.url = components?.url
        
        //methodプロパティのローバリューをhttpMethodプロパティにセット
        urlRequest.httpMethod = method.rawValue
        
        //URLRequestを戻り値として返却
        return urlRequest
    }
}
