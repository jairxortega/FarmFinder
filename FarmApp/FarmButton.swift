//
//  FarmButton.swift
//  FarmApp
//
//  Created by Jair Ortega on 12/12/23.
//

import SwiftUI
import MapKit

struct FarmButton: View {
    
    @Binding var searchResults: [MKMapItem]
    
    var visibleRegion: MKCoordinateRegion?
    
    func search(for query: String) {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = query
        request.resultTypes = .pointOfInterest
        request.region = visibleRegion ?? MKCoordinateRegion(
            center: .home,
            span: MKCoordinateSpan(latitudeDelta: 0.0125, longitudeDelta: 0.0125))
        
        Task {
            let search = MKLocalSearch(request: request)
            do {
                let response = try await search.start()
                searchResults = response.mapItems
            } catch {
                print("Error occurred during the search: \(error.localizedDescription)")
                searchResults = []
            }
        }
    }
    
    var body: some View {
        HStack {
            Button {
                search(for: "farm")
            } label: {
                Label("Farms", systemImage: "house.lodge")
            }
            .buttonStyle(.borderedProminent)
            
            Button {
                search(for: "farmersmarket")
            } label: {
                Label("FarmersMarket", systemImage: "cart")
            }
            .buttonStyle(.borderedProminent)
        }
        .labelStyle(.iconOnly)
    }
}


