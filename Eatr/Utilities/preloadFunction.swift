//
//  preloadFunction.swift
//  Eatr
//
//  Created by Agustio Maitimu on 12/04/25.
//

import SwiftUI
import SwiftData


func preloadDataIfNeeded(modelContext: ModelContext) {
	var descriptor = FetchDescriptor<Restaurant>()
	descriptor.fetchLimit = 1
	
	do {
		let existingItems = try modelContext.fetch(descriptor)
		if existingItems.isEmpty {
			if let url = Bundle.main.url(forResource: "DummyData", withExtension: "json") {
				do {
					let data = try Data(contentsOf: url)
					let decoder = JSONDecoder()
					let restaurants = try decoder.decode([Restaurant].self, from: data)
					
					for restaurant in restaurants {
						modelContext.insert(restaurant)
					}
					
					try modelContext.save()
					print("Successfully preloaded \(restaurants.count) restaurants")
				} catch {
					print("Failed load/decode")
				}
			} else {
				print("No DummyData file")
			}
		} else {
			print("Data already exists")
		}
	} catch {
		print("Something went wrong somewhere")
	}
}
