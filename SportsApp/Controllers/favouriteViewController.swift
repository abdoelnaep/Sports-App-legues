//
//  favouriteViewController.swift
//  SportsApp
//
//  Created by Abdullah on 03/03/2022.
//

import UIKit

class favouriteViewController: UIViewController {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    @IBOutlet var favoriteTabelView: UITableView!
    
    var favLeague: [FavouriteLeagues] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            self.fetchData()
            self.favoriteTabelView.reloadData()
        }
    }
    
    func fetchData() {
        do {
            favLeague = try context.fetch(FavouriteLeagues.fetchRequest())
            DispatchQueue.main.async {
                self.favoriteTabelView.reloadData()
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}

extension favouriteViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favLeague.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let leagueDetailsVC = storyboard?.instantiateViewController(withIdentifier: "LeagueDetailsViewController") as? LeagueDetailsViewController {
            leagueDetailsVC.leageName = favLeague[indexPath.row].strLeague
            leagueDetailsVC.leageID = favLeague[indexPath.row].idLeague
            leagueDetailsVC.leageYoutube = favLeague[indexPath.row].strYoutube
            leagueDetailsVC.legueBadge = favLeague[indexPath.row].strBadge
            leagueDetailsVC.fromFacvScreenFlag = true
            navigationController?.pushViewController(leagueDetailsVC, animated: true)
        }
    }
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "favTableViewCell", for: indexPath) as? favTableViewCell {
            let sport = favLeague[indexPath.row]
            cell.favTableViewILabel.text = sport.strLeague
            
            cell.favTableViewImage.fetchImageFromUrl(sport.strBadge!)

            cell.gotoYoutube = {
                //  let link = sport.strYoutube != "" ? ("https://\(sport.strYoutube)") : "https://www.google.com"
                if sport.strYoutube != "" {
                    let url = URL(string: "https://\(String(describing: sport.strYoutube!))")
                    UIApplication.shared.open(url!)

                } else {
                    Toast.showToast(controller: self, message: "No link found", seconds: 1)
                }
            }

            cell.favTableViewImage.layer.borderWidth = 1
            cell.favTableViewImage.layer.borderColor = UIColor.red.cgColor
            cell.favTableViewImage.layer.cornerRadius = cell.favTableViewImage.frame.height / 3
            cell.favTableViewImage.clipsToBounds = true
            return cell
        }

        //   cell.thumbImageView.sd_setImage(with: URL(string: sport.strSportThumb), completed: nil)

        return UITableViewCell()
    }
        
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(90)
    }
}
