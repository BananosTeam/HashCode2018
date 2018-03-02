final class Ride {
    var start: Position
    var end: Position
    var startTime: Int
    var endTime: Int

    var index: Int

    lazy var length: Int = {
        return start.distance(to: end)
    }()

    var finish: Int {
        return endTime
    }

    init(start: Position, end: Position, startTime: Int, endTime: Int, index: Int) {
        self.start = start
        self.end = end
        self.startTime = startTime
        self.endTime = endTime
        self.index = index
    }
}
