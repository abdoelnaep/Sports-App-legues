

import Foundation



struct Sport: Codable {
    let sports: [SportElement]
}

struct SportElement: Codable {
    let idSport : String
    let strSport: String
    let strFormat: String
    let strSportThumb: String
    let strSportIconGreen: String
    let strSportDescription: String
}


struct Legues:Decodable
{
    var countrys:[Country]
}

struct Country:Decodable
{
    var idLeague: String
    var strSport: String
    var strYoutube:String
    var strBadge:String
    var strLeague:String
//    init() {
//        idLeague = ""
//        strSport = ""
//        strYoutube = ""
//        strBadge = ""
//        strLeague = ""
//    }
}




