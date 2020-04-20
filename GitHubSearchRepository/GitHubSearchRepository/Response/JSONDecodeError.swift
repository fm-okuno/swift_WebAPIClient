//他ファイルでもエラーメッセージを使用できるようにJSONDecodableプロトコルを定義
protocol JSONDecodable {
    init(json: Any) throws
}

//JSONから構造体を初期化する際に起こり得るエラーを構造体JSONDecodeError型に定義
enum JSONDecodeError : Error {
    case invalidFormat(json: Any)
    case missingValue(key: String, actualValue: Any?)
}
