import SwiftData
import SwiftUI

struct ContentView: View {
	@Environment(\.modelContext) var modelContext
	@State private var showFilter = false
	@State private var showingResult = false
	@State private var priceRange = "$$$"
	@State private var distance = 5.0
	@State private var result: Restaurant?
	@State private var isOnCooldown = false
	@State private var timeRemaining = cooldownDuration
	@State private var timer: Timer? = nil
	
	static let cooldownDuration = 15
	
	var body: some View {
		NavigationStack {
			GeometryReader { screenGeo in
				ZStack {
					Image("background")
						.resizable()
						.scaledToFit()
					
					if showingResult {
						ResultView(name: result!.name, address: result!.address, price: result!.price, distance: result!.distance, rating: result!.rating, images: result!.images, mapsAddress: result!.mapsAddress)
					} else {
						Text("Let us help you decide what to eat")
							.font(.largeTitle.bold())
							.frame(maxWidth: 350)
							.foregroundStyle(Color.burgundyEatr)
					}
					
					VStack {
						Spacer()
						
						VStack {
							HStack {
								MainButton(isOnCooldown: $isOnCooldown, screenHeight: screenGeo.size.height, action: fetchData)
								FilterButton(showFilter: $showFilter, isOnCooldown: isOnCooldown, screenHeight: screenGeo.size.height)
							}
							
							Text("Next search available in \(timeRemaining)")
								.padding(.top, 10)
								.foregroundStyle(Color.burgundyEatr)
								.font(.footnote)
								.opacity(isOnCooldown ? 1 : 0)
						}
						.padding([.bottom], 35)
						.padding([.horizontal], 30)
					}
				}
				.navigationTitle(Text("Eatr"))
				.frame(maxWidth: .infinity)
				.background(Color.peachEatr)
				.sheet(isPresented: $showFilter) {
					FilterSheetView(distance: $distance, priceRange: $priceRange)
				}
				.ignoresSafeArea()
			}
		}
		.onAppear {
			checkCooldown()
		}
	}
	
	func fetchData() {
		let descriptor = FetchDescriptor<Restaurant>(predicate: #Predicate { model in
			model.price == priceRange && model.distance <= distance
		})
		
		do {
			let results = try modelContext.fetch(descriptor)
			result = results.randomElement()
			showingResult = true
			
			storeResultAndCooldown()
		} catch {
			print("Failed to fetch data: \(error)")
		}
	}
	
	func storeResultAndCooldown() {
		if let result = result {
			let encoder = JSONEncoder()
			if let resultData = try? encoder.encode(result) {
				UserDefaults.standard.set(resultData, forKey: "lastResult")
			}
		}
		
		UserDefaults.standard.set(Date(), forKey: "cooldownStart")
		startCooldown()
	}
	
	func startCooldown() {
		timer?.invalidate()
		timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
			if timeRemaining > 1 {
				timeRemaining -= 1
			} else {
				timer?.invalidate()
				timeRemaining = ContentView.cooldownDuration
				isOnCooldown = false
				UserDefaults.standard.removeObject(forKey: "cooldownStart")
			}
		}
		isOnCooldown = true
	}
	
	func checkCooldown() {
		if let start = UserDefaults.standard.object(forKey: "cooldownStart") as? Date {
			let elapsed = Date().timeIntervalSince(start)
			if elapsed < Double(ContentView.cooldownDuration) {
				timeRemaining = ContentView.cooldownDuration - Int(elapsed)
				isOnCooldown = true
				showingResult = true
				startCooldown()
			}
		}
		
		if let lastResultData = UserDefaults.standard.data(forKey: "lastResult"),
		   let decodedResult = try? JSONDecoder().decode(Restaurant.self, from: lastResultData) {
			result = decodedResult
		}
	}
	
	struct MainButton: View {
		@Binding var isOnCooldown: Bool
		let screenHeight: CGFloat
		
		let action: () -> Void
		
		var body: some View {
			Button() {
				action()
			} label: {
				Label("Let's Eat!", systemImage: "fork.knife")
					.font(.body.bold())
					.frame(maxWidth: .infinity, minHeight: screenHeight * 0.08)
					.background(Color.orangeEatr)
					.foregroundStyle(Color.peachEatr)
					.clipShape(.capsule)
			}
			.opacity(isOnCooldown ? 0.65 : 1.0)
			.disabled(isOnCooldown)
		}
	}
	
	struct FilterButton: View {
		@Binding var showFilter: Bool
		let isOnCooldown: Bool
		let screenHeight: CGFloat
		
		var body: some View {
			Button() {
				showFilter = true
			} label: {
				Label("", systemImage: "line.3.horizontal.decrease")
					.font(.body.bold())
					.labelStyle(.iconOnly)
					.frame(width: screenHeight * 0.08, height: screenHeight * 0.08)
					.background(Color.orangeEatr)
					.foregroundStyle(Color.peachEatr)
					.clipShape(.capsule)
			}
			.opacity(isOnCooldown ? 0.65 : 1.0)
			.disabled(isOnCooldown)
		}
	}
}

#Preview {
	ContentView()
}
