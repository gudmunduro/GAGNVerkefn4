import MySQL

struct Student: Codable, QueryParameter {
    let id: Int
    let name: String
    let credits: Int
    let trackID: Int
    
    private enum CodingKeys: String, CodingKey {
        case id = "studentID"
        case name = "studentName"
        case credits
        case trackID
    }
}

struct Options: ConnectionOption {
    var host = "tsuts.tskoli.is"
    var port = 3306
    var user = "1404002030"
    var password = "ab123"
    var database = "1404002030_progresstracker_v1"
}

let pool = ConnectionPool(option: Options())
let students: [Student] = try pool.execute { conn in
	try conn.query("SELECT * FROM students") 
}
print(students[50].name)