//
//  CFDiaryController.swift
//  CareFree
//
//  Created by 张驰 on 2019/7/28.
//  Copyright © 2019 张驰. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Fuse
import FSCalendar


// MARK:  Register cellID
private let DsearchCellID = "DsearchCell"
private let DwriteDiaryCellID = "DwriteDiaryCell"
private let DshowDiaryCellID = "DshowDiaryCell"


class CFDiaryController: CFBaseViewController {

    
    // 原始所有日记数据
    var originDiaryDatas = [DiaryModel]()
    
    // 搜索日记数据
    var searchDiaryDatas = [DiaryModel]()
    
    // 搜索功能数据
    var filteredBooks = [NSAttributedString]()
    let fuse = Fuse()
    var books = [String]()
    
    // 判断日历控件是否显示
    var isCalendarViewShow = false
    // 日历控件
    lazy var  calendarView: FSCalendar = {
        let calendar = FSCalendar()
        
        calendar.dataSource = self
        calendar.delegate = self
        calendar.backgroundColor = UIColor.white
        calendar.locale = NSLocale(localeIdentifier: "zh-CN") as Locale
        return calendar
    }()
    
    // 搜索大背景
    private lazy var searchView: UIView = {
        let vi = UIView()
        vi.backgroundColor = .white
        return vi
    }()
    
    // 搜索内部圆角背景
    private lazy var searchInteralView: UIView = {
        let vi = UIView()
        vi.backgroundColor = .white
        vi.layer.cornerRadius = 10
        vi.layer.masksToBounds = false
        vi.layer.shadowColor = UIColor(red: 0.43, green: 0.5, blue: 1, alpha: 0.3).cgColor
        vi.layer.shadowOffset = CGSize(width: 0, height: 4)
        vi.layer.shadowOpacity = 1
        vi.layer.shadowRadius = 6
        return vi
    }()
    
    // 搜索
    lazy var searchBar :UITextField = {
        let tf = UITextField()
        tf.placeholder = "搜索"
        //tf.delegate = self
//        tf.clearButtonMode = .whileEditing
        tf.returnKeyType = .go
       // tf.borderStyle = .roundedRect
        tf.delegate = self
        tf.backgroundColor = .clear
        tf.clearButtonMode = .never
        return tf
    }()
    
    private lazy var searchBtn:UIButton = {
       let btn = UIButton()
        btn.setImage(UIImage(named: "diary_icon_search"), for: .normal)
        btn.isUserInteractionEnabled = false
        return btn
    }()
    
    // 右边日历按钮
    private lazy var rightBarButton:UIButton = {
        let button = UIButton.init(type: .custom)
        button.frame = CGRect(x:10, y:0, width:40, height: 40)
        button.addTarget(self, action: #selector(calendarMethod), for: .touchUpInside)
        button.setImage(UIImage(named: "calendar_right"), for: .normal)
        
        //button.backgroundColor = UIColor.red
        return button
    }()
    
    // 主界面控件
    lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        let collection = UICollectionView.init(frame:.zero, collectionViewLayout: layout)
        collection.delegate = self
        collection.dataSource = self
        collection.backgroundColor = UIColor.white
        collection.register(DsearchCell.self, forCellWithReuseIdentifier: DsearchCellID)
        collection.register(DwriteDiaryCell.self, forCellWithReuseIdentifier: DwriteDiaryCellID)
        collection.register(DshowDiaryCell.self, forCellWithReuseIdentifier: DshowDiaryCellID)
        collection.backgroundColor = .white
        collection.showsVerticalScrollIndicator = false
        return collection
    }()
    
