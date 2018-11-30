import MySQL

struct Student: Codable, QueryParameter {
    
    let id: Int
    var name: String{
        didSet {
            update(column: .name, value: name)
        }
    }
    var credits: Int{
        didSet {
            update(column: .credits, value: credits)
        }
    }
    var trackID: Int{
        didSet {
            update(column: .trackID, value: trackID)
        }
    }

    enum CodingKeys: String, CodingKey {
        case id = "studentID"
        case name = "studentName"
        case credits
        case trackID
    }

    static func create(name: String, credits: Int, trackID: Int) -> Future<Student>
    {
        let student: Future<Student> = MySQLFuncs.createRow(functionName: "createStudent", parameters: [name, credits, trackID])
        return student
    }

    static func find(id: Int) -> Future<Student>
    {
        return MySQLFuncs.findRow(functionName: "selectStudent", id: id)
    }

    func delete() -> Future<Bool>
    {
        return MySQLFuncs.deleteRow(functionName: "deleteStudent", id: id)
    }
    
    func update(column: CodingKeys, value: QueryParameter) -> Future<Bool>
    {
        return MySQLFuncs.changeValue(functionName: "changeStudentValue", valueToChange: String(describing: column), changeTo: value, id: id)
    }
}

