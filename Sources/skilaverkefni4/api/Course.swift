import MySQL

struct Course: Codable, QueryParameter {
    
    let number: String
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

    enum CodingKeys: String, CodingKey {
        case number = "courseNumber"
        case name = "courseName"
        case credits = "courseCredits"
    }

    static var all: Future<[Course]> {
        return MySQLFuncs.getAll(functionName: "getAllStudents")
    }

    static func create(number: String, name: String, credits: Int) -> Future<Student>
    {
        let student: Future<Student> = MySQLFuncs.createRow(functionName: "createCourse", parameters: [number, name, credits])
        return student
    }

    static func find(number: String) -> Future<Student>
    {
        return MySQLFuncs.findRow(functionName: "selectCourse", id: number)
    }

    func delete() -> Future<Bool>
    {
        return MySQLFuncs.deleteRow(functionName: "deleteCourse", id: number)
    }
    
    func update(column: CodingKeys, value: QueryParameter) -> Future<Bool>
    {
        return MySQLFuncs.changeValue(functionName: "changeCourseValue", valueToChange: String(describing: column), changeTo: value, id: number)
    }
}

