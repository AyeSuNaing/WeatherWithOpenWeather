//
//  DatabaseAdapter.swift
//  WeatherwithOpenWeatherMap
//
//  Created by AyeSuNaing on 05/12/2023.
//

import Foundation
import RealmSwift
import Combine


class DatabaseAdapter {
    //singleton
    
    static let shared = DatabaseAdapter()
    private init(){
        do {
            let realmPath = try Realm().configuration.fileURL?.absoluteString ?? "undefined"
            print("Default Realm is at : \( realmPath )")
        } catch {
            
        }
    }
    
    func saveCurrentWeather (weather : CurrentWeatherResponseDBO){
        do {
            let realm = try Realm()
            if checkWeatherById(id: weather.id) {
                try realm.write({
                    realm.add(weather,update: .all)
                })
            }
        }catch {
            let error = error as NSError
            fatalError("Unresolved error : \(error) \(error.userInfo)")
        }
    }
    
    
    func getAllWeathers() -> AnyPublisher<[CurrentWeatherResponse], Error> {
        do {
            let realm = try Realm()
            let results = realm.objects(CurrentWeatherResponseDBO.self)

            let mappedResults = results.map { weather in
                weather.toCurrentWeatherResponse()
            }

            return Just(Array(mappedResults))
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        } catch {
            return Fail(error: error)
                .eraseToAnyPublisher()
        }
    }
    
    func checkWeatherById(id:Int) -> Bool{
        do{
            var result : Bool = false
            let realm = try Realm()
            let resultQuery = realm.object(ofType: CurrentWeatherResponseDBO.self, forPrimaryKey: id)
            if resultQuery == nil {
                result = true
            }
            return result
        }catch {
            let error = error as NSError
            fatalError("Unresolved error : \(error) \(error.userInfo)")
        }
    }
    
    
}

