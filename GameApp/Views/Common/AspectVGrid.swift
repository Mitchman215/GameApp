//
//  AspectVGrid.swift
//  GameApp
//
//  Created by Mitchell Salomon on 1/24/22.
//

import SwiftUI

/// Displays all the items in an array with dynamically resizing child views that fill all the given space while maintaining an aspect ratio;
/// Arranges the children views in a grid that grows vertically like a LazyVGrid with no spacing in between them
struct AspectVGrid<Item, ItemView>: View where Item: Identifiable, ItemView: View {
    /// The items to display
    var items: [Item]
    
    /// The aspect ratio to maintain on all the child views
    var aspectRatio: CGFloat
    
    /// The ViewBuilder function used to create the child views based on each individual item in the array
    var content: (Item) -> ItemView
    
    /// Memberwise initializer to create an AspectVGrid
    init(items: [Item], aspectRatio: CGFloat, @ViewBuilder content: @escaping (Item) -> ItemView) {
        self.items = items
        self.aspectRatio = aspectRatio
        self.content = content
    }
    
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                let width = widthThatFits(itemCount: items.count, in: geo.size, itemAspectRatio: aspectRatio)
                LazyVGrid(columns: [adaptiveGridItem(width: width)], spacing: 0) {
                    ForEach(items) { item in
                        content(item).aspectRatio(aspectRatio, contentMode: .fit)
                    }
                }
            }
            Spacer(minLength: 0)
        }
    }
    
    private func adaptiveGridItem(width: CGFloat) -> GridItem {
        var gridItem = GridItem(.adaptive(minimum: width))
        gridItem.spacing = 0
        return gridItem
    }
    
    /// Calculates the correct width to maximally fit all the items into the space specified by `size` while maintaining an aspect ratio
    private func widthThatFits(itemCount: Int, in size: CGSize, itemAspectRatio: CGFloat) -> CGFloat {
        var columnCount = 1
        var rowCount = itemCount
        repeat {
            let itemWidth = size.width / CGFloat(columnCount)
            let itemHeight = itemWidth / itemAspectRatio
            if CGFloat(rowCount) * itemHeight < size.height {
                break
            }
            columnCount += 1
            rowCount = (itemCount + (columnCount - 1)) / columnCount
        } while columnCount < itemCount
        if columnCount > itemCount {
            columnCount = itemCount
        }
        return floor(size.width / CGFloat(columnCount))
    }
}

//struct AspectVGrid_Previews: PreviewProvider {
//    static var previews: some View {
//        AspectVGrid()
//    }
//}
