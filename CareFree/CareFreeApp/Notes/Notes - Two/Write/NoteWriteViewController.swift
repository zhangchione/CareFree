//
//  NoteWriteViewController.swift
//  CareFree
//
//  Created by 张驰 on 2020/5/16.
//  Copyright © 2020 张驰. All rights reserved.
//

import UIKit
import ProgressHUD

enum NoteWriteControllerType {
    case shorTimeGrade
    case fristGrade
    case secendGrade
    case threeGrade
    case markGrade
}

extension Character {
    var isNumber: Bool {
        return Int(String(self)) != nil
    }
}

let NoteWtriteTextPlaceHolder = "一万年太久,只争朝夕。"

class NoteWriteViewController: UIViewController {
    
    var typeDatas = [NoteTypeModel]()
    
    private var type:NoteWriteControllerType? //记录类型
    
    // 数据
    public var noteWriteData = CFNotesModel()
    
    convenience init(_ data:CFNotesModel,type:NoteWriteControllerType){
        self.init()
        self.noteWriteData = data
        self.type = type
    }
    
    lazy var backView:UIView = {
       let vi = UIView()
        vi.backgroundColor = markGradeColor
        vi.layer.cornerRadius = 15.fit
        return vi
    }()
    
    lazy var markBtn:UIButton = {
       let btn = UIButton()
        btn.setTitle("", for: .normal)
        btn.setTitleColor(UIColor.init(r: 73, g: 73, b: 73), for: .normal)
        return btn
    }()
    
