

class Menu {

    let header: String?
    var options: [String: () -> Void]

    init()
    {
        self.header = nil
        self.options = [:]
    }

    init(header: String?)
    {
        self.header = header
        self.options = [:]
    }

    init(options: [String: () -> Void])
    {
        self.header = nil
        self.options = options
    }

    init(header: String?, options: [String: () -> Void]) {
        self.header = header
        self.options = options
    }

    func display()
    {
        if let header = self.header {
            print(header)
        }
        var optionCounter = 1;
        for option in options {
            print(String(optionCounter) + ": " + option.key)
            optionCounter += 1;
        }
        while true {
            print("Select option: ", terminator: "")
            guard let selected = Int(readLine()!), 1...options.count ~= selected  else {
                print("Selection is invalid or not in range")
                continue
            }
            options[Array(options.keys)[selected - 1]]!()
            break
        }
    }

}