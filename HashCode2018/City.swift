import Foundation

final class City {
    var size: Grid
    var vehicles = [Car]()
    var rides = [Ride]()
    private var revenuesBuffer: NSMutableArray

    static var bonus = 0
    static var maxSteps = 0
    static var currentTime = 0

    init(size: Grid, vehicles: [Car], rides: [Ride]) {
        self.size = size
        self.revenuesBuffer = NSMutableArray(capacity: rides.count)
        (0..<rides.count).forEach { revenuesBuffer[$0] = Revenue(ride: rides[0], car: vehicles[0], profit: Int.min) }
        self.vehicles = vehicles
        self.rides = rides
    }

    func simulate() {
        for t in 0..<City.maxSteps {
            print("\(t) / \(City.maxSteps)")
            City.currentTime = t
            for car in vehicles {
                guard car.currentRide == nil, let ride = topRide(for: car) else {
                    car.update()
                    
                    continue
                }
                car.currentRide = ride
                if let index = rides.index(where: { $0 === ride }) {
                    rides.remove(at: index)
                }
                car.update()
            }
        }
    }

    func topRide(for car: Car) -> Ride? {
        var (currentMax, currentRide): (Int, Ride?) = (Int.min, nil)
        for ride in rides {
            let revenue = car.revenue(for: ride)
            if revenue > currentMax  {
                currentMax = revenue
                currentRide = ride
            }
        }
        return currentRide
    }
}

final class Revenue {
    var ride: Ride
    var car: Car
    var profit: Int

    init(ride: Ride, car: Car, profit: Int) {
        self.ride = ride
        self.car = car
        self.profit = profit
    }
}
