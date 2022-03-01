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

        //   print(sportName!)
        UrlSession()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leguesarray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "LegueTableViewCell", for: indexPath) as? LegueTableViewCell {
            let sport = leguesarray[indexPath.row]
            cell.legueName.text = sport.strLeague
//            cell.legueImage.sd_setImage(with: URL(string: sport.strBadge), completed: nil)
            cell.legueImage.fetchImageFromUrl(sport.strBadge)

            // print(sport.strYoutube!)
            cell.gotoYoutube = {
                //  let link = sport.strYoutube != "" ? ("https://\(sport.strYoutube)") : "https://www.google.com"
                if sport.strYoutube != "" {
                    print("cool")
                    let url = URL(string: "https://\(sport.strYoutube)")
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

        //   cell.thumbImageView.sd_setImage(with: URL(string: sport.strSportThumb), completed: nil)

        return UITableViewCell()
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(90)
    }

    func stringReplace(param: String) -> (String) {
        var newarr = ""
//        var char: Character
        for char in param {
            if char == " " {
                newarr.append("%20")

            } else {
                newarr.append(char)
            }
        }
        return newarr
    }

    func UrlSession() {
        let newsportName = stringReplace(param: sportName!)
        print(newsportName)
        let url = URL(string: Constants.BASE_URL_LEAGUES + newsportName) // 1
        let req = URLRequest(url: url!)
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let task = session.dataTask(with: req) { data, _, _ in

            do {
                let someStructArray = try JSONDecoder().decode(Legues.self, from: data!)
                self.leguesarray = someStructArray.countrys
                //     print(self.leguesarray.count)

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