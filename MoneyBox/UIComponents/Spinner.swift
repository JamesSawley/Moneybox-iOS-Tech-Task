import SwiftUI

struct Spinner: View {
    var body: some View {
        if #available(iOS 15.0, *) {
            ProgressView()
                .controlSize(.large)
        } else {
            ActivityIndicatorView()
        }
    }
}

struct ActivityIndicatorView: UIViewRepresentable {
    func makeUIView(context: Context) -> UIActivityIndicatorView {
        UIActivityIndicatorView(style: .large)
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {
        //
    }
}

struct Spinner_Previews: PreviewProvider {
    static var previews: some View {
        Spinner()
    }
}
