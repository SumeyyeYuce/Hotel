//
//  RoomType.swift
//  HotelCalifornia
//
//  Created by Sümeyye on 17.02.2023.
//

import Foundation

//Equatable -> Bu protokol ile kıyaslama yapabiliyoruz. Örneğin oda suit mi?

struct RoomType : Equatable{
    //MARK: - Properties
    var id: Int
    var name: String
    var shortName: String
    var price: Int
    
    //MARK: - Functions
    //Equatable eşit eşit fonksiyonunu verir bize(lhs-left hein sayt)
   static func  == (lhs:RoomType, rhs:RoomType) -> Bool {
       return lhs.id == rhs.id //iki odanın da id si eşitse odalar aynı demek.
    }
    
    static var all:[RoomType]{ //tüm RoomType elemanlarına erişmek
        return[
            RoomType(id: 0, name: "Two Queens", shortName: "2Q", price: 179),
            RoomType(id: 1, name: "One King", shortName: "K", price: 209),
            RoomType(id: 2, name: "Suit", shortName: "S", price: 309)
        ]
    }
}

//RoomType.all -> Oteldeki tüm oda türlerini verir.

