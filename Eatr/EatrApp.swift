//
//  EatrApp.swift
//  Eatr
//
//  Created by Agustio Maitimu on 11/04/25.
//

import SwiftData
import SwiftUI

@main
struct EatrApp: App {
	@Environment(\.modelContext) var modelContext
	@State private var modelContainer: ModelContainer
	
	init() {
		UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.burgundyEatr]
		UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.burgundyEatr]
		
		do {
			modelContainer = try ModelContainer(for: Restaurant.self)
		} catch {
			fatalError("Can't Fetch Data")
		}
	}
	
	var body: some Scene {
		WindowGroup {
			ContentView()
				.modelContainer(modelContainer)
				.task {
					preloadDataIfNeeded(modelContext: modelContainer.mainContext)
				}
		}
	}
}
