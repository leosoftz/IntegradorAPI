//
//  AndesCurrenciesTestAppDefault.swift
//  AndesUI-AndesUIResources
//
//  Created by Daniel Esteban Beltran Beltran on 20/09/21.
//

import Foundation

@objc public class AndesCurrenciesDefault: NSObject, AndesCurrencies {
    public var currentSite = AndesCountry.DEFAULT.toString()

    public var currencies: [String: AndesCurrencyInfo] = [
        "ARS": AndesCurrencyInfo(
            decimalSeparator: ",",
            thousandSeparator: ".",
            symbol: "$",
            decimalPlaces: "2",
            decimalName: "Centavo",
            currencyName: "Peso",
            decimalNamePrural: "Centavos",
            currencyNamePrural: "Pesos",
            isCrypto: false,
            icon: ""
        ),
        "BRL": AndesCurrencyInfo(
            decimalSeparator: ",",
            thousandSeparator: ".",
            symbol: "R$",
            decimalPlaces: "2",
            decimalName: "Centavo",
            currencyName: "Real",
            decimalNamePrural: "Centavos",
            currencyNamePrural: "Reales",
            isCrypto: false,
            icon: ""
        ),
        "CLP": AndesCurrencyInfo(
            decimalSeparator: ",",
            thousandSeparator: ".",
            symbol: "$",
            decimalPlaces: "0",
            decimalName: "Centavo",
            currencyName: "Peso",
            decimalNamePrural: "Centavos",
            currencyNamePrural: "Pesos",
            isCrypto: false,
            icon: ""
        ),
        "COP": AndesCurrencyInfo(
            decimalSeparator: ",",
            thousandSeparator: ".",
            symbol: "$",
            decimalPlaces: "0",
            decimalName: "Centavo",
            currencyName: "Peso",
            decimalNamePrural: "Centavos",
            currencyNamePrural: "Pesos",
            isCrypto: false,
            icon: ""
        ),
        "CRC": AndesCurrencyInfo(
            decimalSeparator: ".",
            thousandSeparator: ",",
            symbol: "¢",
            decimalPlaces: "2",
            decimalName: "Céntimo",
            currencyName: "Colón",
            decimalNamePrural: "Céntimos",
            currencyNamePrural: "Colónes",
            isCrypto: false,
            icon: ""
        ),
        "DOP": AndesCurrencyInfo(
            decimalSeparator: ".",
            thousandSeparator: ",",
            symbol: "$",
            decimalPlaces: "2",
            decimalName: "Centavo",
            currencyName: "Peso",
            decimalNamePrural: "Centavos",
            currencyNamePrural: "Pesos",
            isCrypto: false,
            icon: ""
        ),
        "EUR": AndesCurrencyInfo(
            decimalSeparator: ".",
            thousandSeparator: ",",
            symbol: "€",
            decimalPlaces: "2",
            decimalName: "Cent",
            currencyName: "Euro",
            decimalNamePrural: "Cents",
            currencyNamePrural: "Euros",
            isCrypto: false,
            icon: ""
        ),
        "MXN": AndesCurrencyInfo(
            decimalSeparator: ".",
            thousandSeparator: ",",
            symbol: "$",
            decimalPlaces: "2",
            decimalName: "Centavo",
            currencyName: "Peso",
            decimalNamePrural: "Centavos",
            currencyNamePrural: "Pesos",
            isCrypto: false,
            icon: ""
        ),
        "PAB": AndesCurrencyInfo(
            decimalSeparator: ",",
            thousandSeparator: ".",
            symbol: "B/.",
            decimalPlaces: "2",
            decimalName: "Centésimo",
            currencyName: "Balboa",
            decimalNamePrural: "Centésimos",
            currencyNamePrural: "Balboas",
            isCrypto: false,
            icon: ""
        ),
        "PEN": AndesCurrencyInfo(
            decimalSeparator: ",",
            thousandSeparator: ".",
            symbol: "S/",
            decimalPlaces: "2",
            decimalName: "Céntimo",
            currencyName: "Sol",
            decimalNamePrural: "Céntimos",
            currencyNamePrural: "Soles",
            isCrypto: false,
            icon: ""
        ),
        "USD": AndesCurrencyInfo(
            decimalSeparator: ",",
            thousandSeparator: ".",
            symbol: "U$S",
            decimalPlaces: "2",
            decimalName: "Centavo",
            currencyName: "Dólar",
            decimalNamePrural: "Centavos",
            currencyNamePrural: "Dólares",
            isCrypto: false,
            icon: ""
        ),
        "UYU": AndesCurrencyInfo(
            decimalSeparator: ",",
            thousandSeparator: ".",
            symbol: "$",
            decimalPlaces: "2",
            decimalName: "Centavo",
            currencyName: "Peso",
            decimalNamePrural: "Centavos",
            currencyNamePrural: "Pesos",
            isCrypto: false,
            icon: ""
        ),
        "VEF": AndesCurrencyInfo(
            decimalSeparator: ",",
            thousandSeparator: ".",
            symbol: "Bs.",
            decimalPlaces: "2",
            decimalName: "Centavo",
            currencyName: "Bolivar",
            decimalNamePrural: "Centavos",
            currencyNamePrural: "Bolívares",
            isCrypto: false,
            icon: ""
        ),
        "VES": AndesCurrencyInfo(
            decimalSeparator: ",",
            thousandSeparator: ".",
            symbol: "Bs.",
            decimalPlaces: "2",
            decimalName: "Centavo",
            currencyName: "Bolivar",
            decimalNamePrural: "Centavos",
            currencyNamePrural: "Bolívares",
            isCrypto: false,
            icon: ""
        ),
        "CLF": AndesCurrencyInfo(
            decimalSeparator: ",",
            thousandSeparator: ".",
            symbol: "UF",
            decimalPlaces: "2",
            decimalName: "Centavo",
            currencyName: "Unidad de fomento",
            decimalNamePrural: "Centavos",
            currencyNamePrural: "Unidades de fomento",
            isCrypto: false,
            icon: ""
        ),
        "BOB": AndesCurrencyInfo(
            decimalSeparator: ",",
            thousandSeparator: ".",
            symbol: "Bs",
            decimalPlaces: "2",
            decimalName: "Centavo",
            currencyName: "Boliviano",
            decimalNamePrural: "Centavos",
            currencyNamePrural: "Bolivianos",
            isCrypto: false,
            icon: ""
        ),
        "PYG": AndesCurrencyInfo(
            decimalSeparator: ",",
            thousandSeparator: ".",
            symbol: "₲",
            decimalPlaces: "0",
            decimalName: "Céntimo",
            currencyName: "Guaraní",
            decimalNamePrural: "Céntimos",
            currencyNamePrural: "Guaraníes",
            isCrypto: false,
            icon: ""
        ),
        "GTQ": AndesCurrencyInfo(
            decimalSeparator: ",",
            thousandSeparator: ".",
            symbol: "Q",
            decimalPlaces: "2",
            decimalName: "Centavo",
            currencyName: "Quetzal",
            decimalNamePrural: "Centavos",
            currencyNamePrural: "Quetzales",
            isCrypto: false,
            icon: ""
        ),
        "HNL": AndesCurrencyInfo(
            decimalSeparator: ",",
            thousandSeparator: ".",
            symbol: "L",
            decimalPlaces: "0",
            decimalName: "Centavo",
            currencyName: "Lempira",
            decimalNamePrural: "Centavos",
            currencyNamePrural: "Lempiras",
            isCrypto: false,
            icon: ""
        ),
        "NIO": AndesCurrencyInfo(
            decimalSeparator: ",",
            thousandSeparator: ".",
            symbol: "C$",
            decimalPlaces: "0",
            decimalName: "Centavo",
            currencyName: "Córdoba",
            decimalNamePrural: "Centavos",
            currencyNamePrural: "Córdobas",
            isCrypto: false,
            icon: ""
        ),
        "CUC": AndesCurrencyInfo(
            decimalSeparator: ",",
            thousandSeparator: ".",
            symbol: "$",
            decimalPlaces: "2",
            decimalName: "",
            currencyName: "Peso cubano convertible",
            decimalNamePrural: "",
            currencyNamePrural: "Pesos cubanos convertibles",
            isCrypto: false,
            icon: ""
        ),
        "BTC": AndesCurrencyInfo(
            decimalSeparator: ",",
            thousandSeparator: ".",
            symbol: "BTC",
            decimalPlaces: "8",
            decimalName: "",
            currencyName: "Bitcoin",
            decimalNamePrural: "",
            currencyNamePrural: "Bitcoins",
            isCrypto: true,
            icon: "logo_btc"
        ),
        "ETH": AndesCurrencyInfo(
            decimalSeparator: ",",
            thousandSeparator: ".",
            symbol: "ETH",
            decimalPlaces: "8",
            decimalName: "",
            currencyName: "Ethereum",
            decimalNamePrural: "",
            currencyNamePrural: "Ethereum",
            isCrypto: true,
            icon: "logo_eth"
        ),
        "MCN": AndesCurrencyInfo(
            decimalSeparator: ",",
            thousandSeparator: ".",
            symbol: "MCN",
            decimalPlaces: "8",
            decimalName: "",
            currencyName: "Mercado Coin",
            decimalNamePrural: "",
            currencyNamePrural: "Mercado Coin",
            isCrypto: true,
            icon: "logo_meli"
        ),
        "USDP": AndesCurrencyInfo(
            decimalSeparator: ",",
            thousandSeparator: ".",
            symbol: "USDP",
            decimalPlaces: "8",
            decimalName: "",
            currencyName: "USDP Stablecoin",
            decimalNamePrural: "",
            currencyNamePrural: "USDP Stablecoin",
            isCrypto: true,
            icon: "logo_usdp"
        )
    ]

