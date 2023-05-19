//
//  ReceipeAddView.swift
//  FoodReceips
//
//  Created by Dilan Jayamanne on 2023-05-19.
//

import SwiftUI

struct RecipeAddView: View {
    @Binding var recipes: [Recipe]
    @Binding var isPresented: Bool

    @State private var recipeName = ""
    @State private var ingredients = ""
    @State private var imageURLString = ""
    @State private var steps = ""
    @State private var selectedDifficulty = Difficulty.easy
    @State private var time = ""

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Recipe Details")) {
                    TextField("Recipe Name", text: $recipeName)
                    TextField("Ingredients (separated by commas)", text: $ingredients)
                    TextField("Image URL", text: $imageURLString)
                    TextField("Steps (one step per line)", text: $steps)
//                    Picker("Difficulty", selection: $selectedDifficulty) {
//                        ForEach(Difficulty.allCases, id: \.self) { difficulty in
//                            Text(difficulty.rawValue.capitalized).tag(difficulty)
//                        }
//                    }
                    TextField("Time (in minutes)", text: $time)
                        .keyboardType(.numberPad)
                }

                Section {
                    Button("Add Recipe") {
                        addRecipe()
                    }
                }
            }
            .navigationTitle("Add Recipe")
            .navigationBarItems(
                leading: Button("Cancel") {
                    isPresented = false
                }
            )
        }
    }

    private func addRecipe() {
        guard let timeValue = Int(time) else { return }

        let recipe = Recipe(
            name: recipeName,
            ingredients: ingredients.components(separatedBy: ", "),
            imageURL: URL(string: imageURLString) ?? URL(string: "https://www.budgetbytes.com/wp-content/uploads/2013/07/Creamy-Spinach-Tomato-Pasta-bowl-500x500.jpg")!,
            steps: steps.components(separatedBy: "\n"),
            difficulty: selectedDifficulty,
            time: timeValue
        )

        recipes.append(recipe)
        isPresented = false
    }
}



//struct ReceipeAddView_Previews: PreviewProvider {
//    static var previews: some View {
//        RecipeAddView(isPresented: , isPresented: Binding<Bool>, recipes: [Recipe(name: "test", ingredients: ["test1", "test2"], imageURL: URL(""), steps: ["", ""], difficulty: Difficulty.easy, time: 2)])
//    }
//}
