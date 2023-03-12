//
//  Lists.swift
//  WeSplit
//
//  Created by Abirami Kalyan on 11/03/2023.
//

import SwiftUI

struct Student: Identifiable, Hashable {
    let name: String
    let id = UUID()
}

struct Classroom: Identifiable, Hashable {
    let name: String
    let studentNames: [String]
    let id = UUID()
}

struct ListsView: View {
    let students = [Student(name: "a"), Student(name: "b"), Student(name: "c"), Student(name: "d"), Student(name: "e")]
    @State private var selectedStudents = Set<UUID>()
    
    var body: some View {
        NavigationStack {
            List(students, selection: $selectedStudents) {
                Text($0.name)
            }
            .refreshable {
                print("Refreshed")
            }
            Text("Selected students count: \(selectedStudents.count)")
            .navigationTitle("Students")
            .toolbar {
                EditButton()
            }
        }
    }
}

struct MultiListsView: View {
    
    let classes = [
        Classroom(name: "Class 1", studentNames: ["a", "b", "c"]),
        Classroom(name: "Class 2", studentNames: ["aa", "bb"]),
        Classroom(name: "Class 3", studentNames: ["aaa", "bbb", "ccc"]),
        Classroom(name: "Class 4", studentNames: ["aaaa"])]
    
    @State private var selectedStudent: UUID?
    
    var body: some View {
        NavigationStack {
            List(selection: $selectedStudent) {
                ForEach(classes) { classRoom in
                    Section(header: Text("Classroom: \(classRoom.name)")) {
                        ForEach(classRoom.studentNames, id:\.self) { studentName in
                            //                        Text(studentName)
                            NavigationLink(destination: {
                                Color.red
                            }, label: {
                                Text(studentName)
                            })
                        }
                    }
                }
                Section(footer: Text("This is footer")) {
                    Text("Footer section")
                }
            }
        }
    }
}

struct NavigationSplitViewExample: View {
    
    var body: some View {
        NavigationSplitView {
            List(1..<50) { i in
                NavigationLink("Row \(i)", value: i)
            }
            .navigationDestination(for: Int.self) {
                Text("Selected row \($0)")
            }
            .navigationTitle("Split View")
        } detail: {
            Text("Please select a row")
        }
    }
}


struct HierarchialList: View {
    struct FileItem: Hashable, Identifiable {
        var id: Self { self }
        var name: String
        var children: [FileItem]? = nil
//        var description: String {
//            switch children {
//            case nil:
//                return "📄 \(name)"
//            case .some(let children):
//                return children.isEmpty ? "📂 \(name)" : "📁 \(name)"
//            }
//        }
    }
    let fileHierarchyData: [FileItem] = [
      FileItem(name: "users", children:
        [FileItem(name: "user1234", children:
          [FileItem(name: "Photos", children:
            [FileItem(name: "photo001.jpg"),
             FileItem(name: "photo002.jpg")]),
           FileItem(name: "Movies", children:
             [FileItem(name: "movie001.mp4")]),
              FileItem(name: "Documents", children: [])
          ]),
         FileItem(name: "newuser", children:
           [FileItem(name: "Documents", children: [])
           ])
        ]),
        FileItem(name: "private", children: nil)
    ]
    var body: some View {
        List(fileHierarchyData, children: \.children) { item in
            Text(item.name)
        }
    }
}

struct Lists_Previews: PreviewProvider {
    static var previews: some View {
        NavigationSplitViewExample()
//        MultiListsView()
//        HierarchialList()
    }
}
