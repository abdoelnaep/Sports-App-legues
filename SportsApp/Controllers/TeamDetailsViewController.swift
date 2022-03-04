//
//  TeamDetailsViewController.swift
//  SportsApp
//
//  Created by Abdullah on 03/03/2022.
//

import UIKit

class TeamDetailsViewController: UIViewController {
    var targetTeam = TeamElement()
    
    @IBOutlet weak var teamBadge: UIImageView!
    @IBOutlet weak var teamShirt: UIImageView!
    @IBOutlet weak var stadiumImage: UIImageView!

    
    @IBOutlet weak var teamCountry: UILabel!
    @IBOutlet weak var teamStablishDate: UILabel!
    
    @IBOutlet weak var stadiumName: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Team Details"


        teamBadge.fetchImageFromUrl(targetTeam.strTeamBadge ?? "")
        stadiumImage.fetchImageFromUrl(targetTeam.strStadiumThumb ?? "")
        teamShirt.fetchImageFromUrl(targetTeam.strTeamJersey ?? "")
        teamCountry.text = targetTeam.strCountry
        teamStablishDate.text = "Since \(targetTeam.intFormedYear ?? "")"
        stadiumName.text = targetTeam.strStadium
//        var idTeam: String?
//        var strTeam: String?
//        var strTeamBadge: String?
//        var   strCountry: String?
//        var  intFormedYear: String?
//        var  strStadium: String?
//        var  strStadiumThumb: String?
//        var  strStadiumLocation: String?
//        var strFacebook: String?
//        var strYoutube: String?
    }
    


    @IBAction func youtube(_ sender: Any) {
        if targetTeam.strYoutube != "" {
            print("cool")
            let url = URL(string: "https://\(String(describing: targetTeam.strYoutube!))")
            print(url!)
            UIApplication.shared.open(url!)

        } else {
            Toast.showToast(controller: self, message: "No link found", seconds: 1)
        }
        
    }
    @IBAction func facebook(_ sender: Any) {
        
        if targetTeam.strFacebook != "" {
            print("cool")
            let url = URL(string: "https://\(String(describing: targetTeam.strFacebook!))")
            print(url!)

            UIApplication.shared.open(url!)

        } else {
            Toast.showToast(controller: self, message: "No link found", seconds: 1)
        }
    }
    
    @IBAction func officialWebsite(_ sender: Any) {
        if targetTeam.strWebsite != "" {
            print("cool")
            let url = URL(string: "https://\(String(describing: targetTeam.strWebsite!))")
            print(url!)

            UIApplication.shared.open(url!)

        } else {
            Toast.showToast(controller: self, message: "No link found", seconds: 1)
        }
        
    }
    
}
