//
//  PlaceViewModel.swift
//  semana7
//
//  Created by MAC07 on 23/11/21.
//

import Foundation

class PlaceViewModel {
    let urlAPI = "https://615ccfdcc29813001773631d.mockapi.io/api/v1/places"
    
    var refreshData = {
        () -> () in
    }
    
    var arrayResults: [Place] = [] {
        didSet {
            refreshData()
        }
    }
    
    func getPlaces() {
        guard let url = URL(string: urlAPI) else {return}
        
        URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            
            guard let dataJSON = data else {return}
            
            let decoder = JSONDecoder()
            
            do {
                self.arrayResults = try decoder.decode([Place].self, from: dataJSON)
                
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }.resume()
    }

    
}




















