//
//  ContentView.swift
//  RollDice
//
//  Created by Eugene on 09/10/2023.
//

import SwiftUI

struct ContentView: View {
    let savePath = FileManager.documentsDirectory.appendingPathComponent("diceroll.json")


    @State private var rollAmount = 0
    @State private var results = [GameResults]()
    
    
    @State private var numSides = 6
    @State private var numDie = 1
    var body: some View {
        NavigationStack {
            VStack {
                Text("You Rolled: ")
                    .font(.title)
                    .padding()
                Text("\(rollAmount)")
                    .font(.largeTitle)
                    .padding()
                
                Button {
                    rollDice()
                    saveRoll()
                } label: {
                    Text("Roll it!")
                        .font(.largeTitle)
                    
                }
                .buttonStyle(.bordered)
                .padding()
                .clipShape(Capsule())
                Form {
                    Stepper(value: $numSides, step: 2) {
                        HStack {
                            Text("Number of sides: ")
                            Text("\(numSides)")
                        }
                        
                    }
                    Stepper(value: $numDie, in: 1...10)
                    {
                        HStack {
                            Text("Number of die: ")
                            Text("\(numDie)")

                        }
                        
                    }
                    Section {
                        NavigationLink {
                            RollResultsView()
                        } label: {
                            Text("View Previous Rolls")
                        }
                    }
                }
                
            }
            .navigationTitle("Dice Roller")
            .toolbar {
                Button("Start New Game?"){
                    resetGame()
                }
            }
        }
    }
    
    
    
    
    func rollDice() {
        let rollPerDie = Int.random(in: 1...numSides)
        rollAmount = rollPerDie * numDie
    }
    
    func saveRoll() {
        let result = GameResults(id: UUID(), rollResult: rollAmount)
        results.insert(result, at: 0)
        if let encoded = try? JSONEncoder().encode(results) {
            do {
                try encoded.write(to: savePath) // encoded is type Data
            } catch {
                print("Error is \(error.localizedDescription)")
            }
        }
    }
    
    
    func resetGame() {
        
        rollAmount = 0
        results = []

        if let encoded = try? JSONEncoder().encode(results) {
            do {
                try encoded.write(to: savePath) // encoded is type Data
            } catch {
                print("Error is \(error.localizedDescription)")
            }
        }
    }
    
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
