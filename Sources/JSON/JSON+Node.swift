import enum Jay.JSON
import Node

extension Jay.JSON {
    
    func toNode() -> Node {
        switch self {
        case .array(let values):
            return .array(values.map { $0.toNode() })
        case .boolean(let value):
            return .bool(value)
        case .null:
            return .null
        case .number(let number):
            let num: Node.Number
            switch number {
            case .double(let value):
                num = .double(value)
            case .integer(let value):
                num = .int(value)
            case .unsignedInteger(let value):
                num = .uint(value)
            }
            return .number(num)
        case .object(let values):
            var dictionary: [String: Node] = [:]
            for (key, value) in values {
                dictionary[key] = value.toNode()
            }
            return .object(dictionary)
        case .string(let value):
            return .string(value)
        }
    }
}

extension Node {
    
    func toJSON() -> Jay.JSON {
        switch self {
        case .array(let values):
            return .array(values.map { $0.toJSON() })
        case .bool(let value):
            return .boolean(value)
        case .bytes(let bytes):
            return .string(bytes.base64String)
        case .null:
            return .null
        case .number(let number):
            let num: Jay.JSON.Number
            switch number {
            case .double(let value):
                num = .double(value)
            case .int(let value):
                num = .integer(value)
            case .uint(let value):
                num = .unsignedInteger(value)
            }
            return .number(num)
        case .object(let values):
            var dictionary: [String: Jay.JSON] = [:]
            for (key, value) in values {
                dictionary[key] = value.toJSON()
            }
            return .object(dictionary)
        case .string(let value):
            return .string(value)
        case .date(let date):
            return .string(date.description) // TODO: Decide if there is a Date format that is better for JSON format
        }
    }
}
