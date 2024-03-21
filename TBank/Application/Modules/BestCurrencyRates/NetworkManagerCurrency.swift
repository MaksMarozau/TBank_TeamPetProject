import Alamofire

final class NetworkManagerCurrency {
    
    static let shared = NetworkManagerCurrency()
    
    private init() {}
    
    func fetchExchangeRates(completion: @escaping ([CurrencyRate]?) -> Void) {
        let url = "https://www.nbrb.by/api/exrates/rates?periodicity=0"
        
        AF.request(url).responseDecodable(of: [CurrencyRate].self) { response in
            switch response.result {
            case .success(let rates):
                completion(rates)
            case .failure(let error):
                print("Error fetching exchange rates: \(error)")
                completion(nil)
            }
        }
    }
}




