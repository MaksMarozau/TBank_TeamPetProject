import Combine

//MARK: - Protocol for expansion ExchangeRatesViewModel. Will be worked out when the loading process will be finished

protocol ExchangeRatesViewModelProtocol: AnyObject {
    func loadData()
//    var loadedCurrentCurrencies: (([Currencies]) -> (Void))? { get set}
    var loadCurrencyPublisher: AnyPublisher<[Currencies], Never> { get }
}



//MARK: - Final class ExchangeRatesViewModel

final class ExchangeRatesViewModel {
    
    
//MARK: - Properties and init of class
    
    private let loadCurrensySubject = PassthroughSubject<[Currencies], Never>()
    private var currencies: [Currencies] = []
    
//    var loadedCurrentCurrencies: (([Currencies]) -> (Void))?
    
}
    
    
    
//MARK: - Implemendation of the LoadingScreenPresenterProtocol

extension ExchangeRatesViewModel: ExchangeRatesViewModelProtocol {
    
    var loadCurrencyPublisher: AnyPublisher<[Currencies], Never> {
        return loadCurrensySubject.eraseToAnyPublisher()
    }
    
    func loadData() {
        let result = CoreDataManager.instance.loadCurrancies()
        switch result {
        case .success(let data):
            self.currencies = data
//            loadedCurrentCurrencies?(currencies)
            loadCurrensySubject.send(currencies)
        case .failure(let failure):
            print(failure.localizedDescription)
        }
    }
}
