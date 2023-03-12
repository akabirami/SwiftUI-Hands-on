//
//  Navigation.swift
//  WeSplit
//
//  Created by Abirami Kalyan on 11/03/2023.
//

import SwiftUI

struct Navigation: View {
    @State private var title = "Welcome"

    var body: some View {
        TabView{
            NavigationStack {
                Text("Hello, world!")
                NavigationLink("Navigate") {
                    Color.yellow
                }
                    .navigationTitle($title)
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItemGroup(placement: .primaryAction) {
                            Button("Ok1") {}
                            Button ("Hi1") {}
                        }
                        ToolbarItemGroup(placement: .secondaryAction) {
                            Button("Ok2") {}
                            Button ("Hi2") {}
                        }
                    }
            }.tabItem {
                Label ("1", systemImage: "pencil")
            }
            
            Color.blue
                .tabItem {
                    Label ("2", systemImage: "swift")
                }
        }
    }
}

struct Navigation_Previews: PreviewProvider {
    static var previews: some View {
        Navigation()
    }
}
