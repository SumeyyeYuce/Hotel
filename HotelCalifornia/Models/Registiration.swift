//
//  Registiration.swift
//  HotelCalifornia
//
//  Created by Sümeyye on 17.02.2023.
//

import Foundation

struct Registiration{
    var firstName:String
    var lastName:String
    var emailAddress:String
    
    var checkInDate: Date
    var checkOutDate: Date
    
    var numberOfAdults: Int//Kaç adet yetişkin
    var numberOfChildren:Int//Kaç adet çoçuk
    
    
    var roomType: RoomType
    var wifi:Bool
    
    func fullName() -> String{
        return firstName + " " + lastName
    }
}

