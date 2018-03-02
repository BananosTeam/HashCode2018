final class Car {
    var index: Int
    var position = Position(x: 0, y: 0)
    var finishedRides = [Ride]()
    var profit = 0

    var currentRideProfit = 0
    var currentRide: Ride? {
        didSet {
            if let ride = oldValue {
                finishedRides.append(ride)
            }
            guard let ride = currentRide else {
                stepsLeft = 0
                currentRideProfit = 0

                return
            }
            let distanceToRide = position.distance(to: ride.start)
            let signedWaitingTime = ride.startTime - (City.currentTime + distanceToRide)
            let waitingTime = signedWaitingTime < 0 ? 0 : signedWaitingTime
            let bonus = waitingTime >= 0 ? City.bonus : 0

            currentRideProfit = ride.length + bonus
            stepsLeft = distanceToRide + waitingTime + ride.length
        }
    }
    var stepsLeft = 0

    init(index: Int) {
        self.index = index
    }

    func update() {
        if stepsLeft > 0 {
            stepsLeft -= 1
        }
        if stepsLeft == 0, currentRide != nil {
            profit += currentRideProfit
            currentRide = nil
        }
    }

    
    func revenue(for ride: Ride) -> Int {
        let distanceToRide: Int = {
            if let currRide = self.currentRide {
                return self.stepsLeft + currRide.end.distance(to: ride.start)
            }
            return position.distance(to: ride.start)
        }()
        let signedWaitingTime = ride.startTime - (City.currentTime + distanceToRide)
        let waitingTime = signedWaitingTime < 0 ? 0 : signedWaitingTime
        let bonus = waitingTime >= 0 ? City.bonus : 0

        let rideEndTime = distanceToRide + ride.length + City.currentTime
        if rideEndTime > ride.endTime || rideEndTime > City.maxSteps { return Int.min } // Time to max end time of ride

        return ride.length + bonus - stepsLeft - distanceToRide - waitingTime
    }
}

final class Position {
    var x: Int
    var y: Int

    var column: Int {
        return x
    }

    var row: Int {
        return y
    }

    func distance(to position: Position) -> Int {
        return abs(row - position.row) + abs(column - position.column)
    }

    init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }
}
