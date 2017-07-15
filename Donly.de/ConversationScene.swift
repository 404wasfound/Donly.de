//
//  ConversationScene.swift
//  Donly.de
//
//  Created by Bogdan Yur on 6/10/17.
//  Copyright © 2017 404wasfound. All rights reserved.
//

import Foundation

class ConversationScene {
  
  static func configure(forConversation conversation: Conversation, withConvsVM convsVM: ConversationsViewModel) -> ConversationVC {
    let viewModel = ConversationViewModel(withConversation: conversation, withConvsVM: convsVM)
    return ConversationVC(withViewModel: viewModel)
  }
  
}