    lazy var noteTitleLabel :UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20.fit)
        label.textColor = .black
        label.text = shortTimeGradeText
        label.textAlignment = .center
        return label
    }()
    lazy var hoursLabel : UILabel = {
       let label = UILabel()
        label.text = "Date: 01:50"
        label.font = UIFont.init(name: "PingFangSC-Regular", size: 13.fit)
        label.textColor = UIColor.init(r: 138, g: 138, b: 138)
        label.textAlignment = .left
        return label
    }()
    
    lazy var weekLabel : UILabel = {
       let label = UILabel()
        label.text = "星期六"
        label.font = UIFont.init(name: "PingFangSC-Regular", size: 14.fit)
        label.textColor = UIColor.init(r: 138, g: 138, b: 138)
        label.textAlignment = .left
        return label
    }()
    
    lazy var line: UIView = {
        let vi = UIView()
        vi.backgroundColor = .lightGray
        vi.alpha = 0.3
        return vi
    }()
    
    
    // 编辑区域
    lazy var textView : UITextView = {
        let tv = UITextView()
        tv.backgroundColor = UIColor.clear
        tv.font = UIFont.systemFont(ofSize: 20.fit)
        tv.textColor = UIColor.lightGray
        tv.text = NoteWtriteTextPlaceHolder
        tv.delegate = self
        return tv
    }()
    
    
    // 类型选择
    lazy var selectedTypeCollection:UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 15.fit
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 60.fit, height:60.fit)
        let collection = UICollectionView.init(frame:CGRect(x:100, y:50, width:265, height:180), collectionViewLayout: layout)
        collection.backgroundColor = UIColor.white
        collection.delegate = self
        collection.dataSource = self
        collection.register(NoteTypeCell.self, forCellWithReuseIdentifier: "NoteTypeCellID")
        collection.showsVerticalScrollIndicator = false
        collection.showsHorizontalScrollIndicator = false
        return collection
    }()
    
    lazy var restDayView: RestDaySelectedView = {
        let restDatView = RestDaySelectedView()
        restDatView.callback =  {
            self.alertViewShoww(with: "倒计时天数") { (value) in
                if self.checkdigit(with: value) {
                    restDatView.updateUI(with: Int(value)!)
                    self.noteWriteData.restDay = Int(value)!
                }else{
                    ProgressHUD.showError("非法输入，请检查")
                }
            }
        }
       return restDatView
    }()
    
    func checkdigit(with str:String) -> Bool{
        var result = true
        str.forEach { (ch) in
            guard ch.isNumber else {
                result = false
                return
            }
        }
        if str.count >= 6 {
            result = false
        }
        return result
    }
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.delegate = self
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
        
    lazy var contentView:UIView = {
        let vi = UIView()
        return vi
    }()
    
    
    
    // 左边返回按钮
    private lazy var leftBarButton:UIButton = {
        let button = UIButton.init(type: .custom)
        button.frame = CGRect(x:10, y:0, width:30, height: 30)
        let imageView = UIImageView()
        imageView.image = UIImage(named: "hone_icon_back")?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = UIColor.black
        button.tintColor = UIColor.black
        button.setImage(imageView.image, for: .normal)
        //button.titleLabel?.font = UIFont.systemFont(ofSize: 26)
        button.addTarget(self, action: #selector(back), for: UIControl.Event.touchUpInside)
        button.setTitleColor(UIColor.white, for: .normal)
        return button
    }()
    
    
    // 右边完成按钮
    private lazy var rightBarButton:UIButton = {
        let button = UIButton.init(type: .custom)
        button.frame = CGRect(x:10, y:0, width:30, height: 30)
        let imageView = UIImageView()
        imageView.image = UIImage(named: "write_icon_check")?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = UIColor.black
        button.tintColor = UIColor.black
        button.setImage(imageView.image, for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(save), for: UIControl.Event.touchUpInside)
        button.setTitleColor(UIColor.black, for: .normal)
        return button
    }()
    
    // 左边删除按钮
    private lazy var rightDeleteBarButton:UIButton = {
        let button = UIButton.init(type: .custom)
        button.frame = CGRect(x:10, y:0, width:25, height: 25)
        //button.setTitle("删除", for: .normal)
        
        button.setImage(UIImage(named: "write_icon_delete"), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.addTarget(self, action: #selector(deleteNote), for: UIControl.Event.touchUpInside)
        button.setTitleColor(UIColor.white, for: .normal)
        
        //button.tintColor = UIColor.white
        return button
    }()
    
    // MARK: life Circle
    override func viewDidLoad() {
        super.viewDidLoad()

       configUI()
        configNav()

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.updateTypeData(with: self.type!)
        self.selectedTypeCollection.reloadData()
        initText()
    }

    
    private func configShadow(){
        self.backView.backgroundColor = .white
        self.backView.layer.cornerRadius = 15.fit
        self.backView.layer.masksToBounds = false
        self.backView.layer.shadowColor = UIColor(red: 0.43, green: 0.5, blue: 1, alpha: 0.3).cgColor
        self.backView.layer.shadowOffset = CGSize(width: 0, height: 4.fit)
        self.backView.layer.shadowOpacity = 1
        self.backView.layer.shadowRadius = 12.fit
    }
    func configUI(){
        view.backgroundColor = .white
        let tap = UITapGestureRecognizer(target: self, action: #selector(closeKey))
        tap.delegate = self
        view.addGestureRecognizer(tap)
        
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.left.top.right.bottom.equalToSuperview()
        }
        scrollView.addSubview(contentView)
        
        contentView.snp.makeConstraints { (make) in
            make.edges.equalTo(scrollView)
            make.width.equalTo(scrollView)
            make.height.equalTo(CFHeight)
        }
        
        contentView.addSubview(backView)
        backView.snp.makeConstraints { (make) in
            make.left.equalTo(scrollView.snp.left).offset(20.fit)
            make.right.equalTo(scrollView.snp.right).offset(-20.fit)
            make.top.equalTo(scrollView.snp.top).offset(10.fit)
            make.bottom.equalTo(scrollView.snp.bottom).offset(-kTabBarHeight-150.fit)
            //make.height.equalTo(CFHeight-kNavBarAndStatusBarHeight-kTabBarHeight-110.fit)
        }
        configShadow()
        
        contentView.addSubview(noteTitleLabel)
        noteTitleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(scrollView.snp.top).offset(20.fit)
            make.height.equalTo(30.fit)
            make.centerX.equalTo(view)
        }
        
        contentView.addSubview(markBtn)
        markBtn.snp.makeConstraints { (make) in
            make.centerY.equalTo(noteTitleLabel)
            make.height.width.equalTo(20.fit)
            make.left.equalTo(scrollView.snp.left).offset(30.fit)
        }
        
        contentView.addSubview(hoursLabel)
        hoursLabel.snp.makeConstraints { (make) in
            make.top.equalTo(scrollView.snp.top).offset(55.fit)
            make.height.equalTo(25.fit)
            make.left.equalTo(scrollView.snp.left).offset(30.fit)
            make.width.equalTo(70.fit)
        }
        contentView.addSubview(weekLabel)
        weekLabel.snp.makeConstraints { (make) in
            make.top.equalTo(scrollView.snp.top).offset(55.fit)
            make.height.equalTo(25.fit)
            make.left.equalTo(scrollView.snp.left).offset(120.fit)
            make.width.equalTo(60.fit)
        }
        contentView.addSubview(line)
        line.snp.makeConstraints { (make) in
            make.top.equalTo(scrollView.snp.top).offset(81.fit)
            make.height.equalTo(0.5)
            make.right.equalTo(scrollView.snp.right).offset(-30.fit)
            make.left.equalTo(scrollView.snp.left).offset(30.fit)
        }
        contentView.addSubview(textView)
        textView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(25.fit)
            make.right.equalToSuperview().offset(-25.fit)
            make.top.equalTo(scrollView.snp.top).offset(85.fit)
            make.bottom.equalTo(backView.snp.bottom).offset(-10.fit)
        }
        
        contentView.addSubview(selectedTypeCollection)
        selectedTypeCollection.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(20.fit)
            make.right.equalToSuperview().offset(-20.fit)
            make.top.equalTo(backView.snp.bottom).offset(10.fit)
            make.height.equalTo(70.fit)
        }
        contentView.addSubview(restDayView)
        restDayView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(27.fit)
            make.right.equalToSuperview().offset(-27.fit)
            make.top.equalTo(backView.snp.bottom).offset(90.fit)
            make.height.equalTo(40.fit)
        }
        
        
    }
    
    func configNav(){
        self.navigation.bar.barTintColor = .white
        self.navigation.bar.isShadowHidden = true
        self.navigation.bar.alpha = 1
        self.navigation.bar.titleTextAttributes = [.foregroundColor: UIColor.black]
        self.navigation.item.rightBarButtonItem = UIBarButtonItem.init(customView: rightBarButton)
        
        if self.noteWriteData.id != -1 {
            self.navigation.item.leftBarButtonItems = [UIBarButtonItem.init(customView: leftBarButton),UIBarButtonItem.init(customView: rightDeleteBarButton)]
            let date = noteWriteData.date
            let timeForMatter = DateFormatter()
            timeForMatter.dateFormat = "MM月dd日"
            let mouthDaytext = timeForMatter.string(from: date)
            self.navigation.item.title = mouthDaytext
        }else {
             self.navigation.item.leftBarButtonItem = UIBarButtonItem.init(customView: leftBarButton)
             self.navigation.item.title = DateInfo.shared.todayText
        }

        
       
    }
    
    func updateTypeData(with type:NoteWriteControllerType) {
        
        self.typeDatas.removeAll()
        
        var shortItem = NoteTypeModel(gradeColor: shortTimeGradeColor, isSelected: false)
        var firstItem = NoteTypeModel(gradeColor: firstGradeColor, isSelected: false)
        var secendItem = NoteTypeModel(gradeColor: secendGradeColor, isSelected: false)
        var threeItem = NoteTypeModel(gradeColor: threeGradeColor, isSelected: false)
        var markItem = NoteTypeModel(gradeColor: markGradeColor, isSelected: false)
        switch type {
        case .shorTimeGrade:
            shortItem.isSelected = true
            self.backView.backgroundColor = shortTimeGradeColor
        case .fristGrade:
            firstItem.isSelected = true
            self.backView.backgroundColor = firstGradeColor
        case .secendGrade:
            secendItem.isSelected = true
            self.backView.backgroundColor = secendGradeColor
        case .threeGrade:
            threeItem.isSelected = true
            self.backView.backgroundColor = threeGradeColor
        case .markGrade:
            markItem.isSelected = true
            self.backView.backgroundColor = markGradeColor
        }
        self.typeDatas.append(shortItem)
        self.typeDatas.append(firstItem)
        self.typeDatas.append(secendItem)
        self.typeDatas.append(threeItem)
        self.typeDatas.append(markItem)
    }
    
    func setLabelWhiteTextColor(with color:UIColor) {
        self.noteTitleLabel.textColor = color
        self.hoursLabel.textColor = color
        self.weekLabel.textColor = color
        //self.textView.textColor = color
    }
    
    func initText() {
        switch type {
         case .shorTimeGrade:
             self.noteWriteData.title = shortTimeGradeText
             setLabelWhiteTextColor(with: UIColor.black)
             self.textView.textColor = .lightGray
         case .fristGrade:
             self.noteWriteData.title = firstGradeText
             setLabelWhiteTextColor(with: UIColor.white)
         case .secendGrade:
             self.noteWriteData.title = secendGradeText
             setLabelWhiteTextColor(with: UIColor.white)
         case .threeGrade:
             self.noteWriteData.title = threeGradeText
             setLabelWhiteTextColor(with: UIColor.white)
         case .markGrade:
             self.noteWriteData.title = markGradeText
             setLabelWhiteTextColor(with: UIColor.white)
        default: break
        }
        if noteWriteData.id == -1 {
            self.hoursLabel.text = "Date: "
            let date = Date()
            let dateFmt = DateFormatter()
            dateFmt.dateFormat = "yyyy-MM-dd"
            let weektext = date.getWeekDay(dateTime: dateFmt.string(from: date))
            self.weekLabel.text = weektext
        }else {
            let date = noteWriteData.date
            let timeForMatter = DateFormatter()
            timeForMatter.dateFormat = "HH:mm"
            let hourstext = timeForMatter.string(from: date)
             self.hoursLabel.text = "Date: \(hourstext)"
            
            let dateFmt = DateFormatter()
            dateFmt.dateFormat = "yyyy-MM-dd"
            let weektext = date.getWeekDay(dateTime: dateFmt.string(from: date))
            self.weekLabel.text = weektext
            
            self.textView.text = noteWriteData.content
            
            if type! == .shorTimeGrade {
                self.textView.textColor = .black
            }else {
                self.textView.textColor = .white
            }
            restDayView.updateUI(with: noteWriteData.restDay)
        }
    }

}

