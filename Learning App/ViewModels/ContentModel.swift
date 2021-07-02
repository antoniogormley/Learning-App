//
//  ContentModel.swift
//  Learning App
//
//  Created by Antonio Gormley on 29/06/2021.
//

import Foundation

class ContentModel: ObservableObject{
    
    //List of modules
    @Published var modules = [Module]()
    //Current module
    @Published var currentModule: Module?
    var currentModuleIndex = 0
    
    //current lesson
    @Published var currentLesson: Lesson?
    var currentLessonIndex = 0
    
    //current lesson explaination
    @Published var lessonDescription = NSAttributedString()
    
    
    var styleData: Data?
    
    //current selected content and test
    @Published var currentContentSelected:Int?

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
    
    
    func beginModule(moduleid:Int) {
       
        //find index for current module id
        for index in 0..<modules.count {
            if modules[index].id == moduleid {
                currentModuleIndex = index
                break
            }
        }
        //set cuurent module
        currentModule = modules[currentModuleIndex]
        
        
    }
    func beginLesson (lessonIndex:Int) {
        if lessonIndex < currentModule!.content.lessons.count {
            currentLessonIndex = lessonIndex
        }else{
            currentLessonIndex = 0
            
        }
        
        currentLesson = currentModule!.content.lessons[currentLessonIndex]
        lessonDescription = addStyling(htmlString: currentLesson!.explanation)
    }
    
    func  nextLesson() {
        //advance lesson
        currentLessonIndex += 1
        //check it is in range
        if currentLessonIndex < currentModule!.content.lessons.count{
            //set current lesson properity
            currentLesson = currentModule!.content.lessons[currentLessonIndex]
            lessonDescription = addStyling(htmlString: currentLesson!.explanation)

            
        }else{
            //rest lesson state
            currentLessonIndex = 0
            currentLesson = nil
        }
        
    }
    
    
    func hasNextLesson() -> Bool {
        if currentLessonIndex + 1 < currentModule!.content.lessons.count {
            return true
        }else {
            return  false
        }
    }
    private func addStyling(htmlString: String) -> NSAttributedString {
        var resultString = NSAttributedString()
        var data = Data()
        if styleData != nil {
        data.append(self.styleData!)
        }
        
        data.append(Data(htmlString.utf8))
        
        do {
            let attributedString = try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil)
                resultString = attributedString
            
        } catch  {
            print("Couldnt turn html into attributed string")
        }
        
        return resultString
    }
    
}
