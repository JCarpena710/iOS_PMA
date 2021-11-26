//
//  ExplreViewController.swift
//  semana7
//
//  Created by MAC07 on 23/11/21.
//

import UIKit
import SkeletonView

class ExploreViewController: UIViewController, SkeletonTableViewDataSource{
    
    @IBOutlet weak var tableView: UITableView!
    
    let placeViewModel = PlaceViewModel()
        
    var name: String? = nil
    var address: String? = nil
    var rating: String? = nil
    var useRatingTotal: String? = nil
    var photo: String? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        bind()
        setUpTable()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // tableView.isSkeletonable = true
        // tableView.showSkeleton(usingColor: .concrete, transition: .crossDissolve(0.25))
    }
    
    func setUpTable() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func configure() {
        placeViewModel.getPlaces()
    }
    
    func bind() {
        placeViewModel.refreshData = { [weak self] () in
            DispatchQueue.main.async {
                // self?.tableView.stopSkeletonAnimation()
                // self?.view.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.25))
                self?.tableView.reloadData()
            }
        }
    }
     


}

extension ExploreViewController: UITableViewDelegate, UITableViewDataSource {
    
    func collectionSkeletonView(_ skeletonView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return placeViewModel.arrayResults.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return placeViewModel.arrayResults.count
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
       return "cellExplore"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellExplore", for: indexPath) as! ExploreTableViewCell

        let object = placeViewModel.arrayResults[indexPath.row]
        
        cell.lblTitle.text = object.name
        cell.lblAddress.text = object.address
       
        cell.lblPrice.text = "$141.00 / night"
        cell.lblRating.text = String(object.rating)
        cell.lblCountRating.text = "( \(object.userRatingsTotal))"
        
        setUpImage(photo: object.photo, image: cell.exploreImage)
         
        let cellView = UIView()
        cellView.backgroundColor = UIColor.systemBackground
        cell.selectedBackgroundView = cellView
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let object = placeViewModel.arrayResults[indexPath.row]
        
        self.name = object.name
        self.address = object.address
        self.photo = object.photo
        self.rating = String(object.rating)
        self.useRatingTotal = "(\(object.userRatingsTotal)) Reviews"
        
        
        performSegue(withIdentifier: "exploreDetail", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "exploreDetail" {
            if let nextVC = segue.destination as? ExploreDetailViewController {
                nextVC.name = self.name
                nextVC.address = self.address
                nextVC.rating = self.rating
                nextVC.useRatingTotal = self.useRatingTotal
                nextVC.photo = self.photo
            }
        }
    }
    
    

}
