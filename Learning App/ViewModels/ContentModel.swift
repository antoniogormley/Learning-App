//
//  ContentModel.swift
//  Learning App
//
//  Created by Antonio Gormley on 29/06/2021.
//

import Foundation

class ContentModel: ObservableObject{
    
    @Published var modules = [Module]()
    @Published var styleData: Data?

    init() {
        
        getLocalData()
    }
    
    func getLocalData () {
        //get a url to json
        let jsonUrl = Bundle.main.url(forResource: "data", withExtension: "json")
        //Read the file into a data object
        do {
            let jsonData = try Data(contentsOf: jsonUrl!)
            //Try to decode the json an array of modules

            let jsonDecoder = JSONDecoder()
            let modules = try jsonDecoder.decode([Module].self, from: jsonData)
            
            //asign parsed modules to modules property
            self.modules = modules
        }
        catch{
            print("Couldn't parse local data")
        }
        let styleUrl = Bundle.main.url(forResource: "style", withExtension: "html")
        
        do {
            let styleData = try Data(contentsOf: styleUrl!)
            self.styleData = styleData
        }catch{
            print("Couldn't parse style data")
        }
            
    }
}
