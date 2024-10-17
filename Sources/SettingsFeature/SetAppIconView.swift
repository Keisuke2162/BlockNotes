//
//  SetAppIconView.swift
//  BlockNotes
//
//  Created by Kei on 2024/10/17.
//

import SwiftUI

public struct SetAppIconView: View {
  @EnvironmentObject var settings: AppSettingsService
  @Environment(\.dismiss) var dismiss
  let buttonWidth: CGFloat = 48
  let checkMarkIconPadding: CGFloat = 8
  let buttonRadius: CGFloat = 8
  
  @State private var largeColorItem: AppIconColor = .blue
  @State private var mediumColorItem: AppIconColor = .red
  @State private var smallColorItem: AppIconColor = .green
  
  private var appIconImageName: String {
    "AppIconImage\(largeColorItem.colorSymbol)\(mediumColorItem.colorSymbol)\(smallColorItem.colorSymbol)"
  }
  private var homeIconName: String {
    "AppIcon-\(largeColorItem.colorSymbol)\(mediumColorItem.colorSymbol)\(smallColorItem.colorSymbol)"
  }
  
  public init() {
  }

  public var body: some View {
    VStack(spacing: 64) {
      Spacer()
      Image(appIconImageName)
        .resizable()
        .aspectRatio(1, contentMode: .fit)
        .frame(width: 128, height: 128)
      
      VStack(spacing: 16) {
        // MARK: Large Icon
        HStack(spacing: 16) {
          Text("大アイコン")
          Button {
            largeColorItem = .red
          } label: {
            Image(systemName: "checkmark")
              .padding(8)
              .foregroundStyle(
                self.largeColorItem == .red ? .white : .clear
              )
          }
          .frame(width: buttonWidth, height: buttonWidth)
          .background(AppIconColor.red.appIconColor)
          .clipShape(.rect(cornerRadius: buttonRadius))
          
          Button {
            largeColorItem = .green
          } label: {
            Image(systemName: "checkmark")
              .padding(8)
              .foregroundStyle(
                self.largeColorItem == .green ? .black : .clear
              )
          }
          .frame(width: buttonWidth, height: buttonWidth)
          .background(AppIconColor.green.appIconColor)
          .clipShape(.rect(cornerRadius: buttonRadius))
          
          Button {
            largeColorItem = .blue
          } label: {
            Image(systemName: "checkmark")
              .padding(8)
              .foregroundStyle(
                self.largeColorItem == .blue ? .white : .clear
              )
          }
          .frame(width: buttonWidth, height: buttonWidth)
          .background(AppIconColor.blue.appIconColor)
          .clipShape(.rect(cornerRadius: buttonRadius))
        }
        
        // MARK: Medium Icon
        HStack(spacing: 16) {
          Text("中アイコン")
          Button {
            mediumColorItem = .red
          } label: {
            Image(systemName: "checkmark")
              .padding(8)
              .foregroundStyle(
                self.mediumColorItem == .red ? .white : .clear
              )
          }
          .frame(width: buttonWidth, height: buttonWidth)
          .background(AppIconColor.red.appIconColor)
          .clipShape(.rect(cornerRadius: buttonRadius))
          
          Button {
            mediumColorItem = .green
          } label: {
            Image(systemName: "checkmark")
              .padding(8)
              .foregroundStyle(
                self.mediumColorItem == .green ? .black : .clear
              )
          }
          .frame(width: buttonWidth, height: buttonWidth)
          .background(AppIconColor.green.appIconColor)
          .clipShape(.rect(cornerRadius: buttonRadius))
          
          Button {
            mediumColorItem = .blue
          } label: {
            Image(systemName: "checkmark")
              .padding(8)
              .foregroundStyle(
                self.mediumColorItem == .blue ? .white : .clear
              )
          }
          .frame(width: buttonWidth, height: buttonWidth)
          .background(AppIconColor.blue.appIconColor)
          .clipShape(.rect(cornerRadius: buttonRadius))
        }
        
        // MARK: Small Icon
        HStack(spacing: 16) {
          Text("小アイコン")
          Button {
            smallColorItem = .red
          } label: {
            Image(systemName: "checkmark")
              .padding(8)
              .foregroundStyle(
                self.smallColorItem == .red ? .white : .clear
              )
          }
          .frame(width: buttonWidth, height: buttonWidth)
          .background(AppIconColor.red.appIconColor)
          .clipShape(.rect(cornerRadius: buttonRadius))
          
          Button {
            smallColorItem = .green
          } label: {
            Image(systemName: "checkmark")
              .padding(8)
              .foregroundStyle(
                self.smallColorItem == .green ? .black : .clear
              )
          }
          .frame(width: buttonWidth, height: buttonWidth)
          .background(AppIconColor.green.appIconColor)
          .clipShape(.rect(cornerRadius: buttonRadius))
          
          Button {
            smallColorItem = .blue
          } label: {
            Image(systemName: "checkmark")
              .padding(8)
              .foregroundStyle(
                self.smallColorItem == .blue ? .white : .clear
              )
          }
          .frame(width: buttonWidth, height: buttonWidth)
          .background(AppIconColor.blue.appIconColor)
          .clipShape(.rect(cornerRadius: buttonRadius))
        }
      }
      
      Spacer()
      // TODO: Save Button
      Button {
        UIApplication.shared.setAlternateIconName(homeIconName) { error in
          if let error {
            print(error.localizedDescription)
          } else {
            settings.largeIconColor = largeColorItem
            settings.mediumIconColor = mediumColorItem
            settings.smallIconColor = smallColorItem
            dismiss()
          }
        }

      } label: {
        Text("アイコンを変更する")
          .tint(settings.isDarkMode ? .white : .black)
          .padding(.vertical, 16)
          .padding(.horizontal, 32)
      }
      .clipShape(.rect(cornerRadius: 32))
      .overlay {
        RoundedRectangle(cornerRadius: 32)
          .stroke(lineWidth: 2)
          .fill(
            settings.isDarkMode ? .white : .black
          )
      }
      Spacer()
    }
    .onAppear {
      self.largeColorItem = settings.largeIconColor
      self.mediumColorItem = settings.mediumIconColor
      self.smallColorItem = settings.smallIconColor
    }
  }
}
