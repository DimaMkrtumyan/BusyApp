//
//  HomePageViewModel.swift
//  Busy
//
//  Created by Davit Muradyan on 01.01.22.
//

import Foundation

class HomePageViewModel {
    let networkManager = NetworkManager()
    var stories = [Story]()
    var sections = [RestuarantSection]()
    var cafes = [RestuarantOption]()
    var fastFood = [RestuarantOption]()
    var restuarants = [RestuarantOption]()
    var searchResults = [SearchedData]()
    
    var activeOrderCount = Int()
    
    func getMainPageData(completion: @escaping(Result<MainPageResponse, NetworkError>) -> ()) {
        networkManager.setupRequest(path: .mainPageData, method: .get, body: nil, params: nil, header: .application_json) { [self] result in
            switch result {
            case .success(let data):
                do {
                    let homePageData = try JSONDecoder().decode(MainPageResponse.self, from: data)
                    stories.append(contentsOf: homePageData.model.networkAds)
                    sections.append(contentsOf: homePageData.model.networksSorted)
                    self.activeOrderCount = homePageData.model.activeOrderCount
                    
                    homePageData.model.networksSorted.forEach { section in
                        switch section.type {
                        case 0:
                            cafes.append(contentsOf: section.networks)
                        case 1:
                            fastFood.append(contentsOf: section.networks)
                        case 2:
                            restuarants.append(contentsOf: section.networks)
                        default:
                            break
                        }
                    }
                    completion(.success(homePageData))
                } catch {
                    completion(.failure(.serverError))
                }
            case .failure(_):
                completion(.failure(.serverError))
            }
        }
    }
    
    func search(text: String, completion: @escaping(Result<Void, NetworkError>) -> ()) {
        networkManager.setupRequest(path: .seachHomePageData, method: .get, body: nil, params: ["searchText": text], header: .application_json) { result in
            switch result {
            case .success(let data):
                do {
                    let searchedData = try JSONDecoder().decode(SearchedRestuarants.self, from: data)
                    self.searchResults = searchedData.models
                    completion(.success(Void()))
                } catch {
                    completion(.failure(.serverError))
                }
            case .failure(_):
                completion(.failure(.serverError))
            }
        }
    }
}
