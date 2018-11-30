
/*let pool = ConnectionPool(option: Options())
let students: [Student] = try pool.execute { conn in
	try conn.query("SELECT * FROM students") 
}
print(students[50].name)*/

struct ManangeStudents {
    lazy let menu = {
        return Menu([
            "Display all": self.displayAll(),
            "Delete student": self.delete(),
            "Rename student": self.rename(),
            "Add Student": self.add()
        ])
    }

    private func askForID() -> Int?
    {
        print("ID of student: ", terminator: "")
        return Int(readline())
    }

    func displayAll()
    {

    }

    func delete()
    {
        guard let id = askForID() else {
            print("Error: Invalid id")
            return
        }
        Student.find(id: id).whenReady{ studentn in
            guard let student = studentn else {
                print("Error: Student with id \(id) not found")
                return
            }
            student.delete().whenReady { success in
                if success {
                    print("Student with id \(id) has been deleted")
                } else {
                    print("Failed to delete student with id \(id)")
                }
            }
        }
    }

    func rename()
    {
        guard let id = askForID() else {
            print("Error: Invalid id")
            return
        }
        print("New name: ", terminator: "")
        let name = readline()

        Student.find(id: id).whenReady{ studentn in
            guard let student = studentn else {
                print("Error: Student with id \(id) not found")
                return
            }
            student.update(column: .name, value: name).whenReady { success in
                if success {
                    print("Student with id \(id) has been renamed")
                } else {
                    print("Failed to rename student with id \(id)")
                }
            }
        }
    }

    func add()
    {
        print("Name: ", terminator: "")
        let name = readline()
        print("Credits: ", terminator: "")
        guard let credits = Int(readline()) else {
            print("Invalid credits")
            return
        }
        print("Track: ", terminator: "")
        guard let trackid = Int(readline()) else {
            print("Invalid track")
            return
        }
        Student.create(name: "Jón", credits: credits, track: trackid).whenReady { student in
            if student != nil {
                print("Student with id \(id) created")
            } else {
                print("Failed to create student with id \(id)")
            }
        }
    }
}

let menu = Menu("Select action", [
    "Manange students": {
        ManangeStudents().menu.display()
    },
    "Manange schools": {
        print("Option not implemented")
    },
    "Manange courses": {
        print("Option not implemented")
    }
])
menu.display()