//
//  AspectVGrid.swift
//  memorizegame
//
//  Created by Victoria Petrova on 24/06/2024.
//

import SwiftUI

struct AspectVGrid<Item: Identifiable, ItemView: View>: View {
    var items: [Item]
    var aspectRatio: CGFloat = 1
    @ViewBuilder var content: (Item) -> ItemView
    
    private let geometryAspectRadioFactor = 0.55
    
    init(_ items: [Item], aspectRatio: CGFloat, @ViewBuilder content: @escaping (Item) -> ItemView) {
        self.items = items
        self.aspectRatio = aspectRatio
        self.content = content
    }
    
    var body: some View {
        GeometryReader { geometry in
            let gridItemSize = gridItemWithThatFits(
                count: items.count,
                size: geometry.size,
                atAspectRatio: aspectRatio)
            LazyVGrid(columns: [GridItem(.adaptive(minimum: gridItemSize), spacing: 0)], spacing: 0) {
                ForEach(items) { item in
                    content(item)
                        .aspectRatio(aspectRatio, contentMode: .fit)
                }
            }
        }
    }
    
    
    private func gridItemWithThatFits(
        count: Int,
        size: CGSize,
        atAspectRatio aspectRatio: CGFloat
    ) -> CGFloat {
        let count = CGFloat(count)
        let geometryAspectRatio = (size.height / size.width) * geometryAspectRadioFactor
        var columnCount = 1.0
        repeat {
            let width = size.width / columnCount
            let height = (width / aspectRatio) * geometryAspectRatio
            
            let rowCount = (count / columnCount).rounded(.up)

            if rowCount * height < size.height {
                return (size.width / columnCount).rounded(.down)
            }
            columnCount += 1
        } while columnCount < count
        
        return min(size.width / count, size.height * aspectRatio / geometryAspectRatio).rounded(.down)
    }
}
