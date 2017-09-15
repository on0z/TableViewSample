//
//  ViewController.swift
//  UITableViewSample
//
//  Created by on0z on 2017/09/15.
//  Copyright © 2017年 sample. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        print(#function)
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView = UITableView(frame: self.view.frame, style: .plain)
        //tableView = UITableView(frame: self.view.frame, style: .grouped)
        
        //tableViewのdataSourceを自分に設定
        tableView.dataSource = self
        //tableViewのdelegateを自分に設定
        tableView.delegate = self
        
        //tableViewは「セルを使い回す」ことによって, 処理を軽量化させています.
        //tableViewに「使い回すセル」を文字列(Identifier)と紐付けて管理します。
        //Identifierを使ってtableView(_:cellForIndexPath:)内で取得します。
        //以下のようにしてtableViewに「使い回すセル」を追加します。
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        self.view.addSubview(tableView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController: UITableViewDataSource{
    
    //セクションの数を返す
    func numberOfSections(in tableView: UITableView) -> Int {
        print(#function)
        return 5
    }
    
    //<必須>各セクションのRowの数(セルの数)を返す
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(#function)
        switch section{
        case 0: return 10
        default: return 10
        }
    }
    
    //<必須>各indexにおけるセルを返す
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(#function)
        //セルをIdentifierとindexPathから特定して取得
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "セル \(indexPath.section) - \(indexPath.row)"
        return cell
    }
    
    //セクションヘッダーのタイトルを返す
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        print(#function)
        return "ヘッダー セクション\(section)"
    }
    
    //セクションフッターのタイトルを返す
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        print(#function)
        return "フッター セクション\(section)"
    }
    
    //Editing セルの編集に関わる関数
    //セルに編集を許すかどうかを返す
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        print(#function)
        //この場合は偶数セルのみ許可する
        return indexPath.row % 2 == 0
    }
    
    //セルに移動を許すかどうかを返す
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        print(#function)
        //この場合は偶数セルのみ許可する
        return indexPath.row % 2 == 0
    }
    
    //Index TableViewの右端に出てくる目次みたいなやつのこと
    //右端に出てくるやつのタイトルをStringの配列で返す
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        print(#function)
        return ["0", "1", "2", "3", "4"]
    }
    
    //Indexを選択された時にどのセクションに飛ぶかを返す
    func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        print(#function)
        return index
    }
    
    //セルの追加と削除に関する関数
    
    //削除された時や追加された時の処理をかく
    //この関数は, 後述のtableView(_, editActionsForRowAt)を実装している場合, そちらが優先され, こちらは呼ばれない. だから滅多に使われない.
    //もしこのメソッドが使われているサイトがあっても, あまり参考にしなくていいだろう.
    //中身は例。
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//        print(#function)
//        if editingStyle == .delete{
//            //削除処理...
//        }
//    }
    
    //セルを移動した時の処理をかく
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        print(#function)
        // sourceIndexPath: 移動前の位置
        // destinationIndexPath: 移動後の位置
        
        //移動処理を行う.基本的にアニメーションは自動でやってくれるので入れない.
    }
    
}

extension ViewController: UITableViewDelegate{
    
    // Selection セルの選択に関する
    
    // Called before the user changes the selection. Return a new indexPath, or nil, to change the proposed selection.
    //選択状態が変更される前に呼ばれる. 別のindexPathやnilを返して, 対象のセルを変更します.
    //セルが選択される直前に呼ばれる関数. nilを返せば, セルを選択できなくできる
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath?{
        print(#function)
        print("willSelected cell \(indexPath.section) - \(indexPath.row)")
        return indexPath
    }
    
    //セルが選択解除される直前に呼ばれる関数. nilを返せば, セルを選択解除できなくできる
    func tableView(_ tableView: UITableView, willDeselectRowAt indexPath: IndexPath) -> IndexPath?{
        print(#function)
        print("willDeselected cell \(indexPath.section) - \(indexPath.row)")
        return indexPath
    }
    
    // Called after the user changes the selection. 選択状態が変更された後に呼ばれる.
    //セルが選択された後に呼ばれる関数.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        print(#function)
        print("didSelected cell \(indexPath.section) - \(indexPath.row)")
    }
    
    //セルが選択解除された後に呼ばれる関数.
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath){
        print(#function)
        print("didDeSelected cell \(indexPath.section) - \(indexPath.row)")
    }
    
    //セルをスワイプした時に出るアクションボタンを設定
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .destructive, title: "削除"){
            (action, indexPath) in
            //<注意>先に削除処理をしてからアニメーションを実行すること
            //当サンプルではDataSourceをしっかり設定していないので, 下のdeleteRows(at:)をアンコメントアウトすると落ちます.
//            self.tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        
        let custom1 = UITableViewRowAction(style: .normal, title: "cstm1"){
            (action, indexPath) in
            //カスタムアクション...
        }
        return [delete, custom1]
    }
    
}

