
import UIKit
// import SDWebImage

class SportViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet var collectionView: UICollectionView!
    var sportsarray: [SportElement] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Sports"

        collectionView.delegate = self
        collectionView.dataSource = self
        
        UrlSession()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sportsarray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SportCollectionViewCell
        
        let sport = sportsarray[indexPath.row]
        cell.titleLable.text = sport.strSport
        cell.thumbImageView.fetchImageFromUrl(sport.strSportThumb!)

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var width = self.collectionView.frame.width / 2
        var height = 150
        
        if width > 1100 {
            width = width / 4.0
        } else if width > 500 {
            width = width / 3.0
        }
        if self.collectionView.frame.height > 900 {
            height = height * (Int(self.collectionView.frame.height) / 800)
        }
        return CGSize(width: Int(width) - 8, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let detailsVC = storyboard?.instantiateViewController(withIdentifier: "leguesTableViewController") as? leguesTableViewController {
            detailsVC.sportName = sportsarray[indexPath.row].strSport
        
            navigationController?.pushViewController(detailsVC, animated: true)
        }
    }
    
    func UrlSession() {
        let url = URL(string: Constants.BASE_URL_MAIN) // 1
        let req = URLRequest(url: url!)
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let task = session.dataTask(with: req) { data, _, _ in
            
            do {
                let someStructArray = try JSONDecoder().decode(Sport.self, from: data!)
                self.sportsarray = someStructArray.sports
                
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }

            } catch {
                print("error")
            }
        }
        task.resume()
    }
}
