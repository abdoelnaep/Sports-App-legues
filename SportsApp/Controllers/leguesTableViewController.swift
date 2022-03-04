//
//  leguesTableViewController.swift
//  SportsApp
//
//  Created by Abdullah on 28/02/2022.
//

import UIKit

class leguesTableViewController: UITableViewController {
    var sportName: String?

    @IBOutlet var legueTableView: UITableView!
    var leguesarray: [Country] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Leagues"

        //   print(sportName!)
        UrlSession()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let leagueDetailsVC = storyboard?.instantiateViewController(withIdentifier: "LeagueDetailsViewController") as? LeagueDetailsViewController {
            leagueDetailsVC.leageName = leguesarray[indexPath.row].strLeague
            leagueDetailsVC.leageID = leguesarray[indexPath.row].idLeague
            leagueDetailsVC.leageYoutube = leguesarray[indexPath.row].strYoutube
            leagueDetailsVC.legueBadge = leguesarray[indexPath.row].strBadge

            navigationController?.pushViewController(leagueDetailsVC, animated: true)
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leguesarray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "LegueTableViewCell", for: indexPath) as? LegueTableViewCell {
            let sport = leguesarray[indexPath.row]
            cell.legueName.text = sport.strLeague

//            cell.legueImage.sd_setImage(with: URL(string: sport.strBadge), completed: nil)
            cell.legueImage.fetchImageFromUrl(sport.strBadge!)

            // print(sport.strYoutube!)
            cell.gotoYoutube = {
                //  let link = sport.strYoutube != "" ? ("https://\(sport.strYoutube)") : "https://www.google.com"
                if sport.strYoutube != "" {
                    print("cool")
                    let url = URL(string: "https://\(String(describing: sport.strYoutube!))")
                    UIApplication.shared.open(url!)

                } else {
                    Toast.showToast(controller: self, message: "No link found", seconds: 1)
                }
            }

            cell.legueImage.layer.borderWidth = 1
            cell.legueImage.layer.borderColor = UIColor.red.cgColor
            cell.legueImage.layer.cornerRadius = cell.legueImage.frame.height / 3
            cell.legueImage.clipsToBounds = true
            return cell
        }

        return UITableViewCell()
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(90)
    }

    func UrlSession() {
        sportName = sportName!.replacingOccurrences(of: " ", with: "%20")

        let url = URL(string: Constants.BASE_URL_LEAGUES + sportName!) // 1
        print(url!)
        let req = URLRequest(url: url!)
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let task = session.dataTask(with: req) { data, _, _ in

            do {
                let someStructArray = try JSONDecoder().decode(Legues.self, from: data!)
                self.leguesarray = someStructArray.countrys
                print(self.leguesarray.count)

                DispatchQueue.main.async {
                    self.legueTableView.reloadData()
                }

            } catch {
                print("error")
            }
        }
        task.resume()
    }
}
