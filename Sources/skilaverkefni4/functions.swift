

func input(_ text: String = "") -> String?
{
    print(text + ": ", terminator: "")
    return readLine()
}
func input(_ text: String = "") -> Int?
{
    print(text + ": ", terminator: "")
    if let input = readLine() {
        return Int(input)
    } else {
        return nil
    }
}