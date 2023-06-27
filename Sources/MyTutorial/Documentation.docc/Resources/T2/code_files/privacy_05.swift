import SwiftUI

struct ContentView: View {
    @ObservedObject var store: CoffeeStore
    @EnvironmentObject var blindsup: BlindsStore
    
    var body: some View {
        if blindsup.blindsup {
            Blinds()
        }
        else {
            NavigationView {
                List{
                    ForEach(store.coffees)  { coffee in
                        if coffee.isReady == "Y" {
                            OrderCompleteCell(coffee: coffee)
                        }
                        else {
                            OrderCell(coffee: coffee)
                        }
                    }
                    HStack {
                        Spacer()
                        Text("\(store.coffees.count) coffee orders")
                            .foregroundColor(.secondary)
                        Spacer()
                    }
                }
                .navigationTitle("Coffees")
                .navigationBarItems(trailing: HStack {
                    AddButton(destination: NewCoffee(store: store)) } )
            }
            .onAppear(perform: {
                    self.fetchNewData()
            })
        }
    }
    
    func loadOrders() {
        //Coffee(name: "Pat", milk: "Full", sugar: 1, isReady: "N", price: 4.5, type: "Flat White", size: "Large", created: Date()),
        if let data = NSDictionary(contentsOfFile: dataFileURL().path),
            let orderarray = data["orders"]! as? [[String: AnyObject]] {
            //clear out old orders:
            store.coffees.removeAll(keepingCapacity: true)
            for anorder in orderarray {
                store.coffees.append(Coffee(name: anorder["name"] as! String, milk: anorder["milk"] as! String, sugar: anorder["sugar"] as! Int, isReady: anorder["isReady"] as! String, price: anorder["price"] as! Double, type: anorder["type"] as! String, size: anorder["size"] as! String, created: anorder["tstamp"] as! Date))
            }
        }
    }

    func fetchNewData() {
        if let url = NSURL(string: "https://consultants.apple.com/au/ttanz/orders.plist") {
            let session = URLSession(configuration: URLSessionConfiguration.ephemeral)
            let task = session.dataTask(with: url as URL, completionHandler: { (data, response, error) -> Void in
                if error != nil {
                    print("error: \(error!.localizedDescription))")
                }
                else if data != nil {
                    print("new download successful")
                    if let data = data {
                        do {
                            try data.write(to: self.dataFileURL())
                            print("wrote file to dataFileURL")
                            DispatchQueue.main.async {
                                self.loadOrders()
                            }
                        } catch { print("this did not work") }
                    }
                    DispatchQueue.main.async { self.loadOrders() }
                }
            })
            task.resume()
        }
        else {
            print("Unable to create NSURL")
        }
    }
    
    func dataFileURL() -> URL {
        let fm = FileManager.default
        let localFilePath = fm.urls(for: .documentDirectory, in: .userDomainMask).first
        let fullPath = localFilePath?.appendingPathComponent("orders.plist")
        
        if !fm.fileExists(atPath: fullPath!.absoluteURL.path) {
            print("No downloaded orders.plist file found, so copying included bundle")
            let bundledDataPath = Bundle.main.path(forResource: "orders", ofType: "plist")!
            try! fm.copyItem(atPath: bundledDataPath, toPath: (fullPath?.path)!)
        }
        return fullPath!
    }
}

    
struct OrderCell: View {
    var coffee: Coffee
    var body: some View {
        NavigationLink(destination: CoffeeDetail(coffee: coffee)) {
            HStack {
                Image(coffee.thumb)
                    .cornerRadius(8)
                    .padding(.init(top: 0, leading: -10, bottom: 0, trailing: 0))
                VStack(alignment: .leading) {
                    Text(coffee.name)
                    Text(coffee.size + " " + coffee.milk + " milk " + coffee.type)
                        .font(.subheadline)
                }
            }
        }
    }
}

struct OrderCompleteCell: View {
    var coffee: Coffee
    var body: some View {
        NavigationLink(destination: CoffeeDetail(coffee: coffee)) {
            HStack {
                Image(coffee.thumb)
                    .cornerRadius(8)
                    .padding(.init(top: 0, leading: -10, bottom: 0, trailing: 0))
                VStack(alignment: .leading) {
                    Text(coffee.name)
                    Text(coffee.size + " " + coffee.milk + " " + coffee.type)
                        .font(.subheadline)
                }
                Spacer()
                Image(systemName: "checkmark.rectangle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.green)
                    .frame(width: 40.0, height: 30.0)
            }
        }.deleteDisabled(true)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(store: testStore)
    }
}

struct AddButton<Destination : View>: View {
    var destination:  Destination
    var body: some View {
        NavigationLink(destination: self.destination) {
            Image(systemName: "plus.circle.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 30.0, height: 30.0)
        }
    }
}
