//
//  ContentView.swift
//  TrelloWidget
//
//  Created by Peyton Martin on 5/17/23.
//

import SwiftUI

struct ContentView: View {
    @State private var cards: [Card] = []
    @State private var newCardName = ""
    
    private let trelloManager = TrelloManager()
    
    var body: some View {
        VStack {
            List(cards) { card in
                Text(card.name)
            }
            
            HStack {
                TextField("New Card Name", text: $newCardName)
                Button(action: addNewCard) {
                    Text("Add Card")
                }
            }
        }
        .onAppear {
            fetchCards()
        }
    }
    
    private func fetchCards() {
        trelloManager.fetchCards { fetchedCards in
            DispatchQueue.main.async {
                cards = fetchedCards
            }
        }
    }
    
    private func addNewCard() {
        trelloManager.addCard(name: newCardName)
        newCardName = ""
        fetchCards()
    }
    
    private func removeCard(at offsets: IndexSet) {
        offsets.forEach { index in
            let card = cards[index]
            trelloManager.removeCard(cardId: card.id)
        }
        fetchCards()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


