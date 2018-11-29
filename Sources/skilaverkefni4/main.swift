
/*let pool = ConnectionPool(option: Options())
let students: [Student] = try pool.execute { conn in
	try conn.query("SELECT * FROM students") 
}
print(students[50].name)*/

let student = Student.find(id: 50)

student.whenReady { student in
    print(student.name)
}