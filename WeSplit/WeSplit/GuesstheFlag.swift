//
//  GuesstheFlag.swift
//  WeSplit
//
//  Created by Abirami Kalyan on 10/03/2023.
//

import SwiftUI

struct GuesstheFlagStudy: View {
    var body: some View {
        // Experimenting with Stacks
        
//        ZStack {
//            VStack(alignment: .leading, spacing: 20) {
//                Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
//                Text("I am abirami")
//                HStack {
//                    Spacer()
//                    Text("Hi I am horizontal")
//                    Text("Still name is abi")
//                    Spacer()
//                }
//                Spacer()
//            }
//          Text("Helooo")
//        }
        
        // Experimenting with colors
        
//        ZStack {
//            Color.secondary
//                //.frame(minWidth: 100, maxWidth: 250)
//            Text("Helo world")
//        }
        //.background(.blue)
//        .ignoresSafeArea()
        
        // Experimenting with effects
        
//        ZStack {
//            VStack(spacing: 0) {
//                Color.red
//                Color.blue
//            }
//
//            Text("Your content")
//                .foregroundColor(.secondary)
//                .foregroundStyle(.secondary)
//                .padding(50)
//                .background(.ultraThinMaterial)
//        }
        
        // Gradients
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.white, .black]), startPoint: .top, endPoint: .bottom)
            
            LinearGradient(gradient: Gradient(stops: [
                .init(color: .white, location: 0.45),
                .init(color: .black, location: 0.55),
            ]), startPoint: .top, endPoint: .bottom)
            
            RadialGradient(gradient: Gradient(colors: [.blue, .black]), center: .center, startRadius: 20, endRadius: 200)
            
            AngularGradient(gradient: Gradient(colors: [.red, .yellow, .green, .blue, .purple, .red]), center: .center)
            
            Text("Hi")
        }
    }
}


struct GuesstheFlag: View {
    @State var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State var correctAnswer = Int.random(in: 0...2)
    @State var isAlertShown: Bool = false
    @State var isEndGameAlertShown: Bool = false
    @State var alertMessage: String = ""
    @State var currentScore = 0
    @State var currentRound = 0
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(
                    stops: [.init(color: .blue, location: 0.50),
                            .init(color: .pink, location: 0.50)]),
                startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack(spacing: 30) {
                VStack(alignment: .leading, spacing: 20) {
                    Text("Tap the flag of")
                        .font(.subheadline.weight(.heavy))
                        .foregroundColor(.white)
                    Text(countries[correctAnswer])
                        .font(.subheadline.weight(.semibold))
                        .foregroundColor(.white)
                }
                ForEach(0..<3) { number in
                    Button {
                       verifyResult(number: number)
                    }
                    label: {
                        Text(countries[number])
                        Image(countries[number])
                            .renderingMode(.original)
                            .shadow(radius: 5)
                    }.buttonStyle(.bordered)
                }
                
                Text("Score: \(currentScore)")
                    .font(.title.bold())
            }
            .padding(20)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .background(.ultraThinMaterial)
            .alert(alertMessage, isPresented: $isAlertShown) {
                Button("Continue") { askQuestion() }
                Button("End the game") {
                    isEndGameAlertShown = true
                }
            }
            message: {
                Text("Your current score is \(currentScore)")
            }
            .alert("End of game", isPresented: $isEndGameAlertShown) {
                Button("Ok") {
                    resetGame()
                }
            }
            message: {
                Text("Your final score is \(currentScore)")
            }
        }
    }
    
    private func verifyResult(number: Int) {
        currentRound += 1
        if number == correctAnswer {
            currentScore += 1
            alertMessage = "Answer is correct"
        } else {
            alertMessage = "Sorry try again"
        }
        if currentRound == 8 {
          isEndGameAlertShown = true
        } else {
            isAlertShown = true
        }
    }
    
    private func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    private func resetGame() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        currentScore = 0
        currentRound = 0
    }
}

struct GuesstheFlag_Previews: PreviewProvider {
    static var previews: some View {
        GuesstheFlag()
    }
}
