//
//  ViewModel+Scrolling.swift
//  FizzBuzz
//
//  Created by Mohamed Ali BELHADJ on 25/9/2022.
//

import Foundation
extension ViewModel: RandomAccessCollection {
    
    // Needed for RandomAccessCollection
    typealias Element = Item
    typealias Index = Int
   
    subscript(position: Int) -> Item {
        return results[position]
    }
    
    func loadMoreItems(_ item: Item? = nil)  {
        if !shouldLoadMoreItems(item) {
            return
        }
        
        finalResults.append(contentsOf: results[firstItemToLoad...lastItemToLoad-1])
        
        if firstItemToLoad + 1 < lastItemToLoad {
            firstItemToLoad += 1
        }
        if (lastItemToLoad + 1) < results.count {
            lastItemToLoad += 1
        } else {
            lastItemToLoad = results.count
        }
    }

    func shouldLoadMoreItems(_ item: Item? = nil) -> Bool {
        // If they didn't pass us a title, we want load more
        guard let item = item else {
            return true
        }
        
        // If the ID matched, we're near the end of the list
        for i in (finalResults.count-4)...(finalResults.count-1) {
            if i >= 0 && finalResults[i].id == item.id {
                return true
            }
        }
        return false
    }
}
