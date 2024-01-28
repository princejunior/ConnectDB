//
//  Details.swift
//  ConnectDB
//
//  Created by Elijah Elliott on 1/27/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct Details: View {
    
    let userItem : DataTypes

    
    var body: some View {
        GeometryReader { geo in
            VStack {
                Text("Username : \(userItem.title)")
                    .font(.title)
                
                AnimatedImage(url: URL(string: userItem.image))
                    .resizable().frame(height:geo.size.height - 100)
                    .padding(.horizontal, 15)
                    .cornerRadius(20)
            }
        }
    }
}

//#Preview {
//    Details(userItem: DataTypes)
//}
