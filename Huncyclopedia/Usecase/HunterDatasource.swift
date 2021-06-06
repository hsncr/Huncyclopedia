//
//  HunterDatasource.swift
//  Huncyclopedia
//
//  Created by hsncr on 2.06.2021.
//

import Foundation


class HunterDataSource {
    static var all: [Hunter] {
        var data: [Hunter] = []
        
        let gon = Hunter(name: "Gon Freecss",
                         aura: .enhancer,
                         image: "Gon",
                         referenceURL: URL(string: "https://hunterxhunter.fandom.com/wiki/Gon_Freecss")!)
        data.append(gon)
        let killua = Hunter(name: "Killua Zoldyck",
                            aura: .transmuter,
                            image: "Killua Zoldyck",
                            referenceURL: URL(string: "https://hunterxhunter.fandom.com/wiki/Killua_Zoldyck")!)
        data.append(killua)
        let Kurapika = Hunter(name: "Kurapika",
                              aura: .conjurer,
                              image: "Kurapika",
                              referenceURL: URL(string: "https://hunterxhunter.fandom.com/wiki/Kurapika")!)
        data.append(Kurapika)
        let leorio = Hunter(name: "Leorio Paradinight",
                            aura: .emitter,
                            image: "Leorio Paradinight",
                            referenceURL: URL(string: "https://hunterxhunter.fandom.com/wiki/Leorio_Paradinight")!)
        data.append(leorio)
        let hisoka = Hunter(name: "Hisoka Morow",
                            aura: .transmuter,
                            image: "Hisoka Morow",
                            referenceURL: URL(string: "https://hunterxhunter.fandom.com/wiki/Hisoka_Morow")!)
        data.append(hisoka)
        
        let isaac = Hunter(name: "Isaac Netero",
                           aura: .enhancer,
                           image: "Isaac Netero",
                           referenceURL: URL(string: "https://hunterxhunter.fandom.com/wiki/Isaac_Netero")!)
        data.append(isaac)
        let wing = Hunter(name: "Wing",
                          aura: .enhancer,
                          image: "Wing",
                          referenceURL: URL(string: "https://hunterxhunter.fandom.com/wiki/Wing")!)
        data.append(wing)
        let gido = Hunter(name: "Gido",
                          aura: .enhancer,
                          image: "Gido",
                          referenceURL: URL(string: "https://hunterxhunter.fandom.com/wiki/Gido")!)
        data.append(gido)
        let palm = Hunter(name: "Palm Siberia",
                          aura: .enhancer,
                          image: "Palm Siberia",
                          referenceURL: URL(string: "https://hunterxhunter.fandom.com/wiki/Palm_Siberia")!)
        data.append(palm)
        let uvogin = Hunter(name: "Uvogin",
                            aura: .enhancer,
                            image: "Uvogin",
                            referenceURL: URL(string: "https://hunterxhunter.fandom.com/wiki/Uvogin")!)
        data.append(uvogin)
        let menthuthuyoupi = Hunter(name: "Menthuthuyoupi",
                                    aura: .enhancer,
                                    image: "Menthuthuyoupi",
                                    referenceURL: URL(string: "https://hunterxhunter.fandom.com/wiki/Menthuthuyoupi")!)
        data.append(menthuthuyoupi)
        let nobunaga = Hunter(name: "Nobunaga Hazama",
                              aura: .enhancer,
                              image: "Nobunaga Hazama",
                              referenceURL: URL(string: "https://hunterxhunter.fandom.com/wiki/Nobunaga_Hazama")!)
        data.append(nobunaga)
        
        let zoldyck = Hunter(name: "Silva Zoldyck",
                             aura: .transmuter,
                             image: "Silva Zoldyck",
                             referenceURL: URL(string: "https://hunterxhunter.fandom.com/wiki/Silva_Zoldyck")!)
        data.append(zoldyck)
        let sadaso = Hunter(name: "Sadaso",
                            aura: .transmuter,
                            image: "Sadaso",
                            referenceURL: URL(string: "https://hunterxhunter.fandom.com/wiki/Sadaso")!)
        data.append(sadaso)
        let machi = Hunter(name: "Machi Komacine",
                           aura: .transmuter,
                           image: "Machi Komacine",
                           referenceURL: URL(string: "https://hunterxhunter.fandom.com/wiki/Machi_Komacine")!)
        data.append(machi)
        let Feitan = Hunter(name: "Feitan Portor",
                            aura: .transmuter,
                            image: "Feitan Portor",
                            referenceURL: URL(string: "https://hunterxhunter.fandom.com/wiki/Feitan_Portor")!)
        data.append(Feitan)
        let Biscuit = Hunter(name: "Biscuit Krueger",
                             aura: .transmuter,
                             image: "Biscuit Krueger",
                             referenceURL: URL(string: "https://hunterxhunter.fandom.com/wiki/Biscuit_Krueger")!)
        data.append(Biscuit)
        
        let Pokkle = Hunter(name: "Pokkle",
                            aura: .emitter,
                            image: "Pokkle",
                            referenceURL: URL(string: "https://hunterxhunter.fandom.com/wiki/Pokkle")!)
        data.append(Pokkle)
        let Melody = Hunter(name: "Melody",
                            aura: .emitter,
                            image: "Melody",
                            referenceURL: URL(string: "https://hunterxhunter.fandom.com/wiki/Melody")!)
        data.append(Melody)
        let Shachmono = Hunter(name: "Shachmono Tocino",
                               aura: .emitter,
                               image: "Shachmono Tocino",
                               referenceURL: URL(string: "https://hunterxhunter.fandom.com/wiki/Shachmono_Tocino")!)
        data.append(Shachmono)
        let Franklin = Hunter(name: "Franklin Bordeau",
                              aura: .emitter,
                              image: "Franklin Bordeau",
                              referenceURL: URL(string: "https://hunterxhunter.fandom.com/wiki/Franklin_Bordeau")!)
        data.append(Franklin)
        
        let Shizuku = Hunter(name: "Shizuku Murasaki",
                             aura: .conjurer,
                             image: "Shizuku Murasaki",
                             referenceURL: URL(string: "https://hunterxhunter.fandom.com/wiki/Shizuku_Murasaki")!)
        data.append(Shizuku)
        let Cheetu = Hunter(name: "Cheetu",
                            aura: .conjurer,
                            image: "Cheetu",
                            referenceURL: URL(string: "https://hunterxhunter.fandom.com/wiki/Cheetu")!)
        data.append(Cheetu)
        let Knov = Hunter(name: "Knov",
                          aura: .conjurer,
                          image: "Knov",
                          referenceURL: URL(string: "https://hunterxhunter.fandom.com/wiki/Knov")!)
        data.append(Knov)
        
        
        let Illumi = Hunter(name: "Illumi Zoldyck",
                            aura: .manipulator,
                            image: "Illumi Zoldyck",
                            referenceURL: URL(string: "https://hunterxhunter.fandom.com/wiki/Illumi_Zoldyck")!)
        data.append(Illumi)
        let Kalluto = Hunter(name: "Kalluto Zoldyck",
                             aura: .manipulator,
                             image: "Kalluto Zoldyck",
                             referenceURL: URL(string: "https://hunterxhunter.fandom.com/wiki/Kalluto_Zoldyck")!)
        data.append(Kalluto)
        let Zushi = Hunter(name: "Zushi",
                           aura: .manipulator,
                           image: "Zushi",
                           referenceURL: URL(string: "https://hunterxhunter.fandom.com/wiki/Zushi")!)
        data.append(Zushi)
        let Squala = Hunter(name: "Squala",
                            aura: .manipulator,
                            image: "Squala",
                            referenceURL: URL(string: "https://hunterxhunter.fandom.com/wiki/Squala")!)
        data.append(Squala)
        let Baise = Hunter(name: "Baise",
                           aura: .manipulator,
                           image: "Baise",
                           referenceURL: URL(string: "https://hunterxhunter.fandom.com/wiki/Baise")!)
        data.append(Baise)
        let Morel = Hunter(name: "Morel Mackernasey",
                           aura: .manipulator,
                           image: "Morel Mackernasey",
                           referenceURL: URL(string: "https://hunterxhunter.fandom.com/wiki/Morel_Mackernasey")!)
        data.append(Morel)
        let Ikalgo = Hunter(name: "Ikalgo",
                            aura: .manipulator,
                            image: "Ikalgo",
                            referenceURL: URL(string: "https://hunterxhunter.fandom.com/wiki/Ikalgo")!)
        data.append(Ikalgo)
        
        let Neon = Hunter(name: "Neon Nostrade",
                          aura: .specialist,
                          image: "Neon Nostrade",
                          referenceURL: URL(string: "https://hunterxhunter.fandom.com/wiki/Neon_Nostrade")!)
        data.append(Neon)
        let Chrollo = Hunter(name: "Chrollo Lucilfer",
                             aura: .specialist,
                             image: "Chrollo Lucilfer",
                             referenceURL: URL(string: "https://hunterxhunter.fandom.com/wiki/Chrollo_Lucilfer")!)
        data.append(Chrollo)
        let Meruem = Hunter(name: "Meruem",
                            aura: .specialist,
                            image: "Meruem",
                            referenceURL: URL(string: "https://hunterxhunter.fandom.com/wiki/Meruem")!)
        data.append(Meruem)
        let Leol = Hunter(name: "Leol",
                          aura: .specialist,
                          image: "Leol",
                          referenceURL: URL(string: "https://hunterxhunter.fandom.com/wiki/Leol")!)
        data.append(Leol)
        let Neferpitou = Hunter(name: "Neferpitou",
                                aura: .specialist,
                                image: "Neferpitou",
                                referenceURL: URL(string: "https://hunterxhunter.fandom.com/wiki/Neferpitou")!)
        data.append(Neferpitou)
        return data
    }
}
