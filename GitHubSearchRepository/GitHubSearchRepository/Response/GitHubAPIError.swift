//
//  GitHubClientError.swift
//  GitHubSearchRepository
//
//  Created by 開発アカウント on 2020/04/21.
//  Copyright © 2020 開発アカウント. All rights reserved.
//

import Foundation

//モデル化とは、他のファイルやフォーマットから受け取ったデータをSwift側で初期化し、使用可能にする事？
//インターネットで調べても具体的な記述等がなく、よく分かりませんでした…

//サーバー側でエラーが発生した場合に帰ってくるレスポンス（GitHubAPIのエラーレスポンス）をモデル化するための
//構造体GitHubAPIErrorを定義
struct GitHubAPIError : JSONDecodable, Error {
    
    //resource, field, codeはJSONのerrorsプロパティとして配列で定義されている
    //その配列の要素をモデル化する為、JSONDecodableプロトコルに準拠する
    //構造体「GitHubAPIError.FieldError」を定義
    struct FieldError : JSONDecodable {
        let resource: String
        let field: String
        let code: String
        
        //初期化を実行。初期値を設定出来ない場合にはエラーを投げる
        init(json: Any) throws {
            guard let dictionary = json as? [String : Any] else {
                throw JSONDecodeError.invailedFormat(json: json)
            }
            
            guard let resource = dictionary["resource"] as? String else {
                throw JSONDecodeError.missingValue(
                    key: "resource",
                    actualValue: dictionary["resource"])
            }
            
            guard let field = dictionary["field"] as? String else {
                throw JSONDecodeError.missingValue(
                    key: "field",
                    actualValue: dictionary["field"])
            }
            
            guard let code = dictionary["code"] as? String else {
                throw JSONDecodeError.missingValue(
                    key: "code",
                    actualValue: dictionary["code"])
            }
            
            self.redource = resource
            self.field = field
            self.code = code
        }
    }
    
    
    let messasge: String
    //errorsプロパティ自体を表すfieldError型のプロパティ「fieldErrors」
    let fieldErrors: [FieldError]
    
    //初期化を実行。初期値を設定出来ない場合にはエラーを投げる
    init(json: Any) throws {
        guard let dictionary = json as? [String : Any] else {
            throw JSONDecodeError.invalidFormat(json: json)
        }
        
        guard let message = dictionary["message"] as? String else {
            throw JSONDecodeError.missingValue(
                key: "message",
                actualValue: dictionary["message"])
        }
        
        let fieldErrorObjects = dictionary["errors"] as? [Any] ?? []
        let fieldErrors = try fieldErrorObjrcts.map {
            return try FieldError(json: $0)
        }
        
        self.message = message
        self.fieldErrors = fieldError
    }
}