// MARK: 解决手势冲突
extension NoteWriteViewController: UIGestureRecognizerDelegate {

    // 手势冲突
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if (touch.view?.isDescendant(of: self.selectedTypeCollection))!{
            return false
        }
        return true
    }
}

// MARK: objc Mothed
extension NoteWriteViewController{
    @objc func back(){
        self.navigationController?.popViewController(animated: true)
    }
    @objc func save(){
       switch type {
        case .shorTimeGrade:
            self.noteWriteData.priority = 0
            self.noteWriteData.title = shortTimeGradeText
        case .fristGrade:
            self.noteWriteData.priority = 1
            self.noteWriteData.title = firstGradeText
        case .secendGrade:
            self.noteWriteData.priority = 2
            self.noteWriteData.title = secendGradeText
        case .threeGrade:
            self.noteWriteData.priority = 3
            self.noteWriteData.title = threeGradeText
        case .markGrade:
            self.noteWriteData.priority = 10001
            self.noteWriteData.title = markGradeText
       default: break
       }
        if self.noteWriteData.id == -1 {
            self.noteWriteData.content = self.textView.text!
            self.noteWriteData.dateStr = DateInfo.shared.todayText
            self.noteWriteData.date = Date()
            self.noteWriteData.startDate = Date()
            
            if let rowId = DataBase.shared.insertNote(with: noteWriteData) {
                self.noteWriteData.id = Int(rowId)
                ProgressHUD.showSuccess("记录成功")
                self.navigationController?.popViewController(animated: true)
            }else {
                ProgressHUD.showError("记录失败")
            }
            
        }else {
            self.noteWriteData.content = self.textView.text!
            if  DataBase.shared.updateStrNote(with: noteWriteData) {
                ProgressHUD.showSuccess("修改成功")
                self.navigationController?.popToRootViewController(animated: true)
            }else {
                ProgressHUD.showError("修改失败")
            }
        }

        

        
    }
    @objc func deleteNote(){
        guard self.noteWriteData.id != -1 else {
            ProgressHUD.showSuccess("移除失败")
            return
        }
        guard DataBase.shared.changeNoteInTrashStatus(at: noteWriteData.id,with: true) else {
            ProgressHUD.showError("移除失败")
            return
        }
        ProgressHUD.showSuccess("成功移到废纸篓")
        self.navigationController?.popToRootViewController(animated: true)
        
    }
    @objc func closeKey(){
        self.view.endEditing(false)
    }
    
}
extension NoteWriteViewController:UITextViewDelegate {

