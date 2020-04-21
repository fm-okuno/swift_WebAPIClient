//
//  SearchResponse.swift
//  GitHubSearchRepository
//
//  Created by 開発アカウント on 2020/04/21.
//  Copyright © 2020 開発アカウント. All rights reserved.
//

import Foundation

//ジェネリック型を使用し、多種類の検索結果を汎用的に扱えるSearchResponse<Item>型
struct SearchResponse<Item : JSONDecodable> : JSONDecodable {
    let totalCount: Int
    let items: [Item]
    
    //初期化を実行し、初期値を設定できない場合にはエラーを投げる
    init(json: Any) throws {
        guard let dictionary = json as? [String : Any] else {
            throw JSONDecodeError.invalidFormat(json: json)
        }
        
        guard let totalCount = dictionary["total_count"] as? Int else {
            throw JSONDecodeError.missingValue(
                key: "total_count",
                actualValue: dictionary["total_count"])
        }
        
        guard let itemObjects = dictionary["items"] as? [Any] else {
            throw JSONDecodeError.missingValue(
                key: "items",
                actualValue: dictionary["items"])
        }
        
        let items = try itemObjects.map {
            return try Item(json: $0)
        }
        
        self.totalCount = totalCount
        self.items = items
    }
}
