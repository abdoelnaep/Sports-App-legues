

import Foundation

struct Sport: Codable
{
    let sports: [SportElement]
}

struct SportElement: Codable
{
    let idSport: String?
    let strSport: String?
    let strFormat: String?
    let strSportThumb: String?
    let strSportIconGreen: String?
    let strSportDescription: String?
}

struct Legues: Codable
{
    var countrys: [Country]
}

struct Country: Codable
{
    var idLeague: String?
    var strSport: String?
    var strYoutube: String?
    var strBadge: String?
    var strLeague: String?
}

struct TeamModel: Codable
{
    var teams: [TeamElement]
}

struct TeamElement: Codable
{
    // var TEAMS: String
    var idTeam: String?
    var strTeam: String?
    var strTeamBadge: String?
    var   strCountry: String?
    var  intFormedYear: String?
    var  strStadium: String?
    var  strStadiumThumb: String?
   // var  strStadiumLocation: String?
    var strFacebook: String?
    var strYoutube: String?
   var strTeamJersey: String?
    var strWebsite: String?
    
    
    
    
}

struct EventModel: Codable
{
    var events: [EventElement]
}

struct EventElement: Codable
{
    var idEvent: String?
    var strEvent: String?
    var dateEvent: String?
    var strTime: String?
    var strThumb: String?
    var intHomeScore: String?
    var intAwayScore: String?
    var strHomeTeam: String?
    var strAwayTeam: String?
}

struct comingEventModel: Codable
{
    var event: [comingEventElement]
}

struct comingEventElement: Codable
{
    var idEvent: String?
    var strEvent: String?
    var dateEvent: String?
    var strTime: String?
    var strThumb : String?
//    var strHomeTeam : String
//    var strAwayTeam : String
}
