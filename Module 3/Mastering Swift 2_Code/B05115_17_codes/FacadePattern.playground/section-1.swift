// Playground - noun: a place where people can play

import UIKit

struct HotelBooking {
    static func getHotelNameForDates(to: NSDate, from: NSDate) -> [String]? {
        let hotels = [String]()
        //logic to get hotels
        return hotels
    }
}

struct FlightBooking {
    static func getFlightNameForDates(to: NSDate, from: NSDate) -> [String]? {
        let flights = [String]()
        //logic to get flights
        return flights
    }
}

struct RentalCarBooking {
    static func getRentalCarNameForDates(to: NSDate, from: NSDate) -> [String]? {
        let cars = [String]()
        //logic to get flights
        return cars
    }
}


class TravelFacade {
    
    var hotels: [String]?
    var flights: [String]?
    var cars: [String]?
    
    init(to: NSDate, from: NSDate) {
        hotels = HotelBooking.getHotelNameForDates(to, from: from)
        flights = FlightBooking.getFlightNameForDates(to, from: from)
        cars = RentalCarBooking.getRentalCarNameForDates(to, from: from)
    }
}
