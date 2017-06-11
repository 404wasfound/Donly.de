//
//  ConversationVC.swift
//  Donly.de
//
//  Created by Bogdan Yur on 6/10/17.
//  Copyright © 2017 404wasfound. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import JSQMessagesViewController

protocol ConversationVCProtocol {
  func showIndicator()
  func hideIndicator()
  func endSendingMessage()
}

class ConversationVC: JSQMessagesViewController {
  
  fileprivate var viewModel: ConversationViewModelProtocol?
  private var disposeBag = DisposeBag()
  lazy var outgoingBubbleImageView: JSQMessagesBubbleImage = self.setupOutgoingMessageBubble()
  lazy var incomingBubbleImageView: JSQMessagesBubbleImage = self.setupIncomingMessageBubble()
  
  init(withViewModel viewModel: ConversationViewModelProtocol) {
    self.viewModel = viewModel
    super.init(nibName: String(describing: ConversationVC.self), bundle: nil)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    self.navigationController?.navigationBar.tintColor = donlyColor
    self.collectionView.collectionViewLayout.incomingAvatarViewSize = CGSize.zero
    self.collectionView.collectionViewLayout.outgoingAvatarViewSize = CGSize.zero
    self.setupInputToolbar()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    viewModel?.delegate = self
    viewModel?.getMessagesForConversation()
    setupBindings()
    self.senderDisplayName = appData.user?.fullName
    if let user = appData.user {
      self.senderId = "\(user.id)"
    } else {
      self.senderId = ""
    }
  }
  
  func setupBindings() {
    viewModel?.messages.asObservable().bind(onNext: { messages in
      if let newMessages = messages {
        print("Messages are here! (In number of: \(newMessages.count))")
        self.collectionView.reloadData()
      }
    }).addDisposableTo(disposeBag)
  }

}

extension ConversationVC {
  override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageDataForItemAt indexPath: IndexPath!) -> JSQMessageData! {
    guard let messages = viewModel?.messages.value else {
      return nil
    }
    return messages[indexPath.row]
  }
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    guard let messages = viewModel?.messages.value else {
      return 0
    }
    return messages.count
  }

  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = super.collectionView(collectionView, cellForItemAt: indexPath) as? JSQMessagesCollectionViewCell, let messages = viewModel?.messages.value else {
      return UICollectionViewCell()
    }
    let message = messages[indexPath.row]
    if message.senderId == self.senderId {
      cell.textView.textColor = UIColor.white
    } else {
      cell.textView.textColor = UIColor.black
    }
    return cell
  }
  
  override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAt indexPath: IndexPath!) -> JSQMessageBubbleImageDataSource! {
    guard let messages = viewModel?.messages.value else {
      return nil
    }
    let message = messages[indexPath.row]
    if message.senderId == self.senderId {
      return outgoingBubbleImageView
    } else {
      return incomingBubbleImageView
    }
  }
  
  override func collectionView(_ collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAt indexPath: IndexPath!) -> JSQMessageAvatarImageDataSource! {
    return nil
  }
  
  func setupOutgoingMessageBubble() -> JSQMessagesBubbleImage {
    return JSQMessagesBubbleImageFactory().outgoingMessagesBubbleImage(with: UIColor.jsq_messageBubbleBlue())
  }
  
  func setupIncomingMessageBubble() -> JSQMessagesBubbleImage {
    return JSQMessagesBubbleImageFactory().incomingMessagesBubbleImage(with: UIColor.jsq_messageBubbleLightGray())
  }
  
  override func didPressSend(_ button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: Date!) {
    viewModel?.sendMessage(withText: text)
  }
  
  func setupInputToolbar() {
    self.inputToolbar.contentView.leftBarButtonItem = nil
    let frame = CGRect(x: 0.0, y: 0.0, width: 35.0, height: 35.0)
    let sendButton = UIButton(frame: frame)
    sendButton.setImage(UIImage(named:"send_message"), for: .normal)
    sendButton.backgroundColor = donlyColor
    sendButton.layer.cornerRadius = 4.0
    sendButton.imageEdgeInsets = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
    sendButton.imageView?.contentMode = .scaleAspectFit
    sendButton.contentHorizontalAlignment = .center
    self.inputToolbar.contentView.rightBarButtonItem = sendButton
    self.inputToolbar.sendButtonOnRight = true
  }
  
}

extension ConversationVC: ConversationVCProtocol {
  func showIndicator() {
    self.showActivityIndicator()
  }
  
  func hideIndicator() {
    self.hideActivityIndicator()
  }
  
  func endSendingMessage() {
    self.finishSendingMessage()
  }
}
