//
//  ViewController.swift
//  caoqinyu_9_3
//
//  Created by student on 2018/11/24.
//  Copyright © 2018年 2016110302. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIScrollViewDelegate {
    //轮播页面
    var scroll_1: UIScrollView!
    //缩放页面
    var scroll_2: UIScrollView!
    var page: UIPageControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor.white
        
        let width = self.view.bounds.width - 20
        let height = width * 0.6
        
        scroll_1 = UIScrollView(frame: CGRect(x: 10, y: 100, width: width, height: height))
        //按一页一页的方式滚动
        scroll_1.isPagingEnabled = true
        scroll_1.showsHorizontalScrollIndicator = false//隐藏水平滚动条
        scroll_1.contentSize = CGSize(width: width*5, height: height)
        scroll_1.delegate = self
        self.view.addSubview(scroll_1)
        
        page = UIPageControl(frame: CGRect(x: 10, y: 100+height, width: width, height: 30))
        page.numberOfPages = 5//总页数
        page.currentPage = 0//默认当前页数
        //指示器未选中时颜色
        page.pageIndicatorTintColor = UIColor.brown
        //指示器选中时颜色
        page.currentPageIndicatorTintColor = UIColor.green
        //添加事件
        page.addTarget(self, action: #selector(pageChanged(page:)), for: .touchUpInside)
        self.view.addSubview(page)
        
        for i in 1...5 {
            let image = UIImage(named: "\(i)")
            let imageView = UIImageView(frame: CGRect(x: width*CGFloat(i-1), y: 0, width: width, height: height))
            imageView.image = image
            imageView.contentMode = .scaleAspectFill
            scroll_1.addSubview(imageView)
        }
        
        
        
        scroll_2 = UIScrollView(frame: CGRect(x: 10, y: 200+height, width: width, height: height))
        scroll_2.backgroundColor = UIColor.yellow
        scroll_2.contentSize = CGSize(width: width, height: height)
        
        scroll_2.delegate = self
        self.view.addSubview(scroll_2)
        
        let image = UIImage(named: "6")
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        imageView.contentMode = .scaleAspectFill
        imageView.image = image
        //将scoll_2加入view
        //最大缩放比例
        scroll_2.maximumZoomScale = 10
        //最小缩放比例
        scroll_2.minimumZoomScale = 0.1
        scroll_2.addSubview(imageView)
        
       
    }
    
    @objc func pageChanged(page: UIPageControl) {
        let rect = CGRect(x: scroll_1.bounds.width*CGFloat(page.currentPage), y: 0, width: scroll_1.bounds.width, height: scroll_1.bounds.height)
        scroll_1.scrollRectToVisible(rect, animated: true)
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentPage = Int(scrollView.contentOffset.x / (self.view.bounds.width - 20))
        page.currentPage = currentPage
    }
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return scroll_2.subviews.first
    }

}

