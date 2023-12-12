//
//  ContentView.swift
//  FarmApp
//
//  Created by Jair Ortega on 12/11/23.
//

import SwiftUI
import MapKit

extension CLLocationCoordinate2D {
    static let home = CLLocationCoordinate2D(latitude: 30.12344, longitude: -98.07966)
}

struct ContentView: View {
    
    @State private var position: MapCameraPosition = .automatic
    
    @State private var visibleRegion: MKCoordinateRegion?
    
    @State private var searchResults: [MKMapItem] = []
    
    var body: some View {
        Map(position: $position) {
            Annotation("Home", coordinate: .home) {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.background)
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.secondary, lineWidth: 5)
                    Image(systemName: "house")
                        .padding(10)
                }
            }
            .annotationTitles(.hidden)
            
            ForEach(searchResults, id: \.self) { result in
                Marker(item: result)
            }
        }
        .mapStyle(.standard(elevation: .realistic))
        .safeAreaInset(edge: .bottom) {
            HStack{
                Spacer()
                FarmButton(searchResults: $searchResults)
                    .padding(.top)
                Spacer()
            }
            .background(.thinMaterial)
        }
        .onChange(of: searchResults) {
            position = .automatic
        }
        .onMapCameraChange { context in
            visibleRegion = context.region
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
