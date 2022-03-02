//
//  LeagueDetailsViewController.swift
//  SportsApp
//
//  Created by Abdullah on 01/03/2022.
//

import UIKit

class LeagueDetailsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    var leageName: String?
    var leageID: String?

    var teamsarray: [TeamElement] = []
    var latestResultsArray: [EventElement] = []
    var upComingEvents: [comingEventElement] = []

    //   @IBOutlet weak var eventsCollectionView: UICollectionView!

    @IBOutlet var latestResultsCollectionView: UICollectionView!

    @IBOutlet var teamsCollectionView: UICollectionView!
//    var eventsArray:[Event]?

    override func viewDidLoad() {
        super.viewDidLoad()
        UrlSessionForTeams()
        UrlSessionForEventsResult()
        UrlSessionForUpcomingEvents()

        
        configureCollectionView()
        configureCollectionViewResult()
//        print(leageName!)
//        print(teamsarray.count)

//        self.eventsCollectionView.delegate = self
//        self.eventsCollectionView.dataSource = self
//
        latestResultsCollectionView.delegate = self
        latestResultsCollectionView.dataSource = self

        teamsCollectionView.delegate = self
        teamsCollectionView.dataSource = self
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == teamsCollectionView {
            return teamsarray.count

        } else if collectionView == latestResultsCollectionView {
            return latestResultsArray.count
        } else {
            return 1
        }
//      } else if (collectionView == self.latestResultsCollectionView){
//           return  latestResultsArray?.count ?? 0
//        } else {
        //    return 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == teamsCollectionView {
            let cell = teamsCollectionView.dequeueReusableCell(withReuseIdentifier: "teamCell", for: indexPath) as! TeamCollectionViewCell

            let team = teamsarray[indexPath.row]

            cell.teamImage.fetchImageFromUrl(team.strTeamBadge!)

            return cell

        } else
        if collectionView == latestResultsCollectionView {
            let cell = latestResultsCollectionView.dequeueReusableCell(withReuseIdentifier: "ResCell", for: indexPath) as! LeguesLastResultCollectionViewCell

            let result = latestResultsArray[indexPath.row]

            cell.thumbImage.fetchImageFromUrl(result.strThumb ?? "")
            cell.teamDate.text = result.dateEvent
            cell.teamName.text = result.strEvent
            cell.teamTime.text = result.strTime
            cell.teamScore.text = "\(result.intHomeScore ?? "_") Vs \(result.intAwayScore ?? "_")"
            cell.backgroundColor = UIColor.blue
            return cell
        }

        return UICollectionViewCell()
    }

    func configureCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        layout.sectionInset = UIEdgeInsets(top: 0, left: 1, bottom: 0, right: 1)

        let size = (view.frame.size.width - 4) / 3
        layout.itemSize = CGSize(width: size, height: size)

        teamsCollectionView.collectionViewLayout = layout
    }

    func configureCollectionViewResult() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)

        let size = (view.frame.size.width)
        layout.itemSize = CGSize(width: size, height: size)

        latestResultsCollectionView.collectionViewLayout = layout
    }

    func UrlSessionForTeams() {
        leageName = leageName!.replacingOccurrences(of: " ", with: "%20")

       guard let url = URL(string: Constants.search_all_teams + leageName!)  else {return}// 1
        print("teams link")
        print(url)
        
        
     //   guard let url = URL(string: "https://www.thesportsdb.com/api/v1/json/2/searchfilename.php?e=\(String(describing: leagueName!))")
        let req = URLRequest(url: url)
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let task = session.dataTask(with: req) { data, _, _ in

            do {
                let someStructArray = try JSONDecoder().decode(TeamModel.self, from: data!)
                self.teamsarray = someStructArray.teams
                //    print(self.teamsarray.count)

                DispatchQueue.main.async {
                    self.teamsCollectionView.reloadData()
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
       guard let url = URL(string: Constants.urlSub + leageID!) else {return}// 1 // 1
        print("events result link")
        print(url)
        let req = URLRequest(url: url)
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let task = session.dataTask(with: req) { data, _, _ in

            do {
                let someStructArray = try JSONDecoder().decode(EventModel.self, from: data!)
                self.latestResultsArray = someStructArray.events
                print("latestResultsArray")
                print(self.latestResultsArray.count)

                DispatchQueue.main.async {
                    self.latestResultsCollectionView.reloadData()
                }

            } catch {
                print("error latestResultsArray")
                print(error)
            }
        }
        task.resume()
    }
    
    
    func UrlSessionForUpcomingEvents() {


        leageName = leageName!.replacingOccurrences(of: " ", with: "%20")
        guard  let url = URL(string: Constants.upCommingEvents + leageName!) else {return}// 1
        let req = URLRequest(url: url)
        print("upcoming link")
        print(url)
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let task = session.dataTask(with: req) { data, _, _ in

            do {
                let someStructArray = try JSONDecoder().decode(comingEventModel.self, from: data!)
                self.upComingEvents = someStructArray.event
                print("UpcomingEvents")
                print(self.upComingEvents.count)

//                DispatchQueue.main.async {
//                    self.latestResultsCollectionView.reloadData()
//                }

            } catch {
                print("error upComingEvents")
                print(error)
            }
        }
        task.resume()
    }
    
    
}