    public var sites: [String: AndesSiteInfo] = [
        "MNI": AndesSiteInfo(decimalSeparator: ",", thousandSeparator: "."),
        "MLC": AndesSiteInfo(decimalSeparator: ",", thousandSeparator: "."),
        "MLV": AndesSiteInfo(decimalSeparator: ",", thousandSeparator: "."),
        "MHN": AndesSiteInfo(decimalSeparator: ",", thousandSeparator: "."),
        "MPY": AndesSiteInfo(decimalSeparator: ",", thousandSeparator: "."),
        "MBO": AndesSiteInfo(decimalSeparator: ",", thousandSeparator: "."),
        "MLU": AndesSiteInfo(decimalSeparator: ",", thousandSeparator: "."),
        "MCR": AndesSiteInfo(decimalSeparator: ".", thousandSeparator: ","),
        "MLM": AndesSiteInfo(decimalSeparator: ".", thousandSeparator: ","),
        "MSV": AndesSiteInfo(decimalSeparator: ",", thousandSeparator: "."),
        "MGT": AndesSiteInfo(decimalSeparator: ",", thousandSeparator: "."),
        "MPA": AndesSiteInfo(decimalSeparator: ",", thousandSeparator: "."),
        "MRD": AndesSiteInfo(decimalSeparator: ".", thousandSeparator: ","),
        "MLA": AndesSiteInfo(decimalSeparator: ",", thousandSeparator: "."),
        "MCO": AndesSiteInfo(decimalSeparator: ",", thousandSeparator: "."),
        "MPE": AndesSiteInfo(decimalSeparator: ",", thousandSeparator: "."),
        "MPR": AndesSiteInfo(decimalSeparator: ",", thousandSeparator: "."),
        "MCU": AndesSiteInfo(decimalSeparator: ",", thousandSeparator: "."),
        "MLB": AndesSiteInfo(decimalSeparator: ",", thousandSeparator: "."),
        "MEC": AndesSiteInfo(decimalSeparator: ",", thousandSeparator: ".")]
}
