//
//  ReceipeListView.swift
//  FoodReceips
//
//  Created by Dilan Jayamanne on 2023-05-19.
//

import SwiftUI

struct RecipeListView: View {
    @State private var recipes: [Recipe] = [
        // Sample recipe data
        Recipe(name: "Pasta Carbonara", ingredients: ["Spaghetti", "Eggs", "Parmesan cheese"], imageURL: URL(string: "https://example.com/pasta_carbonara.jpg")!, steps: ["Step 1", "Step 2"], difficulty: .medium, time: 30),
        Recipe(name: "Chicken Stir-Fry", ingredients: ["Chicken", "Vegetables", "Soy sauce"], imageURL: URL(string: "https://example.com/chicken_stirfry.jpg")!, steps: ["Step 1", "Step 2"], difficulty: .easy, time: 20)
    ]

    @State private var isPresentingAddView = false
    @State private var selectedRecipe: Recipe?

    var body: some View {
        NavigationView {
            List {
                ForEach(recipes) { recipe in
                    Button(action: {
                        selectedRecipe = recipe
                    }) {
                        HStack {
//                            AsyncImage(url: recipe.imageURL)
//                                .scaledToFill()
//                                .frame(width: 60, height: 60)
//                                .clipped()
//                                .cornerRadius(10)
                            
                            AsyncImage(url: recipe.imageURL) { phase in
                                switch phase {
                                case .empty:
                                    ProgressView()
                                case .success(let image):
                                    image.resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(maxWidth: 60, maxHeight: 60)
                                case .failure:
                                    Image(systemName: "photo")
                                        .frame(width: 60, height: 60)
                                @unknown default:
                                    // Since the AsyncImagePhase enum isn't frozen,
                                    // we need to add this currently unused fallback
                                    // to handle any new cases that might be added
                                    // in the future:
                                    EmptyView()
                                }
                            }
                            .frame(width: 60, height: 60)


                            VStack(alignment: .leading) {
                                Text(recipe.name)
                                    .font(.headline)

                                Text(recipe.difficulty.rawValue)
                                    .foregroundColor(getDifficultyColor(recipe.difficulty))
                            }
                        }
                    }
                }
                .onDelete(perform: deleteRecipe)
            }
            .navigationTitle("Recipes")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        isPresentingAddView = true
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $isPresentingAddView) {
                RecipeAddView(recipes: $recipes, isPresented: $isPresentingAddView)
            }
            .sheet(item: $selectedRecipe) { recipe in
                RecipeDetailView(recipe: recipe)
            }
        }
    }

    func deleteRecipe(at offsets: IndexSet) {
        recipes.remove(atOffsets: offsets)
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


struct ReceipeListView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeListView()
    }
}
