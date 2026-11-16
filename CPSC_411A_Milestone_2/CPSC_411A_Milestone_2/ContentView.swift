//
//  ContentView.swift
//  CPSC_411A_Milestone_2
//
//  Created by csuftitan on 11/15/26.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    // Fetch the Minifigures from Core Data (Starter Code Reference)
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Minifigure.name, ascending: true)],
        animation: .default)
    private var minifigures: FetchedResults<Minifigure>

    
    var body: some View {
        // NavigationView (11 SummaryView Reference)
        NavigationView {
            // General VStack containing Title, HStack of displayed info, List of Minifigure
            VStack (spacing: 40) {
                // Title
                Text("Minifigure Portoflio")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .underline(true, color: .black)
                
                
                // Display Horizontal Stack
                HStack {
                    // Display Net total
                    Text(String(format: "Net: $%.2f", calculateNet()))
                        .font(.title3)
                        .fontWeight(.bold)
                        .underline(true, color: .black)
                    
                    
                    // Push UI Items to the left
                    Spacer()
                }
                .padding(.horizontal)
                
                
                // Display the List of Minifigures (11 SummaryView Reference)
                List {
                    ForEach(minifigures) { minifigure in
                        // Navigate to MinifigureDetails
                        NavigationLink(destination: {
                            MinifigureDetails(minifigure: minifigure)
                        }) {
                            // Display only Minifigure name attribute
                            Text(minifigure.name ?? "Unlisted")
                                .fontWeight(.bold)
                        }
                    }
                    
                    // Press Delete Button (11 SummaryView Reference)
                    .onDelete(perform: deleteMinifigure)
                }
                
                
                // Push all UI Items upwards
                Spacer()
            }
            .padding(.vertical)
            .fontDesign(.rounded)
            .onAppear {
                loadDefault()
            }
            
            // 11 SummaryView Reference
            .toolbar {
                
                // Delete existing Minifigures
                ToolbarItem(placement: .navigationBarLeading){
                    EditButton()
                }
                
                // Traver to Create New Minifigure Scene
                ToolbarItem(placement: .navigationBarTrailing){
                    NavigationLink("Create", destination: {
                        MinifigureCreateModify(minifigure: nil)
                    })
                }
            }
            
        }
    }
    
    
    // Helper Function: Calculate Net Total
    private func calculateNet() -> Double {
        var net : Double = 0.0
        
        // Loop adding (count * price)
        for minifigure in minifigures {
            let added = minifigure.price * Double(minifigure.count)
            net += added
        }
        
        return net
    }
    
    
    // Helper Function: Delete Minifigure
    private func deleteMinifigure(at offsets: IndexSet) {
        // 11 SummaryView Reference
        for i in offsets {
            let minifigure = minifigures[i]
            viewContext.delete(minifigure)
        }
        
        
        // Reload, catch error
        do {
            try viewContext.save()
        } catch {
            print("Deletion Error: \(error)")
        }
    }
    
    
    // Helper Function: Load Default Minifigures
    private func loadDefault() {
        if minifigures.isEmpty {
            // Populate first default minifigure
            let minifig1 = Minifigure(context: viewContext)
            minifig1.name = "Zelda"
            minifig1.price = 28.99
            minifig1.count = 1
            minifig1.condition = "New"
            minifig1.desc = "LEGO Deku Tree"
            
            
            // Populate second default minifigure
            let minifig2 = Minifigure(context: viewContext)
            minifig2.name = "Boba Fett"
            minifig2.price = 2210.41
            minifig2.count = 1
            minifig2.condition = "New"
            minifig2.desc = "Cloud City"
            
            
            // Populate third default minifigure
            let minifig3 = Minifigure(context: viewContext)
            minifig3.name = "Rosie"
            minifig3.price = 9.95
            minifig3.count = 1
            minifig3.condition = "New"
            minifig3.desc = "LEGO Animal Crossing"
            
            
            // Reload, catch error
            do {
                try viewContext.save()
            } catch {
                print("Loading Error Occured: \(error)")
            }
        }
    }
}
