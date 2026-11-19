//
//  MinifigureDetails.swift
//  CPSC_411A_Milestone_2
//
//  Created by csuftitan on 11/16/26.
//

import SwiftUI
import CoreData

struct MinifigureDetails: View {
    /*
    Passed Minifigure (Similar to Milestone 1)
    Apple Developer: ObservedObject
    (Utilized to update details when edit is complete)
    */
    @ObservedObject var minifigure : Minifigure
    
    
    var body: some View {
        VStack (spacing: 40) {
            // Title
            Text(minifigure.name ?? "Unlisted")
                .fontDesign(.rounded)
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.mint)
                .underline(true, color: .mint)
            
            
            // VStack of Minifigure Attributes
            VStack (alignment: .leading) {
                // Display the price
                Text(String(format: "$%.2f", minifigure.price))
                    .fontDesign(.rounded)
                    .padding()
                    .foregroundStyle(Color.black)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.black, lineWidth: 2)
                    )
                
                
                // Display the count
                Text(String("Quantity: \(minifigure.count)"))
                    .fontDesign(.rounded)
                    .padding()
                    .foregroundStyle(Color.black)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.black, lineWidth: 2)
                    )
                
                
                // Display the condition
                Text("Condition: \(minifigure.condition ?? "Unlisted")")
                    .fontDesign(.rounded)
                    .padding()
                    .foregroundStyle(Color.black)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.black, lineWidth: 2)
                    )
            }
            .fontWeight(.bold)
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
                .foregroundStyle(.black)
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