    lazy var tapBackView:UIView = {
       let vi = UIView()
        let tap = UITapGestureRecognizer(target: self, action: #selector(closeKey))
        tap.delegate = self
        vi.addGestureRecognizer(tap)
        vi.backgroundColor = UIColor.clear
        return vi
    }()

    var data = [DayDiaryModel]()
    lazy var viewModel:CFDiaryViewModel = {
        return CFDiaryViewModel()
    }()
    
    //MARK: life circle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUI()
        configData()
        initKeyBoardObserver()
        caculateNoteRestDay()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 隐藏日历
        //calendar(self.calendarView, boundingRectWillChange: CGRect(x: 0, y: 0, width: 0, height: 0.fit), animated: true)
        
        if searchDiaryDatas.count != 0 {
            self.viewModel.data = searchDiaryDatas
            self.collectionView.reloadData()
        }else{
            configData()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //self.searchBar.text = ""
    }

    

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
}
// MARK: Config
extension CFDiaryController {
    
    func configUI(){

        
        self.view.backgroundColor = .white
        self.Title.text = "日记"
        self.navigation.bar.barTintColor = .white
        self.navigation.bar.alpha = 1
        self.navigation.item.rightBarButtonItem = UIBarButtonItem.init(customView: rightBarButton)

        configSearchBar()
        self.view.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints{ (make) in
            make.left.equalTo(self.view.snp.left).offset(0)
            make.right.equalTo(self.view.snp.right).offset(0)
            
            make.bottom.equalToSuperview()
            make.top.equalTo(self.searchView.snp.bottom).offset(0.fit)
        }
        self.view.addSubview(tapBackView)
        self.tapBackView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.bottom.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalTo(self.searchView.snp.bottom).offset(0)
        }
        tapBackView.isHidden = true
        configCalendar()
    }
    
    
    func configCalendar() {
        view.addSubview(calendarView)
        calendarView.snp.makeConstraints { (make) in
            make.left.equalTo(self.view.snp.left).offset(0.fit)
            make.right.equalTo(self.view.snp.right).offset(0.fit)
            make.top.equalTo(self.view.snp.top).offset(-280.fit)
            make.height.equalTo(280.fit)
        }
    }
    
    func configSearchBar(){
        view.addSubview(searchView)
        searchView.snp.makeConstraints { (make) in
            make.left.equalTo(self.view.snp.left).offset(20.fit)
            make.right.equalTo(self.view.snp.right).offset(-20.fit)
            make.top.equalTo(self.navigation.bar.snp.bottom).offset(0.fit)
            make.height.equalTo(80.fit)
        }
        searchView.addSubview(searchInteralView)
        searchInteralView.snp.makeConstraints { (make) in
            make.left.equalTo(self.view.snp.left).offset(20.fit)
            make.right.equalTo(self.view.snp.right).offset(-20.fit)
            make.centerY.equalTo(self.searchView.snp.centerY)
            make.height.equalTo(50.fit)
        }
        searchView.addSubview(searchBar)
        searchBar.snp.makeConstraints { (make) in
            make.left.equalTo(self.view.snp.left).offset(40.fit)
            make.right.equalTo(self.view.snp.right).offset(-20.fit)
            make.centerY.equalTo(self.searchView.snp.centerY)
            make.height.equalTo(50.fit)
        }
        searchView.addSubview(searchBtn)
        searchBtn.snp.makeConstraints { (make) in
            make.right.equalTo(self.view.snp.right).offset(-40.fit)
            make.centerY.equalTo(self.searchView.snp.centerY)
            make.width.height.equalTo(30.fit)
        }
    }
    
    func configData(){
        
        viewModel.getLocalDiaryData { (value) in
            self.viewModel.data = value
            self.originDiaryDatas = value
            self.collectionView.reloadData()
        }

        
    }
    
    func initKeyBoardObserver(){
        // 注册键盘监听
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardDisShow(notification:)), name: UIResponder.keyboardDidShowNotification, object: nil)

    }
    
    func caculateNoteRestDay(){
        
        var datas = DataBase.shared.queryNoteAll(isTrash: false)
        
        for index in 0..<datas.count {
            let components = NSCalendar.current.dateComponents([.day], from: datas[index].startDate, to: Date())
            datas[index].restDay -= components.day!
            if datas[index].restDay <= 0 {
                datas[index].restDay = 0
            }
            DataBase.shared.updateStrNote(with: datas[index])
        }

        
    }

}

