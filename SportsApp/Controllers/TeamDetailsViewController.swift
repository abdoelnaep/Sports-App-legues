//
//  TeamDetailsViewController.swift
//  SportsApp
//
//  Created by Abdullah on 03/03/2022.
//

import UIKit

class TeamDetailsViewController: UIViewController {
    var targetTeam = TeamElement()

    @IBOutlet var teamBadge: UIImageView!
    @IBOutlet var teamShirt: UIImageView!
    @IBOutlet var stadiumImage: UIImageView!

    @IBOutlet var teamCountry: UILabel!
    @IBOutlet var teamStablishDate: UILabel!

    @IBOutlet var stadiumName: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Team Details"

        teamBadge.fetchImageFromUrl(targetTeam.strTeamBadge ?? "")
        stadiumImage.fetchImageFromUrl(targetTeam.strStadiumThumb ?? "")
        teamShirt.fetchImageFromUrl(targetTeam.strTeamJersey ?? "")
        teamCountry.text = targetTeam.strCountry
        teamStablishDate.text = "Since \(targetTeam.intFormedYear ?? "")"
        stadiumName.text = targetTeam.strStadium
    }

    @IBAction func youtube(_ sender: Any) {
        if targetTeam.strYoutube != "" {
//            print("cool")
            let url = URL(string: "https://\(String(describing: targetTeam.strYoutube!))")
//            print(url!)
            UIApplication.shared.open(url!)

        } else {
            Toast.showToast(controller: self, message: "No link found", seconds: 1)
        }
    }

    @IBAction func facebook(_ sender: Any) {
        if targetTeam.strFacebook != "" {
//            print("cool")
            let url = URL(string: "https://\(String(describing: targetTeam.strFacebook!))")
//            print(url!)

            UIApplication.shared.open(url!)

        } else {
            Toast.showToast(controller: self, message: "No link found", seconds: 1)
        }
    }

    @IBAction func officialWebsite(_ sender: Any) {
        if targetTeam.strWebsite != "" {
//            print("cool")
            let url = URL(string: "https://\(String(describing: targetTeam.strWebsite!))")
//            print(url!)

            UIApplication.shared.open(url!)

        } else {
            Toast.showToast(controller: self, message: "No link found", seconds: 1)
        }
    }
}
