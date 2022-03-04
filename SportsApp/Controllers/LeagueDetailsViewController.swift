//
//  LeagueDetailsViewController.swift
//  SportsApp
//
//  Created by Abdullah on 01/03/2022.
//

import UIKit

class LeagueDetailsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var favLeague: [FavouriteLeagues] = []
    var favlegueFlag: Bool = false
    var fromFacvScreenFlag: Bool = false

    var leageName: String?
    var leageID: String?
    var leageYoutube: String?
    var legueBadge: String?

    var teamsarray: [TeamElement] = []
    var latestResultsArray: [EventElement] = []
    var upComingEventsArray: [comingEventElement] = []

    @IBOutlet var favoriteButton: UIButton!
    @IBOutlet var eventsCollectionView: UICollectionView!

    @IBOutlet var latestResultsCollectionView: UICollectionView!

    @IBOutlet var teamCollectionView_Abdallah: UICollectionView!

    //    var eventsArray:[Event]?
    // teamsCollectionView
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Leagues Details"

        UrlSessionForTeams()
        UrlSessionForEventsResult()
        UrlSessionForUpcomingEvents()
        fetchData()
        isFovorite()

        configureCollectionView()
        configureCollectionViewResult()
//        print(leageName!)
//        print(teamsarray.count)

        eventsCollectionView.delegate = self
        eventsCollectionView.dataSource = self
