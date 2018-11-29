import Foundation
import Dispatch
import MySQL

class ProgressTracker {
    static let defaultDB = ProgressTracker()

    let connectionPool: Future<ConnectionPool>

    init() 
    {
        let connectionPoolPromise: Promise<ConnectionPool> = Promise()
        DispatchQueue.global().async {
            let connectionPool = ConnectionPool(option: ConnectionOptions())
            connectionPoolPromise.succeed(result: connectionPool)
        }
        connectionPool = connectionPoolPromise.futureResult
    }

    // private func run<T>(code: String) -> Future<T>
    // {
    //     
    // }

    

}
