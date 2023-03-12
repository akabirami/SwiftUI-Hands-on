//
//  ContentView.swift
//  WeSplit
//
//  Created by Abirami Kalyan on 09/03/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var tapCount = 0
    @State private var name = ""
    @State private var selectedDish = ""
    let names = ["c", "a", "b", "c"]
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Enter", text: $name)
                    Text("Your name is \(name)")
                    // Creater Picker for favourite dish and display it
                    Picker("Pick your fav dish", selection: $selectedDish) {
                        ForEach(names, id: \.self) {
                            Text($0)
                        }
                    }
                    Text("Your fav dish is \(selectedDish)")
                }
                Section {
                    Text("Hello, world!")
                    Text("Hi")
                }
            }
            Button("Tap me, tapcount: \(tapCount)") {
                self.tapCount += 1
            }
            .navigationTitle("SwiftUI")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct CheckSplittingView: View {
    @State private var totalAmount: Double = 0.0
    @State private var tipPercentage = 10
    @State private var numberOfPeople = 0
    let tipPercentages = [10, 15, 20, 25, 0]
    
    @FocusState private var amountIsFocused: Bool
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople)
        let tipSelection = Double(tipPercentage)

        let tipValue = totalAmount / 100 * tipSelection
        let grandTotal = totalAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount

        return amountPerPerson
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Enter check amount", value: $totalAmount, formatter: NumberFormatter())
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    Text("Just checking entered value: \(totalAmount)")
                }
                header: {
                    Text("Enter total amount")
                }
                Section {
                    TextField("Enter number of people", value: $numberOfPeople, formatter: NumberFormatter())
                        .keyboardType(.numberPad)
                    
                }
                header: {
                    Text("Enter number of people")
                }
                Section {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("How much tip do you want to leave?")
                }
                
                Section {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .foregroundColor(tipPercentage == 0 ? .red : .primary)
                }
                header: {
                    Text("Per person share")
                }
            }
            .navigationTitle("SwiftUI")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CheckSplittingView()
    }
}
