//
//  Controls.swift
//  WeSplit
//
//  Created by Abirami Kalyan on 11/03/2023.
//

import SwiftUI

struct Controls: View {
    @State private var selectedDate = Date()
    var body: some View {
        Form {
            Section {
                HStack {
                    DatePicker("Selected date", selection: $selectedDate, in: ...Date.now, displayedComponents: [.date, .hourAndMinute])
                    Button() {
                        
                    } label: {
                        Label("Done", systemImage: "arrow.right.circle")
                    }
                }
                Text("Selected date is \(selectedDate)")
                
            }
        }
    }
}

struct Controls_Previews: PreviewProvider {
    static var previews: some View {
        Controls()
    }
}
