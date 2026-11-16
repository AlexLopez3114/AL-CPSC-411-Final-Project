//
//  MinifigureDetails.swift
//  CPSC_411A_Milestone_2
//
//  Created by csuftitan on 11/16/26.
//

import SwiftUI
import CoreData

struct MinifigureDetails: View {
    // Passed Minifigure (Similar to Milestone 1)
    var minifigure : Minifigure
    
    
    // Used to traverse back scenes
    @Environment(\.presentationMode) var presentationMode
    
    
    var body: some View {
        VStack (spacing: 40) {
            // Title
            Text(minifigure.name ?? "Unlisted")
                .fontDesign(.rounded)
                .font(.largeTitle)
                .fontWeight(.bold)
                .underline(true, color: .black)
            
            
            // VStack of Minifigure Attributes
            VStack (alignment: .leading) {
                // Display the price
                Text(String(format: "$%.2f", minifigure.price))
                    .fontDesign(.rounded)
                    .padding()
                    .foregroundStyle(Color.black)
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.black, lineWidth: 2)
                    )
                
                
                // Display the count
                Text(String("Quantity: \(minifigure.count)"))
                    .fontDesign(.rounded)
                    .padding()
                    .foregroundStyle(Color.black)
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.black, lineWidth: 2)
                    )
                
                
                // Display the condition
                Text("Condition: \(minifigure.condition ?? "Unlisted")")
                    .fontDesign(.rounded)
                    .padding()
                    .foregroundStyle(Color.black)
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.black, lineWidth: 2)
                    )
            }
            
            // 7 frame modifier Reference
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
            
            
            // Display the description
            Text(minifigure.desc ?? "")
                // 5 Text appearance modifier Reference
                .multilineTextAlignment(.leading)
                .lineLimit(nil)
            
                .fontDesign(.rounded)
                .padding()
                .foregroundStyle(Color.black)
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.black, lineWidth: 2)
                )
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            
            
            // Push all UI Items upwards
            Spacer()
        }
        
        // 11 SummaryView Reference
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink("Edit", destination: {
                    MinifigureCreateModify(minifigure : minifigure)
                })
            }
        }
    }
}
