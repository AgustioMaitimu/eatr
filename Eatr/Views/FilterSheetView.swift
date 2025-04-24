//
//  FilterSheetView.swift
//  Eatr
//
//  Created by Agustio Maitimu on 11/04/25.
//

import SwiftUI

struct FilterSheetView: View {
	@Environment(\.dismiss) private var dismiss
	@Binding var distance: Double
	@Binding var priceRange: String
	
	let priceRanges = ["$", "$$", "$$$", "$$$$"]
	
	var body: some View {
		NavigationStack {
			VStack {
				Form {
					//Distance Slider Section
					Section {
						VStack {
							HStack {
								Image(systemName: "figure.walk")
								Slider(
									value: $distance,
									in: 1...25,
									step: 1
								)
								.accentColor(Color.orangeEatr)
								Image(systemName: "bicycle")
							}
							Text("\(distance.formatted()) KM")
						}
					} header: {
						Text("Within Distance")
							.foregroundStyle(Color.burgundyEatr)
					}
					
					//Price Range Picker Section
					Section {
						Picker("Price Range", selection: $priceRange) {
							ForEach(priceRanges, id: \.self) {
								Text($0)
							}
						}
						.tint(.purple)
						.pickerStyle(.palette)
					} header: {
						Text("Price Range")
							.foregroundStyle(Color.burgundyEatr)
					}
				}
//				 Form Modifier
				.scrollDisabled(true)
				.scrollContentBackground(.hidden)
				.background(Color.peachEatr)
			}
			//Sheet's Main VStack Modifier
			.navigationTitle("Filters")
			.navigationBarTitleDisplayMode(.inline)
			.presentationDetents([.medium])
			.presentationDragIndicator(.visible)
			.toolbar {
				Button("Save") {
					dismiss()
				}
			}
		}
	}
}

#Preview {
	@Previewable @State var distance: Double = 10
	@Previewable @State var priceRange: String = "$$"
	
	FilterSheetView(distance: $distance, priceRange: $priceRange)
}
