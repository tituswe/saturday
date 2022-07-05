import SwiftUI


struct ContentView: View {
    
    @EnvironmentObject var viewModel: AuthenticationViewModel
    
    var body: some View {
        
        Group {
            
            if viewModel.userSession == nil {
                LogInView()
        
            } else {
                HomeView()
            }
            
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

