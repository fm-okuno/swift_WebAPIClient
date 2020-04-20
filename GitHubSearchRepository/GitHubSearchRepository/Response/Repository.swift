import Foundation

//JSONのリソースに対応するための構造体Repository型を定義
//エラーを使用する為のJSONDecodableプロトコルを準拠
struct Repository : JSONDecodable {
    let id: Int
    let name: String
    let fullName: String
    let owner: User
    
    //初期化を実行。初期値を設定できない場合にはエラーを投げる
    init(json: Any) throws {
        guard let dictionary = json as? [String : Any] else {
            throw JSONDecodeError.invalidFormat(json: json)
        }
        
        guard let id = dictionary["id"] as? Int else {
            throw JSONDecodeError.missingValue(
                key: "id", actualValue: dictionary["name"])
        }
        
        guard let name = dictionary["name"] as? String else {
            throw JSONDecodeError.missingValue(
                key: "name", actualValue: dictionary["name"])
        }
        
        guard let fullName = dictionary["full_name"] as? String else {
            throw JSONDecodeError.missingValue(
                key: "full_name",
                actualValue: dictionary["full_name"])
        }
        
        guard let ownerObject = dictionary["owner"] else {
            throw JSONDecodeError.missingValue(
                key: "owner", actualValue: ["oener"])
        }
        
        self.id = id
        self.name = name
        self.fullName = fullName
        self.owner = try User(json: ownerObject)
    }
}
