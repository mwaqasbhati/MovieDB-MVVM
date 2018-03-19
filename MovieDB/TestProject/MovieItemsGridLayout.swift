//
//  MovieItemsGridLayout.swift
//  TestProject
//
//  Created by Muhammad Waqas  on 3/06/18.
//  Copyright © 2018 Emaar . All rights reserved.

import UIKit

class MovieItemsGridLayout: UICollectionViewLayout {
    
    private var horizontalInset = 0.0 as CGFloat
    private var verticalInset = 0.0 as CGFloat
    
    private var minimumItemWidth = 0.0 as CGFloat
    private var maximumItemWidth = 0.0 as CGFloat
    private var itemHeight1 = 195.0 as CGFloat
    private var itemHeight2 = 330.0 as CGFloat
    
    private var _layoutAttributes = Dictionary<String, UICollectionViewLayoutAttributes>()
    private var _contentSize = CGSize.zero
    
    private var drawType = 1
    private var type1TwoRowsDraw = 0
    private var type1TotalItems = 2
    private var type2TotalItems = 3
    private var type3TotalItems = 3
    
    lazy var quarterWidth = {
        return (self.collectionView?.frame.size.width ?? 0.0) * 0.25
    }()
    lazy var threeQuarterWidth = {
        return (self.collectionView?.frame.size.width ?? 0.0) * 0.75
    }()
    
    // MARK: -
    // MARK: - Layout
    
    override func prepare() {
        super.prepare()
        
        drawType = 1
        type1TwoRowsDraw = 0
        type1TotalItems = 2
        type2TotalItems = 3
        type3TotalItems = 3
        
        _layoutAttributes = Dictionary<String, UICollectionViewLayoutAttributes>() // 1
        
        let path = IndexPath(item: 0, section: 0)
        let attributes = UICollectionViewLayoutAttributes(forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, with: path)
        
        let headerHeight = CGFloat(0.0)
        attributes.frame = CGRect(x: 0, y: 0, width: self.collectionView!.frame.size.width, height: headerHeight)
        
        let headerKey = layoutKeyForHeaderAtIndexPath(path)
        _layoutAttributes[headerKey] = attributes // 2
        
        let numberOfSections = self.collectionView!.numberOfSections // 3
        
        var lastHeight: CGFloat = 0.0
        var yOffset = headerHeight
        
        for section in 0 ..< numberOfSections {
            
            let numberOfItems = self.collectionView!.numberOfItems(inSection: section) // 3
            
            var xOffset = self.horizontalInset
            
            for item in 0 ..< numberOfItems {
                
                let indexPath = IndexPath(item: item, section: section)
                let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath) // 4
                
                var itemSize = CGSize.zero
                
                if drawType == 1 {
                    if type1TotalItems > 0 {
                        itemSize = CGSize(width: (self.collectionView?.frame.size.width)!/2, height: self.itemHeight1)
                        
                        attributes.frame = CGRect(x: xOffset, y: yOffset, width: itemSize.width, height: itemSize.height).integral
                        let key = layoutKeyForIndexPath(indexPath)
                        _layoutAttributes[key] = attributes // 7
                        
                        xOffset += itemSize.width
                        type1TotalItems -= 1
                        type1TwoRowsDraw += 1
                    }
                    else {
                        // if two rows draw then enable second
                        if indexPath.row == 2 {
                            type1TwoRowsDraw = 0
                            drawType = 2
                            xOffset = 0
                            yOffset += self.itemHeight1
                        }
                        else if type1TwoRowsDraw == 4 {
                            type1TwoRowsDraw = 0
                            drawType = 2
                            xOffset = 0
                            yOffset += self.itemHeight1
                        }
                        else {
                            type1TotalItems = 2
                            xOffset = 0
                            yOffset += self.itemHeight1
                        }
                        
                        
                    }
                    
                }
                if drawType == 2 {
                    if type2TotalItems > 0 {
                        if type2TotalItems == 3 {
                            itemSize = CGSize(width: threeQuarterWidth, height: self.itemHeight2)
                            
                            attributes.frame = CGRect(x: xOffset, y: yOffset, width: itemSize.width, height: itemSize.height).integral
                            let key = layoutKeyForIndexPath(indexPath)
                            _layoutAttributes[key] = attributes // 7
                            
                            xOffset += itemSize.width
                            type2TotalItems -= 1
                        }
                        else if type2TotalItems == 2 {
                            itemSize = CGSize(width: quarterWidth, height: self.itemHeight2/2)
                            
                            attributes.frame = CGRect(x: xOffset, y: yOffset, width: itemSize.width, height: itemSize.height).integral
                            let key = layoutKeyForIndexPath(indexPath)
                            _layoutAttributes[key] = attributes // 7
                            
                            yOffset += self.itemHeight2/2
                            type2TotalItems -= 1
                        }
                        else if type2TotalItems == 1 {
                            itemSize = CGSize(width: quarterWidth, height: self.itemHeight2/2)
                            
                            attributes.frame = CGRect(x: xOffset, y: yOffset, width: itemSize.width, height: itemSize.height).integral
                            let key = layoutKeyForIndexPath(indexPath)
                            _layoutAttributes[key] = attributes // 7
                            
                            xOffset = 0
                            yOffset += self.itemHeight2/2
                            type2TotalItems -= 1
                        }
                    }
                    else {
                        // enable third
                        drawType = 3
                    }
                }
                if drawType == 3 {
                    
                    if type3TotalItems > 0 {
                        if type3TotalItems == 3 {
                            itemSize = CGSize(width: quarterWidth, height: self.itemHeight2/2)
                            
                            attributes.frame = CGRect(x: xOffset, y: yOffset, width: itemSize.width, height: itemSize.height).integral
                            let key = layoutKeyForIndexPath(indexPath)
                            _layoutAttributes[key] = attributes // 7
                            
                            yOffset += self.itemHeight2/2
                            type3TotalItems -= 1
                        }
                        else if type3TotalItems == 2 {
                            itemSize = CGSize(width: quarterWidth, height: self.itemHeight2/2)
                            
                            attributes.frame = CGRect(x: xOffset, y: yOffset, width: itemSize.width, height: itemSize.height).integral
                            let key = layoutKeyForIndexPath(indexPath)
                            _layoutAttributes[key] = attributes // 7
                            
                            yOffset += self.itemHeight2/2
                            xOffset += itemSize.width
                            type3TotalItems -= 1
                        }
                        else if type3TotalItems == 1 {
                            itemSize = CGSize(width: threeQuarterWidth, height: self.itemHeight2)
                            yOffset -= self.itemHeight2
                            attributes.frame = CGRect(x: xOffset, y: yOffset, width: itemSize.width, height: itemSize.height).integral
                            let key = layoutKeyForIndexPath(indexPath)
                            _layoutAttributes[key] = attributes // 7
                            
                            xOffset = 0
                            yOffset += self.itemHeight2
                            type3TotalItems -= 1
                        }
                    }
                    else {
                        // enable One and Reset count
                        drawType = 1
                        type1TotalItems = 2
                        type2TotalItems = 3
                        type3TotalItems = 3
                        
                        if type1TotalItems > 0 {
                            itemSize = CGSize(width: (self.collectionView?.frame.size.width)!/2, height: self.itemHeight1)
                            
                            attributes.frame = CGRect(x: xOffset, y: yOffset, width: itemSize.width, height: itemSize.height).integral
                            let key = layoutKeyForIndexPath(indexPath)
                            _layoutAttributes[key] = attributes // 7
                            
                            xOffset += itemSize.width
                            lastHeight = itemSize.height
                            type1TotalItems -= 1
                            type1TwoRowsDraw += 1
                        }
                    }
                    
                }
                
            }
            
        }
        
