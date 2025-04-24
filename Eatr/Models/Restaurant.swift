//
//  Restaurant.swift
//  Eatr
//
//  Created by Agustio Maitimu on 12/04/25.
//

import Foundation
import SwiftData

@Model
class Restaurant: Identifiable, Codable {
	enum CodingKeys: String, CodingKey {
		case name = "name"
		case address = "address"
		case price = "price"
		case distance = "distance"
		case rating = "rating"
		case images = "images"
		case mapsAddress = "maps_address"
	}
	
	var name: String
	var address: String
	var price: String
	var distance: Double
	var rating: Double
	var images: [String]
	var mapsAddress: String
	
	init(name: String, address: String, price: String, distance: Double, rating: Double, images: [String], mapsAddress: String) {
		self.name = name
		self.address = address
		self.price = price
		self.distance = distance
		self.rating = rating
		self.images = images
		self.mapsAddress = mapsAddress
	}
	
	required init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		name = try container.decode(String.self, forKey: .name)
		address = try container.decode(String.self, forKey: .address)
		price = try container.decode(String.self, forKey: .price)
		distance = try container.decode(Double.self, forKey: .distance)
		rating = try container.decode(Double.self, forKey: .rating)
		images = try container.decode([String].self, forKey: .images)
		mapsAddress = try container.decode(String.self, forKey: .mapsAddress)
	}
	
	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(name, forKey: .name)
		try container.encode(address, forKey: .address)
		try container.encode(price, forKey: .price)
		try container.encode(distance, forKey: .distance)
		try container.encode(rating, forKey: .rating)
		try container.encode(images, forKey: .images)
		try container.encode(mapsAddress, forKey: .mapsAddress)
	}
}
