//
//  GitHubClientError.swift
//  GitHubSearchRepository
//
//  Created by 開発アカウント on 2020/04/21.
//  Copyright © 2020 開発アカウント. All rights reserved.
//

import Foundation

//APIクライアントがモデル化されたレスポンスを取得するまでに発生し得るエラーを3つに分類し
//Errorプロトコルに準拠した列挙型GitHubClientErrorとして定義
enum GitHubClientError : Error {
    //通信に失敗した場合
    case connectionError(Error)
    
    //レスポンスの解釈に失敗
    case responseParseError(Error)
    
    //APIからエラーレスポンスを受け取った
    case apiError(Error)
}
