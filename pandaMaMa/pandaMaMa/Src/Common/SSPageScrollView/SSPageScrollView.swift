//
//  SSPageScrollView.swift
//  pandaMaMa
//
//  Created by tree on 2017/9/1.
//  Copyright © 2017年 tree. All rights reserved.
//

import Foundation
import UIKit

protocol SSPageScrollDelegate: class {
    /// 点击单元格触发
    ///
    /// - Parameters:
    ///   - scroll: 当前视图对象
    ///   - index: 点击索引号
    /// - Returns: Void
    func scrollView(scroll: SSPageScrollView, DidSelectItemAt index: Int) -> Void
}

class SSPageScrollView: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate {
    private let img_unit_idf: String = "SSPageScroll_Cell"
    //MARK:-
    //MARK:PublicProperties-开放属性
    public var scrollDirection: UICollectionViewScrollDirection = .horizontal // 滑动方向
    public var urlImages: [String] {// 网络图片资源
        didSet {
            var o = [String]()
            if urlImages.count == 0 { urlImages.append("")}
            if let last = urlImages.last { o.append(last)}
            for temp_unit in urlImages { o.append(temp_unit) }
            if let fir = urlImages.first { o.append(fir)}
            _allUnits = o
        }
    }
    public var localImages: [String] {// 本地图片
        didSet {
            var o = [String]()
            if localImages.count == 0 { localImages.append("")}
            if let last = localImages.last { o.append(last)}
            for temp_unit in localImages { o.append(temp_unit) }
            if let fir = localImages.first { o.append(fir)}
            _allUnits = o
        }
    }
    public var placeholder: UIImage? {// 占位图
        didSet { self.collectionView.reloadData() }
    }
    public var currentPageIndicatorTintColor: UIColor? {
        didSet { pageController.currentPageIndicatorTintColor = currentPageIndicatorTintColor }
    }
    public var pageIndicatorTintColor: UIColor? {
        didSet { pageController.pageIndicatorTintColor = pageIndicatorTintColor }
    }
    public var delegate: SSPageScrollDelegate?// 代理
    
    public var autoScrollTimerInterval: TimeInterval = 2.0
//    public var infinite: Bool = false {// 如果不是无尽模式，不允许自动轮播
//        didSet { self.autoScroll = infinite}
//    }
    public var autoScroll: Bool = false {
        didSet{
            invalidateTimer()
            if autoScroll == true { setUpTimer()}
        }
    }
    //MARK:-
    //MARK:private property
    private var _allUnits: [String] {
        didSet {
            if max(0, _allUnits.count) <= 0 { return }
            pageController.numberOfPages = urlImages.count
            collectionView.reloadData()
            currentUnitIndex = 1
        }
    }
    
    private var pageController: UIPageControl = {
        let page = UIPageControl.init()
        page.hidesForSinglePage = true
        return page
    }()// 页数控制器
    
    private var currentUnitIndex: Int = 0// 当前的视图索引
    private var currentPageIndex: Int {// 当前pageController的索引
        get {
            currentUnitIndex = min(_allUnits.count, currentUnitIndex)
            currentUnitIndex = max(0, currentUnitIndex)
            if _allUnits.count - currentUnitIndex == 1 { return 0 }
            else if currentUnitIndex == 0 { return pageController.numberOfPages - 1}
            else if currentUnitIndex == _allUnits.count {
                currentUnitIndex = 2 //否则currentUnitIndex == _allUnits.count时候永远为0
                return 1
            }
            return currentUnitIndex - 1
        }
    }
    
    private var collectionView: UICollectionView! // 视图
    private var flowLayout: UICollectionViewFlowLayout! // 布局设置
    
    private var timer: Timer?
    
    //MARK:-
    //MARK:lifeCycle
    override init(frame: CGRect) {
        self.urlImages = []
        self.localImages = []
        _allUnits = urlImages
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        self.setUpCollectionView()
    }
    deinit {
        DLog("释放")
    }
    
    func setUpTimer() {
        let timer = Timer.scheduledTimer(timeInterval: autoScrollTimerInterval, target: self, selector: #selector(scrollTimerHandler), userInfo: nil, repeats: true)
        self.timer = timer
        RunLoop.main.add(timer, forMode: .commonModes)
    }
    func invalidateTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    func setUpCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0.0
        layout.scrollDirection = self.scrollDirection
        flowLayout = layout
        collectionView = UICollectionView.init(frame: frame, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.clear
        collectionView.register(SSPageScrollCell.self, forCellWithReuseIdentifier: img_unit_idf)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.bounces = false
        collectionView.isPagingEnabled = true
        self.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
        collectionView.delegate = self
        collectionView.dataSource = self
        
        self.addSubview(self.pageController)
        self.bringSubview(toFront: self.pageController)
        self.pageController.addTarget(self, action: #selector(SSPageScrollView.currentPageChanged(control:)), for: .valueChanged)
        pageController.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.bottom.equalTo(self.snp.bottom).offset(-10)
            make.width.lessThanOrEqualToSuperview()
            make.height.equalTo(20.0)
        }
    }
    
    func fixCollectionViewOffset() {// 更新布局
        var o = 0
        if currentUnitIndex == 0 { o = _allUnits.count - 2 }
        else if _allUnits.count - currentUnitIndex == 1 { o = 1 }
        else { o = currentUnitIndex }
        guard _allUnits.count > 0 else { return}
        o = max(o, 0)
        o = min(o, _allUnits.count-1)
        collectionView.scrollToItem(at: IndexPath.init(item: o, section: 0), at: .left, animated: false)
    }
    
    func animateCollectionView() {
        collectionView.scrollToItem(at: IndexPath.init(item: currentUnitIndex, section: 0), at: .left, animated: true)
    }
    
    func updatePageController() {
        pageController.currentPage = currentPageIndex
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        flowLayout.itemSize = self.bounds.size;
        fixCollectionViewOffset()
    }
    //MARK:-
    //MARK:delegate
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        if scrollView != collectionView { return}
        let index = Int(collectionView.contentOffset.x / self.collectionView.width)
        currentUnitIndex = index
        updatePageController()
        fixCollectionViewOffset()
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        invalidateTimer()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let index = Int(collectionView.contentOffset.x / self.collectionView.width)
        currentUnitIndex = index
        setUpTimer()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.scrollView(scroll: self, DidSelectItemAt: currentPageIndex)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { return _allUnits.count }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let item: SSPageScrollCell = collectionView.dequeueReusableCell(withReuseIdentifier: img_unit_idf, for: indexPath) as? SSPageScrollCell {
            if let url: NSURL = NSURL.init(string: _allUnits[indexPath.item]) {
                item.imageView.setImageURL(picURL: url as URL, placeholder: placeholder)
            }
            item.label.text = "\(indexPath.row)"
            item.label.font = UIFont.boldSystemFont(ofSize: 20)
            item.label.textAlignment = .center
            return item
        }else { return UICollectionViewCell.init() }
    }
    
    //MARK:-
    //MARK: private
    func scrollTimerHandler() {// 和调整偏移量不同,需要动画效果，但是不全部需要
        currentUnitIndex += 1
        updatePageController()
        animateCollectionView()
    }
    
    func currentPageChanged(control: UIPageControl) {
        let index: Int = control.currentPage
        currentUnitIndex = index + 1
        pageController.currentPage = currentPageIndex;
        self.collectionView.scrollToItem(at: IndexPath.init(item: currentUnitIndex, section: 0), at: .left, animated: true)
    }
}