        yOffset += lastHeight
        
        _contentSize = CGSize(width: self.collectionView!.frame.size.width, height: yOffset + self.verticalInset) // 11
        
    }
    
    // MARK: -
    // MARK: - Helpers
    
    func randomItemSize() -> CGSize {
        return CGSize(width: getRandomWidth(), height: self.itemHeight1)
    }
    
    func getRandomWidth() -> CGFloat {
        let range = UInt32(self.maximumItemWidth - self.minimumItemWidth + 1)
        let random = Float(arc4random_uniform(range))
        return CGFloat(self.minimumItemWidth) + CGFloat(random)
    }
    
    
    func layoutKeyForIndexPath(_ indexPath : IndexPath) -> String {
        return "\(indexPath.section)_\(indexPath.row)"
    }
    
    func layoutKeyForHeaderAtIndexPath(_ indexPath : IndexPath) -> String {
        return "s_\(indexPath.section)_\(indexPath.row)"
    }
    
    // MARK: -
    // MARK: - Layout attributes
    
    override var collectionViewContentSize: CGSize {
        return _contentSize
    }
    
    override func layoutAttributesForSupplementaryView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        
        let headerKey = layoutKeyForIndexPath(indexPath)
        return _layoutAttributes[headerKey]
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        
        let key = layoutKeyForIndexPath(indexPath)
        return _layoutAttributes[key]
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        let predicate = NSPredicate {  [unowned self] (evaluatedObject, bindings) -> Bool in
            let layoutAttribute = self._layoutAttributes[evaluatedObject as! String]
            return rect.intersects(layoutAttribute!.frame)
        }
        
        let dict = _layoutAttributes as NSDictionary
        let keys = dict.allKeys as NSArray
        let matchingKeys = keys.filtered(using: predicate)
        
        return dict.objects(forKeys: matchingKeys, notFoundMarker: NSNull()) as? [UICollectionViewLayoutAttributes]
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return !newBounds.size.equalTo(self.collectionView!.frame.size)
    }
}
