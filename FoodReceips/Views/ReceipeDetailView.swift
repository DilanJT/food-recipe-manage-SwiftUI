//
//  ReceipeDetailView.swift
//  FoodReceips
//
//  Created by Dilan Jayamanne on 2023-05-19.
//

import SwiftUI

struct RecipeDetailView: View {
    let recipe: Recipe

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                Text(recipe.name)
                    .font(.title)
                    .fontWeight(.bold)
                
                AsyncImage(url: recipe.imageURL)
                { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 200)
                            .clipped()
                            .cornerRadius(10)
                    case .failure(_):
                        // Placeholder image or error handling view
                        Color.gray
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 200)
                            .cornerRadius(10)
                    case .empty:
                        // Placeholder image or loading indicator
                        Color.gray
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 200)
                            .cornerRadius(10)
                    @unknown default:
                        // Placeholder image or error handling view
                        Color.gray
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 200)
                            .cornerRadius(10)
                    }
                }
                
                    

                Text("Ingredients:")
                    .font(.headline)

                ForEach(recipe.ingredients, id: \.self) { ingredient in
                    Text("• \(ingredient)")
                }

                Text("Steps:")
                    .font(.headline)

                ForEach(recipe.steps.indices, id: \.self) { index in
                    Text("\(index + 1). \(recipe.steps[index])")
                }

                HStack {
                    Text("Difficulty:")
                        .font(.headline)

                    Text(recipe.difficulty.rawValue)
                        .foregroundColor(getDifficultyColor(recipe.difficulty))
                }

                HStack {
                    Text("Time:")
                        .font(.headline)

                    Text("\(recipe.time) mins")
                }
            }
            .padding()
        }
        .navigationTitle("Recipe Details")
    }
    
    func getDifficultyColor(_ difficulty: Difficulty) -> Color {
        switch difficulty {
        case .easy:
            return .green
        case .medium:
            return .yellow
        case .hard:
            return .red
        }
    }
}


struct ReceipeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeDetailView(recipe: Recipe(
            name: "Pasta Carbonara",
                ingredients: ["Spaghetti", "Eggs", "Parmesan cheese", "Bacon", "Black pepper"],
                imageURL: URL(string: "https://www.budgetbytes.com/wp-content/uploads/2013/07/Creamy-Spinach-Tomato-Pasta-bowl-500x500.jpg")!,
                steps: ["Cook the spaghetti according to the package instructions.", "In a bowl, whisk together the eggs, grated Parmesan cheese, and black pepper.", "Fry the bacon in a pan until crispy.", "Drain the cooked spaghetti and immediately add it to the pan with the bacon.", "Pour the egg mixture over the spaghetti and toss well to coat.", "Serve hot and enjoy!"],
                difficulty: .medium,
                time: 30
        ))
    }
}




