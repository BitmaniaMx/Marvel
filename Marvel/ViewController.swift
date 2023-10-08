//
//  ViewController.swift
//  Marvel
//
//  Created by Rafael González on 30/09/23.
//

import UIKit
import SDWebImage

class ViewController: UIViewController {

    let myKeys = KeyLoader.shared
    let characterService = CharacterService()
    
    @IBOutlet var characterCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        characterCollectionView.dataSource = self
        characterCollectionView.delegate = self
        
        characterService.loadCharactersData(queryString: myKeys.getQueryString(limit: Constants.numberOfItemsRequested, offset: Constants.initialOffset)){
            
            print("N:", self.myKeys.getQueryString(limit: Constants.numberOfItemsRequested, offset: Constants.initialOffset))
            
            DispatchQueue.main.async {
                self.characterCollectionView.reloadData()
            }
        }
    }
}

extension ViewController : UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return characterService.countCharacter()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "characterCell", for: indexPath) as! CharacterCell
        
        cell.characterName.text = characterService.getCharacter(at: indexPath.row).name
        
        let urlThumbnail = URL(string: characterService.getCharacter(at: indexPath.row).thumbnail.url)

        cell.characterImage.sd_setImage(with: urlThumbnail)
        
        return cell
    }
}

extension ViewController : UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //        size of scrollview content
        //print("contentSize.height", scrollView.contentSize.height)
        //        screen's available space for scrollview element
        //print("bounds.height:", scrollView.bounds.height)
        //        how much the content inside the scroll view has been scrolled vertically
        //print("contentOffset y:", scrollView.contentOffset.y)
        
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let scrollviewHeight = scrollView.bounds.height
        
        if (offsetY > (contentHeight - scrollviewHeight)) && (!characterService.maxItemsLoaded && !characterService.isLoading ){
            //print("calling API...")
            self.characterService.isLoading = true
            let queryString = myKeys.getQueryString(limit: Constants.numberOfItemsRequested, offset: self.characterService.offset)
            
            self.characterService.loadCharactersData(queryString: queryString){
                DispatchQueue.main.async {
                    self.characterCollectionView.reloadData()
                    
                    self.characterService.offset = self.characterService.countCharacter()
                    self.characterService.isLoading = false
                }
            }
        }
        else{
            print("Don't call API...")
        }
    }
}
