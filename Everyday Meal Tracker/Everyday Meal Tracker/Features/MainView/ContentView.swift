//
//  MainView.swift
//  Everyday Meal Tracker
//
//  Created by Jacob Hajjar on 6/18/22.
//

import SwiftUI

enum Screens {
    case dashboard
    case search
}

struct ContentView: View {
    @State var currentView: Screens = .dashboard
    @StateObject var appHistory = IntakeHistory()
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                switch currentView {
                    case .dashboard:
                    DashboardView()
                case .search:
                    SearchView()
                    default:
                        DashboardView()
                }
                HStack {
                    Spacer()
                    VStack {
                        Spacer()
                        Button {
                            currentView = .search
                        } label: {
                            Image(systemName: "magnifyingglass")
                                .imageScale(.large)
                                .foregroundColor(Color.black)
                        }.padding(.bottom, geometry.size.height / 40)
                    }
                    Spacer()
                    VStack {
                        Spacer()
                        Button {
                            currentView = .dashboard
                        } label: {
                            Image(systemName: "house.fill")
                                .imageScale(.large)
                                .foregroundColor(Color.black)
                        }.padding(.bottom, geometry.size.height / 40)
                    }
                    Spacer()
                    VStack {
                        Spacer()
                        Button {
                            currentView = .dashboard // set graph view
                        } label: {
                            Image(systemName: "chart.xyaxis.line")
                                .imageScale(.large)
                                .foregroundColor(Color.black)
                        }
                    }.padding(.bottom, geometry.size.height / 40)
                    Spacer()
                }
                .ignoresSafeArea()
                .frame(width: geometry.size.width, height: geometry.size.height / 16)
                .background(Color.orange)
                .shadow(color: Color.black.opacity(0.4), radius: 10)
            }
        }.environmentObject(appHistory)
            .onAppear {
                appHistory.loadHistory()
                print("Loaded")
            }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
