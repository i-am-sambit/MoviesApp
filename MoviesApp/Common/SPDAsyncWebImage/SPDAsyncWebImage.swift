
import SwiftUI

struct SPDAsyncWebImage: View {
    private var url: URL
    private var placeHolder: Image?
    
    @ObservedObject var binder = SPDAsyncWebImageBinder()
    
    init(url: URL, placeHolder: Image? = nil) {
        self.url = url
        self.placeHolder = placeHolder
        self.binder.load(url: self.url)
    }
    
    var body: some View {
        VStack {
            if binder.image != nil {
                Image(uiImage: binder.image!)
                    .renderingMode(.original)
                    .resizable()
            }
            else if binder.isLoading && !binder.isFinished {
                ActivityIndicatorView(isAnimating: Binding<Bool>(
                    get: { self.binder.isLoading && !self.binder.isFinished },
                    set: { _ in }), style: .large)
                    .foregroundColor(.secondary)

            }
            else {
                placeHolder
            }
        }
        .onAppear { self.binder.load(url: self.url) }
        .onDisappear { self.binder.cancel() }
    }
}

struct SPDAsyncWebImage_Previews: PreviewProvider {
    static var previews: some View {
        SPDAsyncWebImage(url: URL(string: "https://image.tmdb.org/t/p/original/cDbOrc2RtIA37nLm0CzVpFLrdaG.jpg")!)
    }
}
