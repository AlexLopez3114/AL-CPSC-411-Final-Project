//
//  MinifigureCreateModify.swift
//  CPSC_411A_Milestone_2
//
//  Created by csuftitan on 11/15/26.
//

import SwiftUI
import CoreData

struct MinifigureCreateModify: View {
    // 11 StudentFormView Reference
    private let viewContext = PersistenceController.shared.container.viewContext
    
    
    // Used to determine current state: Edit/Create
    var minifigure: Minifigure? = nil
    
    
    // Default Black Border Flag
    @State private var submitted : Bool = false
    
    
    // Saved Validated Attributes
    @State private var name : String = ""
    @State private var price : Double = 0.0
    @State private var count : Int64 = 0
    @State private var condition : String = ""
    @State private var desc : String = ""
    
    
    // Input Variables for Logic Checking
    @State private var strName : String = ""
    @State private var strPrice : String = ""
    @State private var strCount : String = ""
    @State private var strCondition : String = ""
    @State private var strDesc : String = ""
    
    
    // Bool Variables for Validation Display
    @State private var isName : Bool = false
    @State private var isPrice : Bool = false
    @State private var isCount : Bool = false
    @State private var isCondition : Bool = false
    @State private var isDesc : Bool = false
    
    
    // Used to traverse back scenes
    @Environment(\.presentationMode) var dismiss
    
    
    var body: some View {
        // Stack for Title & TextFields
        VStack (spacing: 40) {
            // Title (Modified based on state)
            Text(minifigure == nil ? "Create Minifigure" : "Edit Minifigure")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(minifigure == nil ? .blue : .green)
                .underline(true, color: minifigure == nil ? .blue : .green)
            
            
            // Vertical Stack of TextFields
            VStack(alignment: .leading, spacing: 20) {
                // TextField for name attribute
                TextField("Name: ", text: $strName)
                    .padding()
                    .foregroundStyle(Color.black)
                    /*
                    5 Textfield appearance modifier
                    (prevents overlapping textfield, and grey corner)
                    */
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(minifigure == nil ? Color.clear : Color.gray.opacity(0.3))
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            // Logic check: if submitted -> black, else isName -> green, else -> red
                            .stroke(!submitted ? Color.black : (isName ? Color.green : Color.red), lineWidth: 2)
                    )
                
                
                // TextField for price attribute
                TextField("Price: ", text: $strPrice)
                    .padding()
                    .foregroundStyle(Color.black)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(minifigure == nil ? Color.clear : Color.gray.opacity(0.3))
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(!submitted ? Color.black : (isPrice ? Color.green : Color.red), lineWidth: 2)
                    )
                
                
                // TextField for count attribute
                TextField("Count: ", text: $strCount)
                    .padding()
                    .foregroundStyle(Color.black)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(minifigure == nil ? Color.clear : Color.gray.opacity(0.3))
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(!submitted ? Color.black : (isCount ? Color.green : Color.red), lineWidth: 2)
                    )
                
                
                // TextField for condition attribute
                TextField("Condition: ", text: $strCondition)
                    .padding()
                    .foregroundStyle(Color.black)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(minifigure == nil ? Color.clear : Color.gray.opacity(0.3))
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(!submitted ? Color.black : (isCondition ? Color.green : Color.red), lineWidth: 2)
                    )
                
                
                // TextField for desc attribute
                TextField("Description: ", text: $strDesc)
                    .padding()
                    .foregroundStyle(Color.black)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(minifigure == nil ? Color.clear : Color.gray.opacity(0.3))
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(!submitted ? Color.black : (isDesc ? Color.green : Color.red), lineWidth: 2)
                    )
            }
            .padding(.horizontal)
            
            
            // Push all UI Items upwards
            Spacer()
        }
        .fontDesign(.rounded)
        .toolbar {
            // Submit the minifigure if valid
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Submit") {
                    submitted = true
                    
                    // Check inputs, save, then dismiss
                    if validate() {
                        saveMinifigure()
                        dismiss.wrappedValue.dismiss()
                    }
                }
            }
        }
        .onAppear() {
            loadMinifigure()
        }
    }
    
    
    // Helper Function: Validate Inputs (Structure from Milestone 1)
    private func validate() -> Bool {
        // Used to validate every attribute, don't return false instantly for border display change
        var legal : Bool = true
        
        
        // Validate Name
        if !(strName.isEmpty) {
            name = strName
            isName = true
        } else {
            legal = false
            isName = false
        }
        
        
        // Validate Price
        if !(strPrice.isEmpty) {
            // Check Double conversion
            if let editPrice = Double(strPrice) {
                // Check non-negative
                if (editPrice > 0.0) {
                    price = editPrice
                    isPrice = true
                } else {
                    legal = false
                    isPrice = false
                }
            } else {
                legal = false
                isPrice = false
            }
        } else {
            legal = false
            isPrice = false
        }
        
        
        // Validate Count
        if !(strCount.isEmpty) {
            // Check Integer Conversion
            if let editCount = Int64(strCount) {
                // Check non-negative
                if (editCount >= 1) {
                    count = editCount
                    isCount = true
                } else {
                    legal = false
                    isCount = false
                }
            } else {
                legal = false
                isCount = false
            }
        } else {
            legal = false
            isCount = false
        }
        
        
        // Validate Condition
        if !(strCondition.isEmpty) {
            // Check if valid String new/used
            if (strCondition.lowercased() == "new" || strCondition.lowercased() == "used") {
                condition = strCondition.lowercased()
                isCondition = true
            } else {
                legal = false
                isCondition = false
            }
        } else {
            legal = false
            isCondition = false
        }
        
        
        // Validate Description
        if !(strDesc.isEmpty) {
            desc = strDesc
            isDesc = true
        } else {
            legal = false
            isDesc = false
        }
        
        return legal
    }
    
    
    // Helper Function: Load Existing Minifigure (11 StudentFormView Reference)
    private func loadMinifigure() {
        // Grab the passed in minifigure
        guard let minifigure = minifigure else { return }
        
        
        // Set Input variables to existing data
        strName = minifigure.name ?? ""
        strPrice = String(minifigure.price)
        strCount = String(minifigure.count)
        strCondition = minifigure.condition ?? ""
        strDesc = minifigure.desc ?? ""
    }
    
    
    // Helper Function: Save Minifigure
    private func saveMinifigure() {
        let target : Minifigure
        
        if let exists = minifigure {
            // Reload existing minifigure with new data
            target = exists
        } else {
            // Create new minifigure (11 StudentFormView Reference)
            target = Minifigure(context: viewContext)
        }
        
        
        // Set all attributes to logic validated variables
        target.name = name
        target.price = price
        target.count = count
        target.condition = condition
        target.desc = desc
        
        
        // Reload, catch error
        do {
            try viewContext.save()
        } catch {
            print("Saving Failure: \(error)")
        }
    }
}


