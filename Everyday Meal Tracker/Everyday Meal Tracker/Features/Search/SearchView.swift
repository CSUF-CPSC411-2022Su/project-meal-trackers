//
//  SearchView.swift
//  Everyday Meal Tracker
//
//  Created by csuftitan on 6/7/22.
//
import SwiftUI

struct SearchView: View {
    @State var searchString: String = ""
    @StateObject var finder = MealFinder()
    @State var crosswalkname: String = ""
    @StateObject var history = SearchHistory()
    @EnvironmentObject var appHistory : IntakeHistory
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text("Meal Search")
                    .font(.largeTitle).padding(.top,60)
                HStack{
                TextField("Looking for something..", text: $searchString)
                    .modifier(TextEntry())

                Button(action: {
                    finder.find(searchString)
                    history.addSearchString(searchString)
                }) {
                    Text("Search")
                }
                .modifier(ButtonDesign())    .padding(.bottom, 5)
                }
                Text("Recent searches")
                    .font(.headline)
                List(history.searchStrings, id: \.self) {
                    storedSearchString in
                    Button(action: {
                        searchString = storedSearchString
                        finder.find(searchString)
                        history.addSearchString(searchString)
                    }) {
                        Text(storedSearchString)
                    }
                }.frame(height: 300)
                Text("Results")
                    .font(.headline)
                VStack(alignment: .leading) {
                    Spacer()
                    Text(finder.firstFoundName)
                    Spacer()
                    Text("Calories :  \(finder.ResultCalories, specifier: "%.1f")")
                    Text("Protein :  \(finder.ResultProtein, specifier: "%.1f")")
                    Text("Carbohydrates : \(finder.ResultCarbohydrates, specifier: "%.1f")")
                    Text("Fat : \(finder.ResultFat, specifier: "%.1f")")
                    Spacer()
                    Button(action: {
                        var foundFood = Food()
                        foundFood.name = finder.firstFoundName
                        foundFood.calories = String(finder.ResultCalories)
                        foundFood.protein = String(finder.ResultProtein)
                        foundFood.carbohydrates = String(finder.ResultCarbohydrates)
                        foundFood.fat = String(finder.ResultFat)
                        appHistory.foodHistory[0].foodEaten.append(foundFood)
                    }) {
                        Text("Add to Journal")
                    }
                    .modifier(ButtonDesign())
                }
                // Image(uiImage: finder.image)
                Spacer()
            }.padding()
        }
    }
}

struct SearchResultView: View {
    var body: some View {
        Text("Second Screen")
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
