import MySQLDriver

let conn = MySQL.Connection()

do {
    try conn.open("tsuts.tskoli.is", user="1404002030", passwd: "ab123")

    try conn.use("")
}