//
        latestResultsCollectionView.delegate = self
        latestResultsCollectionView.dataSource = self

        teamCollectionView_Abdallah.delegate = self
        teamCollectionView_Abdallah.dataSource = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if fromFacvScreenFlag == true {
            tabBarController?.tabBar.isHidden = true
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }

    @IBAction func addFavPressed(_ sender: Any) {
        fetchData()

        if favlegueFlag == true { // set false
            for i in stride(from: 0, through: favLeague.count - 1, by: 1) {
                if leageID == favLeague[i].idLeague {
                    favoriteButton.setImage(UIImage(systemName: "star"), for: .normal)
                    context.delete(favLeague[i])
                    try? context.save()
                    favlegueFlag = false
                }
            }

        } else { //  set true
            favoriteButton.setImage(UIImage(systemName: "star.fill"), for: .normal)

            favlegueFlag = true

            saveData()
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == teamCollectionView_Abdallah {
            return teamsarray.count

        } else if collectionView == latestResultsCollectionView {
            return latestResultsArray.count

        } else if collectionView == eventsCollectionView {
            return upComingEventsArray.count

        } else {
            return 1
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == teamCollectionView_Abdallah {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TeamCollectionViewCell", for: indexPath) as! TeamCollectionViewCell

            let team = teamsarray[indexPath.row]

            cell.teamImageView.fetchImageFromUrl(team.strTeamBadge!)

            return cell

        } else if collectionView == latestResultsCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ResCell", for: indexPath) as! LeguesLastResultCollectionViewCell

            let result = latestResultsArray[indexPath.row]

            cell.thumbImage.fetchImageFromUrl(result.strThumb ?? "")
            cell.teamDate.text = result.dateEvent
            cell.teamName.text = result.strEvent
            cell.teamTime.text = result.strTime
            cell.teamScore.text = "\(result.intHomeScore ?? "_") Vs \(result.intAwayScore ?? "_")"
            cell.backgroundColor = UIColor.blue
            return cell
        } else if collectionView == eventsCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ComingEventsCell", for: indexPath) as! CommingEventsCollectionViewCell

            let result = upComingEventsArray[indexPath.row]

            cell.comEventImage.fetchImageFromUrl(result.strThumb ?? "")
            cell.comEventIDate.text = result.dateEvent
            cell.comEventIName.text = result.strEvent
            cell.comEventITime.text = result.strTime

            return cell
        }

        return UICollectionViewCell()
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == teamCollectionView_Abdallah {
            // print(teamsarray[indexPath.row].idTeam)

            if let teamDetailsVC = storyboard?.instantiateViewController(withIdentifier: "TeamDetailsViewController") as? TeamDetailsViewController {
                teamDetailsVC.targetTeam = teamsarray[indexPath.row]

                navigationController?.pushViewController(teamDetailsVC, animated: true)
            }
        }
    }

    func configureCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        layout.sectionInset = UIEdgeInsets(top: 0, left: 1, bottom: 0, right: 1)

        let size = (view.frame.size.width - 4) / 3
        layout.itemSize = CGSize(width: size, height: size)

        teamCollectionView_Abdallah.collectionViewLayout = layout
    }

    func configureCollectionViewResult() {
        let layout = UICollectionViewFlowLayout()

        layout.minimumInteritemSpacing = 0

        let size = (view.frame.size.width)
        layout.itemSize = CGSize(width: size - 5, height: size - 140)

        latestResultsCollectionView.collectionViewLayout = layout
    }

    func UrlSessionForTeams() {
        leageName = leageName!.replacingOccurrences(of: " ", with: "%20")

        guard let url = URL(string: Constants.search_all_teams + leageName!) else { return } // 1
//        print("teams link")
//        print(url)

        //   guard let url = URL(string: "https://www.thesportsdb.com/api/v1/json/2/searchfilename.php?e=\(String(describing: leagueName!))")
        let req = URLRequest(url: url)
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let task = session.dataTask(with: req) { data, _, _ in

            do {
                let someStructArray = try JSONDecoder().decode(TeamModel.self, from: data!)
                self.teamsarray = someStructArray.teams
                //    print(self.teamsarray.count)

                DispatchQueue.main.async {
                    self.teamCollectionView_Abdallah.reloadData()
                }

            } catch {
                print("error teamsarray")
                // print(error)
            }
        }
        task.resume()
    }

    func UrlSessionForEventsResult() {
//        let newsportName = stringReplace(param: sportName!)
//        print(newsportName)

        leageName = leageName!.replacingOccurrences(of: " ", with: "%20")
        guard let url = URL(string: Constants.urlSub + leageID!) else { return } // 1 // 1
//        print("events result link")
//        print(url)
        let req = URLRequest(url: url)
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let task = session.dataTask(with: req) { data, _, _ in

            do {
                let someStructArray = try JSONDecoder().decode(EventModel.self, from: data!)
                self.latestResultsArray = someStructArray.events
//                print("latestResultsArray")
//                print(self.latestResultsArray.count)

                DispatchQueue.main.async {
                    self.latestResultsCollectionView.reloadData()
                }

            } catch {
//                print("error latestResultsArray")
                print(error.localizedDescription)
            }
        }
        task.resume()
    }

    func UrlSessionForUpcomingEvents() {
        leageName = leageName!.replacingOccurrences(of: " ", with: "%20")
        guard let url = URL(string: Constants.upCommingEvents + leageName!) else { return } // 1
        let req = URLRequest(url: url)
//        print("upcoming link")
//        print(url)
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let task = session.dataTask(with: req) { data, _, _ in

            do {
                let someStructArray = try JSONDecoder().decode(comingEventModel.self, from: data!)
                self.upComingEventsArray = someStructArray.event
//                print("UpcomingEvents")
//                print(self.upComingEventsArray.count)

                DispatchQueue.main.async {
                    self.eventsCollectionView.reloadData()
                }

            } catch {
//                print("error upComingEvents")
                print(error.localizedDescription)
            }
        }
        task.resume()
    }

    func saveData() {
        let savedLeague = FavouriteLeagues(context: context)
        let leagueName = leageName?.replacingOccurrences(of: "%20", with: " ")
        savedLeague.strLeague = leagueName

        savedLeague.idLeague = leageID
        savedLeague.strYoutube = leageYoutube
        savedLeague.strBadge = legueBadge

        try? context.save()
    }

    func isFovorite() {
        for i in stride(from: 0, through: favLeague.count - 1, by: 1) {
            if leageID == favLeague[i].idLeague {
                favoriteButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
                favlegueFlag = true
            }
        }
    }

    func fetchData() {
        do {
            favLeague = try context.fetch(FavouriteLeagues.fetchRequest())
        } catch {
            print(error.localizedDescription)
        }
    }
}
