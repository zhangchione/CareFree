//
//  NotesTypeSelectedView.swift
//  CareFree
//
//  Created by 张驰 on 2020/5/16.
//  Copyright © 2020 张驰. All rights reserved.
//

import UIKit


class NotesTypeSelectedCell: UIView {
    lazy var titleLabel:UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.text = "所有贴纸"
        label.textAlignment = .center
        label.font = UIFont.init(name: "PingFangSC-Semibold", size: 16.fit)
        return label
    }()
    
    lazy var btn:UIButton = {
        let vi = UIButton()
        vi.backgroundColor = .clear
        return vi
    }()
    
    init() {
        super.init(frame: .zero)
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configUI(){
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.center.equalTo(self)
            make.height.equalTo(30.fit)
            make.width.equalTo(100.fit)
        }
        addSubview(btn)
        btn.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}


protocol NoteTypeSelectedViewDelegate: class {
    func selectedViewCallBack(with data:[Int])
}

class NotesTypeSelectedView: UIView {
    
    weak var delegate:NoteTypeSelectedViewDelegate?
    
    lazy var shortAndTaskView: NotesTypeSelectedCell = {
       let cell = NotesTypeSelectedCell()
        cell.titleLabel.text = "临时&任务"
        cell.btn.addTarget(self, action: #selector(shortAndTaskMothed), for: .touchUpInside)
        cell.backgroundColor = UIColor.init(r: 31, g: 128, b: 238)
        return cell
    }()
    @objc func shortAndTaskMothed(){
        delegate?.selectedViewCallBack(with: [0,1,2,3])
    }
    
    lazy var taskView: NotesTypeSelectedCell = {
       let cell = NotesTypeSelectedCell()
        cell.titleLabel.text = "任务贴纸"
        cell.backgroundColor = UIColor.init(r: 245, g: 88, b: 133)
        cell.btn.addTarget(self, action: #selector(taskMothed), for: .touchUpInside)
        return cell
    }()
    @objc func taskMothed(){
        delegate?.selectedViewCallBack(with: [1,2,3])
    }
    
    lazy var shortView: NotesTypeSelectedCell = {
       let cell = NotesTypeSelectedCell()
        cell.titleLabel.text = "临时贴纸"
        cell.backgroundColor = UIColor.init(r: 199, g: 190, b: 240)
        cell.btn.addTarget(self, action: #selector(shortMothed), for: .touchUpInside)
        return cell
    }()
    
    @objc func shortMothed(){
        delegate?.selectedViewCallBack(with: [0])
    }
    lazy var allNotesView: NotesTypeSelectedCell = {
       let cell = NotesTypeSelectedCell()
        cell.titleLabel.text = "所有贴纸"
        cell.backgroundColor = UIColor.init(r: 33, g: 69, b: 99)
        cell.btn.addTarget(self, action: #selector(allNoteMothed), for: .touchUpInside)
        return cell
    }()
    @objc func allNoteMothed(){
        delegate?.selectedViewCallBack(with: [0,1,2,3,10001])
    }
    
    init() {
        super.init(frame: .zero)
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configUI(){
        self.backgroundColor = .white
        addSubview(shortAndTaskView)
        shortAndTaskView.snp.makeConstraints { (make) in
            make.left.top.equalTo(self).offset(20.fit)
            make.width.equalTo((CFWidth-70.fit)/2)
            make.height.equalTo(150.fit)
        }
        addSubview(taskView)
        taskView.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(20.fit)
            make.right.equalToSuperview().offset(-20.fit)
            make.width.equalTo((CFWidth-70.fit)/2)
            make.height.equalTo(150.fit)
        }
        addSubview(shortView)
        shortView.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(20.fit)
            make.bottom.equalToSuperview().offset(-20.fit)
            make.width.equalTo((CFWidth-70.fit)/2)
            make.height.equalTo(150.fit)
        }
        addSubview(allNotesView)
        allNotesView.snp.makeConstraints { (make) in
            make.bottom.equalTo(self).offset(-20.fit)
            make.right.equalToSuperview().offset(-20.fit)
            make.width.equalTo((CFWidth-70.fit)/2)
            make.height.equalTo(150.fit)
        }
    }

}
