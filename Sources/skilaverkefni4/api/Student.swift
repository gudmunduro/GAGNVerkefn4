import Dispatch
import MySQL


struct Student: Codable, QueryParameter {
    let id: Int
    let name: String
    let credits: Int
    let trackID: Int

    static func create()
    {
        
    }

    static func find(id: Int) -> Future<Student>
    {
        let studentPromise = Promise<Student>()
        ProgressTracker.defaultDB.connectionPool.whenReady { pool in 
            do {
                let student: Student = try pool.execute { conn in
                    try conn.query("SELECT * FROM students where studentid = ?", [id]) 
                }[0]
                studentPromise.succeed(result: student)
            } catch {
                studentPromise.fail(error: ProgressTrackerError.failedToLoadFromDB)
            }
        }
        return studentPromise.futureResult
    }

    func delete()
    {

    }
    
    private enum CodingKeys: String, CodingKey {
        case id = "studentID"
        case name = "studentName"
        case credits
        case trackID
    }
}

