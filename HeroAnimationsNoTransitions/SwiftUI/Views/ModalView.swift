//
//  ModalView.swift
//  Wildlife Encyclopedia
//
//  Created by SwiftUI-Lab on 10-Jul-2020.
//  https://swiftui-lab.com/matchedGeometryEffect-part2
//

import SwiftUI

struct ModalView: View {
    let id: Int
    var pct: CGFloat
    var flyingFromGrid: Bool
    let onClose: () -> ()

    var body: some View {
        // We use EmptyView, because the modifier actually ignores
        // the value passed to its body() function.
        EmptyView().modifier(ModalMod(id: id, pct: pct, flyingFromGrid: flyingFromGrid, onClose: onClose))
    }
}

struct ModalMod: AnimatableModifier {
    @Environment(\.colorScheme) var scheme
    
    @EnvironmentObject var data: DataModel
    
    @Environment(\.gridRadiusPct) var gridRadiusPct: CGFloat
    @Environment(\.gridShadow) var gridShadow: CGFloat
    @Environment(\.favRadiusPct) var favRadiusPct: CGFloat
    @Environment(\.favShadow) var favShadow: CGFloat

    let id: Int
    var pct: CGFloat
    var flyingFromGrid: Bool
    let pictureSize = CGSize(width: 200, height: 200)
    let onClose: () -> ()
    
    var animatableData: CGFloat {
        get { pct }
        set { pct = newValue }
    }
    
    func body(content: Content) -> some View {
        
        let item = data.items.first { $0.id == id }!
        
        let refRadiusPct = flyingFromGrid ? gridRadiusPct : favRadiusPct
        let refShadow = flyingFromGrid ? gridShadow : favShadow
        
        let cornerRadius = (1.0 - refRadiusPct) * pct + refRadiusPct
        let shadowRadius = (2 - refShadow) * pct + refShadow
        let modalRadius = (0.1 - refRadiusPct) * pct + refRadiusPct
        let modalShadow = (8 - refShadow) * pct + refShadow
        
        let loremIpsum = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut mauris ipsum, ultrices nec aliquam a, bibendum in sem.\n\nPraesent ac neque sed risus auctor consectetur. Curabitur dui ex, suscipit ut sapien at, fermentum ultricies nisi. Praesent nec dignissim arcu. Praesent euismod lectus nec nunc vehicula, et ultrices metus volutpat.\n\nNunc libero odio, fringilla at rutrum id, maximus vitae urna. Nulla lobortis erat a ullamcorper rhoncus. Aliquam a ante mattis, mollis libero eget, lacinia nulla.\n\nMorbi eu lacus mauris. Sed arcu erat, porttitor sed massa quis, varius aliquet lorem. Proin at lobortis purus. Nam libero enim, rutrum laoreet malesuada eu, vulputate sit amet odio. Aliquam ut ultrices dolor. Aenean sed mi quis augue egestas scelerisque. Nulla vel diam fringilla, tempor ex ut, elementum sapien. Vestibulum laoreet augue ut nisl porta posuere.\n\nFusce scelerisque massa sit amet ante ultricies, sit amet accumsan nibh sodales. Maecenas ac ligula urna. Maecenas sollicitudin elit elementum, hendrerit velit sit amet, commodo nulla. Phasellus semper rutrum erat sed feugiat. Integer vel purus a velit semper ullamcorper ut vitae quam. Quisque nec odio eu lacus eleifend tincidunt eu nec velit. Donec scelerisque facilisis purus, at eleifend mi hendrerit id. Nullam consequat commodo quam, eu auctor lectus suscipit sed. Etiam efficitur, augue vel imperdiet mollis, augue ante efficitur mi, ac porttitor lorem elit eget sapien.\n\nCras sit amet augue quis nulla facilisis placerat ut at eros. Duis a suscipit justo. Suspendisse potenti. Cras mattis, erat nec sodales blandit, sem ex faucibus mi, sit amet tempor massa justo eu dolor."
        
        let isFavorite = data.isFavorite(item)
        
        let textOpacity = Double((pct - 0.5) * 2)
        let borderPct = flyingFromGrid ? pct : 1.0
        
        return GeometryReader { proxy in
            VStack(alignment: .leading, spacing: 0) {
                HStack(alignment: .top, spacing: 0) {
                    Image(item.image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .overlay(HeartView(isFavorite: isFavorite && flyingFromGrid).opacity(Double(1-pct)), alignment: .topTrailing)
                        .clipShape(RectangleToCircle(cornerRadiusPercent: cornerRadius))
                        .overlay(RectangleToCircle(cornerRadiusPercent: cornerRadius).stroke(Color.white, lineWidth: 2 * borderPct))
                        .padding(2 * borderPct)
                        .overlay(RectangleToCircle(cornerRadiusPercent: cornerRadius).strokeBorder(Color.black.opacity(0.1 * Double(borderPct))))
                        .shadow(radius: shadowRadius)
                        .padding(4 * pct)
                        .frame(width: (pictureSize.width - proxy.size.width) * pct + proxy.size.width,
                               height: (pictureSize.height - proxy.size.height) * pct + proxy.size.height)

                    VStack(alignment: .leading) {
                        Text(item.name).font(.largeTitle).fontWeight(.heavy).foregroundColor(Color(UIColor.label))
                        Text(item.class).font(.none).fontWeight(.bold).foregroundColor(.secondary)
                        Divider()
                        HStack {
                            Spacer()
                            Button(isFavorite ? "Remove from Favorites" : "Mark as Favorite") {
                                withAnimation(.basic) {
                                    if isFavorite {
                                        data.favorites.removeAll(where: { $0.id == item.id })
                                    } else {
                                        data.favorites.append(item)
                                    }
                                }
                            }.accentColor(isFavorite ? .red : .blue)
                        }
                    }
                    .padding(.leading, 20 * pct)
                    .padding(.top, 20  * pct)
                    .opacity(textOpacity)
                    
                }.padding(.bottom, 25  * pct)
                
                ScrollView {
                    Text(loremIpsum)
                }.opacity(textOpacity)

                Spacer()

                HStack(spacing: 0) {
                    Spacer()
                    Text("photo: ") + Text("\(item.author)").fontWeight(.heavy)
                }.font(.caption).foregroundColor(.secondary)
                .opacity(textOpacity)
            }
        }
        .padding(40 * pct)
        .overlay(CloseButton(onTap: onClose).opacity(Double(pct)), alignment: .topTrailing)
        .background(VisualEffectView(uiVisualEffect: UIBlurEffect(style: scheme == .dark ? .dark : .light)))
        .clipShape(RectangleToCircle(cornerRadiusPercent: modalRadius))
        .contentShape(RectangleToCircle(cornerRadiusPercent: modalRadius))
        .shadow(radius: modalShadow)
        .padding(4 * borderPct)

    }
    
    struct CloseButton: View {
        var onTap: () -> Void
        
        var body: some View {
            Image(systemName: "xmark.circle.fill")
                .font(.title)
                .foregroundColor(.secondary)
                .padding(30)
                .onTapGesture(perform: onTap)
        }
    }
}
