//
//  ViewController.swift
//  StudySession
//
//  Created by Jeremy Jung on 11/14/19.
//  Copyright © 2019 Jeremy Jung. All rights reserved.
//

import UIKit

protocol SessionInfoDelegate: class {
    func sessionInfoDelegate()
}

class ViewController: UIViewController {
    
    var collectionView: UICollectionView!
    var sessions: [Session] = []
    
    let studyReuseIdentifier: String = "studyReuseIdentifier"
    let padding: CGFloat = 15

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "Study Sessions"
        view.backgroundColor = .systemGray5
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = padding
        layout.minimumInteritemSpacing = padding
        
        let dateFormat = DateFormatter()
        let timeFormat = DateFormatter()
        let date = Date()
        timeFormat.dateFormat = "h:mm a"
        dateFormat.dateFormat = "MM/dd/yyyy"
        let timeString = timeFormat.string(from: date)
        let dateString = dateFormat.string(from: date)

        
//        let math = Session(name: "Math 1920", date: dateString, time: timeString, description: "I am looking for a partner to study with for prelim 2. I have a decent grade in the class, and I have a flexible schedule.", duration: 2, image: "comsci", location: "Bailey")
//        let history = Session(name: "Hist 2210", date: dateString, time: timeString, description: "I am looking for a partner to study with for prelim 1. I am especially interested in anyone who can help me with the French Revolution.", duration:2, image: "history", location: "Philips")
//        let history2 = Session(name: "Hist 2210", date: dateString, time: timeString, description: "I am looking for a partner to study with for prelim 1. I am especially interested in anyone who can help me with the French Revolution.", duration: 4, image: "history", location: "Philips")
//        sessions = [math, history, history2]

        
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemGray5
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        
        collectionView.register(SessionCollectionViewCell.self, forCellWithReuseIdentifier: studyReuseIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        
        setUpConstraints()
         getSessions()

    }

    func setUpConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding)
        ])
    }
    
    func getSessions() {
        NetworkManager.getSessions { sessions in
            self.sessions = sessions
            DispatchQueue.main.async {
                self.collectionView.reloadData()
        }
    }
    }



}

extension ViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let newView = SessionInfoViewController(sessionObject: sessions[indexPath.row])
        newView.delegate = self
        let modalNavigationVC = UINavigationController(rootViewController: newView)
        navigationController?.present(modalNavigationVC, animated: true, completion: nil)
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sessions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: studyReuseIdentifier, for: indexPath) as! SessionCollectionViewCell
        cell.configure(for: sessions[indexPath.row])
        cell.backgroundColor = .white
        cell.layer.cornerRadius = 8
        return cell
    }
    
    
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (collectionView.frame.width - padding) / 2
        return CGSize(width: size, height: size)
    }
}

extension ViewController: SessionInfoDelegate{
    func sessionInfoDelegate() {
        collectionView.reloadData()
    }
}
