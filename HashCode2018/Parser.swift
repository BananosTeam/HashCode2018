import Foundation

struct Parser {

    func parse(_ name: String) -> City {
        let contents = try! String(contentsOf: Bundle.main.url(forResource: name, withExtension: "in")!)
        let lines = contents.split(separator: "\n").map(String.init)
        let info = lines[0].split(separator: " ").map(String.init)
        let rows = Int(info[0])!
        let columns = Int(info[1])!
        let vehicles = Int(info[2])!
        City.bonus = Int(info[4])!
        City.maxSteps = Int(info[5])!

        let rides = lines[1..<lines.count].enumerated().reduce([Ride]()) { rides, tuple in
            let line = tuple.element
            let info = line.split(separator: " ").map(String.init)
            let startRow = Int(info[0])!
            let startColumn = Int(info[1])!
            let endRow = Int(info[2])!
            let endColumn = Int(info[3])!
            let start = Int(info[4])!
            let finish = Int(info[5])!

            return rides + [Ride(start: Position(x: startColumn, y: startRow),
                                 end: Position(x: endColumn, y: endRow),
                                 startTime: start,
                                 endTime: finish,
                                 index: tuple.offset)]
        }

        return City(size: Grid(rows: rows, columns: columns),
                    vehicles: (0..<vehicles).map { Car(index: $0) },
                    rides: rides)
    }
}