// MARK: 搜索栏&日历 动画
extension CFDiaryController {

    
    func changeSearchBar(with offsetY:CGFloat) {
        let searchHeight = 80 - offsetY*3
        if searchHeight >= 0.0 {
            self.searchView.snp.updateConstraints { (make) in
                make.height.equalTo(searchHeight.fit)
            }
        }else {
            self.hiddenSearchBar()
        }
    }
    func hiddenSearchBar(){
        UIView.animate(withDuration: 0.5) {
            self.searchView.snp.updateConstraints { (make) in
                make.height.equalTo(0.fit)
            }
        }
    }
    func showSearchBar(){
        UIView.animate(withDuration: 0.5) {
            self.searchView.snp.updateConstraints { (make) in
                make.height.equalTo(80.fit)
            }
        }
    }
}
extension CFDiaryController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section <= 0 {
            return 1
        }
        return self.viewModel.data.count
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0 {
        let cell :DwriteDiaryCell =  collectionView.dequeueReusableCell(withReuseIdentifier: DwriteDiaryCellID, for: indexPath) as! DwriteDiaryCell
            
        cell.writeBtn.addTarget(self, action: #selector(write), for: .touchUpInside)
        let now1 = Date()
        let timeForMatter1 = DateFormatter()
        timeForMatter1.dateFormat = "yyyyMMdd"
        let day_id = timeForMatter1.string(from: now1)
       // cell.delegate = self
        let now = Date()
        let timeForMatter = DateFormatter()
        timeForMatter.dateFormat = "dd yyyy年MM月 HH点mm分 EE"
        let date = timeForMatter.string(from: now)
            cell.day.text = (date as NSString).substring(to: 2)
            cell.yearMouth.text = (date as NSString).substring(with: NSMakeRange(3,8))
            var weekText:String?
            switch (date as NSString).substring(from: 19) {
            case "Mon":
                weekText = "周一"
            case "Tue":
                weekText = "周二"
            case "Wed":
                weekText = "周三"
            case "Thu":
                weekText = "周四"
            case "Fri":
                weekText = "周五"
            case "Sat":
                weekText = "周六"
            default:
                weekText = "周日"
            }
            cell.week.text = weekText
            cell.delegate = self
        return cell
        }else {
            let cell :DshowDiaryCell = collectionView.dequeueReusableCell(withReuseIdentifier: DshowDiaryCellID, for: indexPath) as! DshowDiaryCell
            //cell.conten = diaryData[indexPath.row]
            cell.updateUI(with: self.viewModel.data[indexPath.row])
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            return CGSize(width: CFWidth, height: 160.fit)
        }else {
            return CGSize(width: CFWidth, height: 180.fit)
        }
    }
    //每个分区的内边距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 20.fit, left: 0, bottom: 20.fit, right: 0)
        
    }
    
    //最小 item 间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20.fit
    }
    
    //最小行间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20.fit
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
            return CGSize(width: 0 , height: 0)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 1{
            let vc = DiaryDetailViewController()
            vc.diaryData = self.viewModel.data[indexPath.row]
            
//            let vc = ShowViewController(with: self.viewModel.datas[indexPath.row])
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

// MARK: 滑动代理
extension CFDiaryController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        print(offsetY)
        if offsetY <= 0 {
            self.showSearchBar()
        }else {
            self.changeSearchBar(with: offsetY)
        }
    }
}

// MARK: 解决手势冲突
extension CFDiaryController: UIGestureRecognizerDelegate {

    // 手势冲突
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if (touch.view?.isDescendant(of: self.collectionView))!{
            return false
        }
        return true
    }
}
// MARK: go 键盘 return 监听
extension CFDiaryController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text == "" {
            self.viewModel.data = originDiaryDatas
            self.collectionView.reloadData()
        }

    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        filterContentForSearchText(textField.text!)
        return true
    }
}
