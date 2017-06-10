//
//  ConversationScene.swift
//  Donly.de
//
//  Created by Bogdan Yur on 6/10/17.
//  Copyright © 2017 404wasfound. All rights reserved.
//

import Foundation

class ConversationScene {
  
  static func configure(forConversationId id: Int) -> ConversationVC {
    let viewModel = ConversationViewModel(withConversationId: id)
    return ConversationVC(withViewModel: viewModel)
  }
  
}
