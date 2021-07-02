//
//  TestView.swift
//  Learning App
//
//  Created by Antonio Gormley on 02/07/2021.
//

import SwiftUI

struct TestView: View {
    @EnvironmentObject var model:ContentModel
    @State var selectedAnswerIndex:Int?
    @State var numCorrect = 0
    @State var submitted = false
    var body: some View {
        
        if model.currentQuestion != nil {
            VStack (alignment: .leading) {
                //q number
                Text("Question \(model.currentQuestionIndex + 1) of \(model.currentModule?.test.questions.count ?? 0 )")
                    .padding(.leading,20)
                //q
                CodeTextView().padding(.horizontal, 20)
                
                //answers
                ScrollView {
                    VStack {
                        ForEach (0..<model.currentQuestion!.answers.count, id: \.self) { index in
                            
                            Button(action: {
                                selectedAnswerIndex = index
                                
                            }, label: {
                                ZStack {
                                    if submitted == false {
                                        RectangleCard(color: index == selectedAnswerIndex ? .gray : .white)
                                            .frame(height: 48)
                                    }else{
                                        //answer submitted
                                        if index == selectedAnswerIndex && index == model.currentQuestion!.correctIndex {
                                            RectangleCard(color: .green)
                                                .frame(height: 48)
                                        }
                                        else if index == selectedAnswerIndex && index  != model.currentQuestion!.correctIndex{
                                            
                                            RectangleCard(color: .red)
                                                .frame(height: 48)
                                        }
                                        else if index == model.currentQuestion!.correctIndex{
                                            
                                            RectangleCard(color: .green)
                                                .frame(height: 48)
                                    }
                                        else {
                                            RectangleCard(color: .white)
                                                .frame(height: 48)
                                        }
                                
                                }
                                    Text(model.currentQuestion!.answers[index])

                                }

                            })
                                .disabled(submitted)
                            
                            
                        }
                    }.padding().accentColor(.black)
                }
                
                //submit button
                Button(action: {
                    
                    if submitted == true {
                        //already been submitted
                        model.nextQuestion()
                        submitted = false
                        selectedAnswerIndex = nil
                    }else{
                        //submit the answer
                        submitted = true
                        
                        //check answer and increment the counter if correct
                        if selectedAnswerIndex == model.currentQuestion?.correctIndex {
                            numCorrect += 1
                    }

                    }
                    
                }, label: {
                    ZStack {
                        RectangleCard(color: .green)
                            .frame(height: 48)
                        
                        Text(buttonText)
                            .bold()
                            .foregroundColor(.white)
                            
                    }.padding()

                }).disabled(selectedAnswerIndex == nil)
            }
            .navigationBarTitle("\(model.currentModule?.category ?? "") Test")
            
            }
            else{
            ProgressView()
        }
        
        
    }
    
    var buttonText:String {
        if submitted == true {
            if model.currentQuestionIndex + 1 == model.currentModule!.test.questions.count{
                return "Finish"
            }else{
            return "Next"
            }
        }else{
            return "Submit"
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
