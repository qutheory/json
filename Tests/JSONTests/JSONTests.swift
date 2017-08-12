import XCTest
import JSON
import Dispatch

class JSONTests: XCTestCase {
    func testParse() throws {
        let data = """
        {
            "double": 3.14159265358979,
            "object": {
                "nested": "text"
            },
            "array": [true, 1337, "😄"],
            "int": 42,
            "bool": false,
            "string": "ferret 🚀"
        }
        """.data(using: .utf8)!
        let json = try! KitchenSink(json: data)

        XCTAssertEqual(json.bool, false)
        XCTAssertEqual(json.string, "ferret 🚀")
        XCTAssertEqual(json.int, 42)
        XCTAssertEqual(json.double, 3.14159265358979)
        XCTAssertEqual(json.object["nested"], "text")
        XCTAssertEqual(Bool(json.array[0]), true)
        XCTAssertEqual(Int(json.array[1]), 1337)
        XCTAssertEqual(json.array[2], "😄")
    }

//    func testSerialize() throws {
//        var json: JSON = .object([
//            "null": .null,
//            "bool": .bool(false),
//            "string": .string("ferret 🚀"),
//            "int": .int(42),
//            "double": .double(3.14159265358979),
//            "object": .object([
//                "nested": .string("text")
//            ])
//        ])
//        try json.set("array", to: JSON.array([.null, .bool(true), .int(1337), .string("😄")]))
//
//        let serialized = try json.makeBytes().makeString()
//        XCTAssert(serialized.contains("\"bool\":false"))
//        XCTAssert(serialized.contains("\"string\":\"ferret 🚀\""))
//        XCTAssert(serialized.contains("\"int\":42"))
//        XCTAssert(serialized.contains("\"double\":3.14159265358979"))
//        XCTAssert(serialized.contains("\"object\":{\"nested\":\"text\"}"))
//        XCTAssert(serialized.contains("\"array\":[null,true,1337,\"😄\"]"))
//    }
//
    func testPrettySerialize() throws {
        struct Test: JSONCodable {
            var hello = "world"
        }

        /// let serialized = try json.serialize(prettyPrint: true).makeString()
        /// let expectation = "{\n  \"hello\" : \"world\"\n}"
        /// XCTAssertEqual(serialized, expectation)
    }
//
//    func testStringEscaping() throws {
//        let json = try JSON(["he \r\n l \t l \n o w\"o\rrld "])
//        let data = try json.serialize().makeString()
//        XCTAssertEqual(data, "[\"he \\r\\n l \\t l \\n o w\\\"o\\rrld \"]")
//    }
//
//    var hugeParsed: JSON!
//    var hugeSerialized: Bytes!
//
//    override func setUp() {
//        var huge: [String: JSON] = [:]
//        for i in 0 ... 100_000 {
//            huge["double_\(i)"] = .double(3.14159265358979)
//        }
//
//        hugeParsed = JSON.object(huge)
//        hugeSerialized = try! hugeParsed.makeBytes()
//    }
//
//    func testSerializePerformance() throws {
//        #if XCODE
//            // debug 0.333
//            // release 0.291
//
//            // foundation 0.505 / 0.391
//            measure {
//                _ = try! self.hugeParsed.makeBytes()
//            }
//        #endif
//    }
//
//    func testParsePerformance() throws {
//        #if XCODE
//            // debug 0.885
//            // release 0.127
//
//            // foundation 1.060 / 0.777
//            measure {
//                _ = try! JSON(bytes: self.hugeSerialized)
//            }
//        #endif
//    }
//
//    func testMultiThread() throws {
//        for _ in 1...100 {
//            DispatchQueue.global().async {
//                let _ = try! JSON(bytes: self.hugeSerialized)
//            }
//        }
//    }
//    
//    func testSerializeFragment() throws {
//        let json = try JSON("foo")
//        let bytes = try json.serialize()
//        XCTAssertEqual(bytes.makeString(), "\"foo\"")
//    }
//
    static let allTests = [
        ("testParse", testParse),
    ]
}
