import Dispatch
import MySQL

final class MySQLFuncs {

    static func createRow<T: Decodable>(functionName: String, parameters: [QueryParameter]) -> Future<T>
    {
        let rowPromise = Promise<T>()

        var sqlStringParams = "("
        for i in 0...parameters.count {
            sqlStringParams += (i == parameters.count - 1) ? "?" : "?, "
        }
        sqlStringParams = ")" // Býr til (?, ?, ?...)

        ProgressTracker.defaultDB.connectionPool.whenReady { connPool in
            guard let pool = connPool else {
                print("Error: Database error")
                return
            }
            do {
                let row: T = try pool.execute { conn in
                    try conn.query("call \(functionName)\(sqlStringParams)", parameters)
                    }[0]
                rowPromise.succeed(result: row)
            } catch {
                rowPromise.fail(error: ProgressTrackerError.failedToLoadFromDB)
            }
        }
        return rowPromise.futureResult
    }

    static func findRow<T: Decodable>(functionName: String, id: QueryParameter) -> Future<T>
    {
        let rowPromise = Promise<T>()
        ProgressTracker.defaultDB.connectionPool.whenReady { connPool in
            guard let pool = connPool else {
                print("Error: Database error")
                return
            }
            do {
                let row: T = try pool.execute { conn in
                    try conn.query("call \(functionName)(?)", [id]) 
                }[0]
                rowPromise.succeed(result: row)
            } catch {
                rowPromise.fail(error: ProgressTrackerError.failedToLoadFromDB)
            }
        }
        return rowPromise.futureResult
    }

    static func getAll<T: Decodable>(functionName: String) -> Future<[T]>
    {
        let rowPromise = Promise<[T]>()
        ProgressTracker.defaultDB.connectionPool.whenReady { connPool in
            guard let pool = connPool else {
                print("Error: Database error")
                return
            }
            do {
                let rows: [T] = try pool.execute { conn in
                    try conn.query("call \(functionName)()") 
                }
                rowPromise.succeed(result: rows)
            } catch {
                rowPromise.fail(error: ProgressTrackerError.failedToLoadFromDB)
            }
        }
        return rowPromise.futureResult
    }

    static func deleteRow(functionName: String, id: QueryParameter) -> Future<Bool>
    {
        let changeResult = Promise<Bool>()
        ProgressTracker.defaultDB.connectionPool.whenReady { connPool in
            guard let pool = connPool else {
                print("Error: Database error")
                return
            }
            do {
                try pool.execute { conn in
                    try conn.query("call \(functionName)(?)", [id])
                }
                changeResult.succeed(result: true)
            } catch {
                changeResult.fail(error: ProgressTrackerError.failedToLoadFromDB)
            }
        }
        return changeResult.futureResult
    }

    static func changeValue(functionName: String, valueToChange: String, changeTo: QueryParameter, id: QueryParameter) -> Future<Bool>
    {
        let changeResult = Promise<Bool>()
        ProgressTracker.defaultDB.connectionPool.whenReady { connPool in
            guard let pool = connPool else {
                print("Error: Database error")
                return
            }
            do {
                 try pool.execute { conn in
                    try conn.query("call \(functionName)(?, ?, ?)", [id, String(describing: valueToChange), changeTo])
                    changeResult.succeed(result: true)
                }
            } catch {
                changeResult.fail(error: ProgressTrackerError.failedToLoadFromDB)
            }
        }
        return changeResult.futureResult
    }

}
