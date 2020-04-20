//JSONのリソースに対応する為の構造体User型を定義
struct User {
    let id: Int
    let login: String
    
    //イニシャライザを実装
    //初期化が不可能である場合にはエラーを投げる
    init(json: Any) throws {
        guard let dictionary = json as? [String : Any] else {
            throw JSONDecodeError.invalidFormat(json: json)
        }
        
        guard let id = dictionary["id"] as? Int else {
            throw JSONDecodeError.missingValue(
                key: "id", actualValue: dictionary["id"])
        }
        
        guard let login = dictionary["login"] as? String else {
            throw JSONDecodeError.missingValue(
                key: "login", actualValue: ["login"])
        }
        
        self.id = id
        self.login = login
    }
}
