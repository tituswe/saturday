import SwiftUI


struct ContentView: View {
    
    @EnvironmentObject var viewModel: UserViewModel
    
    var body: some View {
        
        NavigationView {
            
            Group {
                
                if viewModel.userSession == nil {
                    LogInView()
            
                } else {
                    HomeView()
                }
                
            }
            .navigationBarHidden(true)
            
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

