//
//  ContentView.swift
//  bottom_sheet
//
//  Created by Isaac Almanza on 05/04/25.
//

import SwiftUI
import SwiftData
import UIKit // Added to resolve Color.black and other potential UIKit issues

// Main content view that triggers the bottom sheet
struct ContentView: View {
    @State private var showSheet = false
    @State private var selectedDetent: PresentationDetent = .medium // Start at medium height

    // Define the available detents for the sheet
    // Using .height for collapsed, .medium, and .large
    private let availableDetents: Set<PresentationDetent> = [.height(150), .medium, .large]

    var body: some View {
        NavigationView { // Wrap in NavigationView for title, optional
            ZStack {
                // Placeholder for the main app content (e.g., a map)
                Color.gray.opacity(0.2).ignoresSafeArea()
                    .overlay(alignment: .center) {
                        Text("Main Content Area")
                            .font(.title)
                    }

                VStack {
                    Spacer() // Pushes button to the bottom
                    Button("Show Stats Sheet") {
                        showSheet = true
                    }
                    .padding()
                    .buttonStyle(.borderedProminent)
                }
            }
            .navigationTitle("Activity") // Optional title
            .sheet(isPresented: $showSheet) {
                // This is the content presented inside the sheet
                SheetContent(selectedDetent: $selectedDetent, availableDetents: availableDetents)
            }
        }
    }
}

// View defining the content displayed within the bottom sheet
struct SheetContent: View {
    @Binding var selectedDetent: PresentationDetent
    let availableDetents: Set<PresentationDetent>

    var body: some View {
        VStack {
            

            // The actual glass UI from the original code
            GlassBottomSheet()

            Spacer() // Ensures GlassBottomSheet doesn't take up *all* space if its content is small
        }
        // Apply presentation detents and bind the selection
        .presentationDetents(availableDetents, selection: $selectedDetent)
        // Optional: Explicitly control drag indicator visibility
         .presentationDragIndicator(.visible)
         // Allow background interaction - uncomment if needed
         // .interactiveDismissDisabled(true)
         // .presentationBackgroundInteraction(.enabled(upThrough: .medium))
    }
}

// Preview Provider (Optional: Update if needed)
#Preview {
    ContentView()
}
