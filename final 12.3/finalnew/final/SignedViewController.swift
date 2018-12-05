//
//  SignedViewController.swift
//  final
//
//  Created by James on 2018/11/30.
//  Copyright © 2018年 James. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class SignedViewController: BaseViewController {
    
    let gameInfo: [[String]] = [["Arena of Valor","Arena of Valor International Championship 2018","The Arena of Valor International Championship 2018 (AIC 2018) is the second Arena of Valor international tournament in 2018. This is a 4-week competition with the greatest teams from across the globe competing for a prize pool of $600,000 beginning November 23rd, 2018."]
        ,["PUBG","Get Ready for the 2019 Season of PUBG Esports","PUBG esports is about to get serious. Starting next year, we’re introducing official pro competitions in nine different regions around the globe. We’ll also be hosting numerous global events throughout the year, including the All-Star Games in August and the Global Championship in November where the #1 team of the season will be crowned."]
        ,["Hearthstone ","HEARTHSTONE ESPORTS’ NEXT BIG TURN","2018 was a great year for Hearthstone Esports. Earlier this month Team China upset tournament favorite Brazil in the Grand Finals of the Hearthstone Global Games at BlizzCon. We’ve crowned two seasonal champions at our Summer and Fall Championships. We’ve seen more than 200,000 players attend 25 Tour Stops and other major events across the globe. And by the end of the Year of the Raven we’ll have awarded more than $2.8 million in prize money—our largest amount ever."]
        ,["PUBG","PUBG Mobile Players Are Pretty Sure The Game Is Full Of Bots","PUBG Mobile released in North America yesterday, and it’s pretty awesome. But between my own string of victories and the countless chicken dinners on social media, it sure feels like things are too easy.\n\nPUBG Mobile is a robust iOS and Android port of the popular battle royale game that allows 100 players to fight to the death. The mobile version has a convenient interface that makes moving and shooting much more responsive than I expected. Numerous players starting up the game for the first time are kicking ass and coming in first place to earn a coveted \'chicken dinner.\' \n\nOn Twitter, players are marveling over their victories. \'Literally the first time that I played PUBG and the fact that I won in mobile version is even more hardcore,\' one person wrote. \'I’m a god at PUBG Mobile but crap at Fortnite,\' said another. This sentiment is common: \'First game of #PUBGmobile on the iPhone SE we come out with a big win.\', \'First #PUBGmobile Win! 9 kills. \', \'My very first match, first time ever playing PUBG and this was the outcome\'."]
        ,["Overwatch","NEWS! OVERWATCH FOR ANDROID 2018 IS AVAILABLE NOW!","Developed by the studio Blizzard shooting FPS network, representing the very first production of this species inside the achievements in the creators with the cult series including Diablo, Warcraft and Starcraft. Overwatch The action is scheduled in a future by which peace guard stands guards title organization, established decades ago to guard against attack by renegade robots. When torn by conflict group sets out to decline, the necessary taking over entirely new characters, represented by players. The game specializes in network-team duels, where instead of killing is rewarded perform certain tasks. Probably all gamers know this title – Overwatch. Today we’d like to make a review for you and share with you our converted version: Overwatch android apk and Overwatch PC.  We know that Overwatch mobile is what you want so we converted it for you! Of course you can also find Overwatch download for PC. So now, let’s read what’s new in the latest FPP game."]
    ]

    var filteredGameInfo: [[String]] = [[]]
    let searchController = UISearchController(searchResultsController: nil)
    
    let userDefaults = UserDefaults()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var emailtxt: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let email = Auth.auth().currentUser?.email else{return}
        emailtxt.text = email

        
        
        
        
        addSlideMenuButton()
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search by Game"
        searchController.hidesNavigationBarDuringPresentation = false
        //        navigationItem.searchController = searchController
        navigationItem.titleView = searchController.searchBar
        searchController.searchBar.delegate = self
        definesPresentationContext = true
        
        // Do any additional setup after loading the view.
    }
    
    
//    @IBAction func searchAction(_ sender: Any) {
//        var mc = storyboard?.instantiateViewController(withIdentifier: "MatchViewController") as? MatchViewController
//
//        self.navigationController?.pushViewController(mc!, animated: true)
//
//    }
//    @IBAction func profileaction(_ sender: Any) {
//
//        var pvc = storyboard?.instantiateViewController(withIdentifier: "ProfileViewController") as? ProfileViewController
//       pvc?.useremail = emailtxt.text!
//        self.navigationController?.pushViewController(pvc!, animated: true)
//    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}



extension SignedViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath as IndexPath) as! TableViewCell
        //                        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath as IndexPath)
        
        let game: [String]
        if self.searchController.isActive {
            game = filteredGameInfo[indexPath.row]
        } else {
            game = gameInfo[indexPath.row]
        }
        
//        let game = gameInfo[indexPath.row]
        cell.label.text = game[0]
        cell.img.image = UIImage(named: game[0])
        cell.label4.text = game[1]
        cell.label2.text = game[2]
        return cell
    }
    
    
    
    /* click action */
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//        let vehicle = vehicles[indexPath.row]
//        let dateformatter = DateFormatter()
//        dateformatter.dateFormat = "yyyy"
//        let year = dateformatter.string(from: vehicle.value(forKeyPath: "year") as! Date)
        
        
        var dc = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController

        let game: [String]
        if self.searchController.isActive {
            game = filteredGameInfo[indexPath.row]
        } else {
            game = gameInfo[indexPath.row]
        }
    
        dc?.txt1 = game[0]
        dc?.txt2 = game[1]
        dc?.txt3 = game[2]
        dc?.image = UIImage(named: game[0])


        self.navigationController?.pushViewController(dc!, animated: true)

    }
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if self.searchController.isActive {
            return filteredGameInfo.count
        }
        return gameInfo.count
        
    }
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if (editingStyle == .delete) {
//
//
//
//            let vehicle = vehicles[indexPath.row]
//            guard let deleteObject = getVehicle(id: String((vehicle.value(forKey: "id") as? Int)!)) else{ print("deleteObject not found");return}
//            print(deleteObject)
//            getContext().delete(deleteObject)
//
//            vehicles.remove(at: indexPath.row)
//            self.tableView.deleteRows(at: [indexPath], with: .fade)
//            save()
//            //            myTableView.reloadData()
//            // handle delete (by removing the data from your array and updating the tableview)
//        }
    }
    
    //    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    //        return 100
    //    }
    
    
    
    
    
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
}

extension SignedViewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filteredGameInfo = gameInfo.filter({( v : [String]) -> Bool in
            return v[0].lowercased().contains(searchText.lowercased())
        })
        
        tableView.reloadData()
    }
}

extension SignedViewController: UISearchBarDelegate {

}
