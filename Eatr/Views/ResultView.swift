//
//  ResultView2.swift
//  Eatr
//
//  Created by Agustio Maitimu on 15/04/25.
//

import SwiftUI

struct ResultView: View {
	let name: String
	let address: String
	let price: String
	let distance: Double
	let rating: Double
	let images: [String]
	let mapsAddress: String

	
    var body: some View {
		GeometryReader { screenGeo in
			VStack {
				VStack(alignment: .leading) {
//					Image(images[0])
//						.resizable()
//						.scaledToFill()
//						.frame(width: screenGeo.size.height * 0.32, height: screenGeo.size.height * 0.32)
//						.cornerRadius(4)
					
					TabView {
						ForEach(images, id: \.self) { image in
							Image(image)
								.resizable()
								.scaledToFill()
								.frame(width: screenGeo.size.height * 0.32, height: screenGeo.size.height * 0.32)
								.cornerRadius(4)
						}
						.frame(width: screenGeo.size.height * 0.32, height: screenGeo.size.height * 0.32)
					}
					.tabViewStyle(.page)
					.frame(width: screenGeo.size.height * 0.32, height: screenGeo.size.height * 0.32)
					
					VStack(alignment: .leading, spacing: 6) {
						Text(name)
							.font(.title2.bold())
						Text(address)
							.font(.caption.bold())
							.foregroundStyle(.gray)
						HStack{
							CustomTag(text: price)
							CustomTag(text: "\(String(distance)) km")
							CustomTag(text: String(rating), systemImage: "star.fill")
						}
					}
					.padding(.top, 10)
				}
				.padding(20)
				.background(.white)
				.cornerRadius(10)
				
				Button {
					let url = URL(string: mapsAddress)
					
					if UIApplication.shared.canOpenURL(url!) {
						UIApplication.shared.open(url!, options: [:], completionHandler: nil)
					}
				} label: {
					Label {
						Text("Open In Maps")
					} icon: {
						Image(systemName: "link")
					}
					.foregroundStyle(Color.burgundyEatr)
					.font(.footnote)
					.underline()
					.padding(.top, 11)
				}
			}
			.frame(maxWidth: .infinity, maxHeight: .infinity ,alignment: .center)
		}
    }
}

struct CustomTag: View {
	var text: String
	var systemImage: String? = nil
	
	var body: some View {
		HStack(spacing: systemImage != nil ? 3 : 0) {
			if let systemImage = systemImage {
				Image(systemName: systemImage)
			}
			Text(text)
		}
		.font(.caption)
		.padding(.horizontal, 7)
		.padding(.vertical, 6)
		.foregroundStyle(Color.primaryGreenEatr)
		.background(Color.primaryGreenEatr.opacity(0.2))
		.clipShape(RoundedRectangle(cornerRadius: 4))
	}
}

#Preview {
	ResultView(name: "Soto Ayam Bu Karti", address: "Jl. Raya Kuta No. 105", price: "$$$", distance: 2.5, rating: 4.5, images: ["image_1"], mapsAddress: "")
}