    func textViewShouldBeginEditing(_ content: UITextView) -> Bool {
        if (content.text == NoteWtriteTextPlaceHolder) {
            content.text = ""
        }
        if self.type! == .shorTimeGrade {
            content.textColor = .black
        }else{
            content.textColor = .white
        }
        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if (textView.text == "") {
            textView.text = NoteWtriteTextPlaceHolder
        }
        
        textView.textColor = .lightGray
    }
    
}
extension NoteWriteViewController: UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(scrollView.contentOffset.y)
    }
}
extension NoteWriteViewController:UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return    typeDatas.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NoteTypeCellID", for: indexPath) as! NoteTypeCell
        cell.updateUI(with: typeDatas[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            self.type = .shorTimeGrade
            self.noteTitleLabel.text = shortTimeGradeText
            setLabelWhiteTextColor(with: UIColor.black)
        case 1:
            self.type = .fristGrade
            self.noteTitleLabel.text = firstGradeText
            setLabelWhiteTextColor(with: UIColor.white)
        case 2:
            self.type = .secendGrade
            self.noteTitleLabel.text = secendGradeText
            setLabelWhiteTextColor(with: UIColor.white)
        case 3:
            self.type = .threeGrade
            self.noteTitleLabel.text = threeGradeText
            setLabelWhiteTextColor(with: UIColor.white)
        case 4:
            self.type = .markGrade
            self.noteTitleLabel.text = markGradeText
            setLabelWhiteTextColor(with: UIColor.white)
        default:
            break;
        }
        self.updateTypeData(with: self.type!)
        self.selectedTypeCollection.reloadData()
    }
}
