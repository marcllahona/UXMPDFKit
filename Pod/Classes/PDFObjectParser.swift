//
//  PDFObjectParser.swift
//  Pods
//
//  Created by Chris Anderson on 5/25/16.
//
//

import UIKit

class PDFObjectParserContext {
    
    var dictionaryRef:CGPDFDictionaryRef
    var info:UnsafeMutablePointer<Void>
    var keys:[UnsafePointer<Int8>] = []
    
    init(dictionaryRef: CGPDFDictionaryRef, info: UnsafeMutablePointer<Void>, keys: [UnsafePointer<Int8>]) {
        
        self.dictionaryRef = dictionaryRef
        self.info = info
        self.keys = keys
    }
}

public class PDFObjectParser: NSObject {
    
    var document:PDFDocument
    var attributes:PDFDictionary?
    
    public init(document: PDFDocument) {
        
        self.document = document
        super.init()
        
        self.getFormFields()
    }
    
    func getFormFields() -> AnyObject? {
        var acroForm:CGPDFDictionaryRef = nil
        
        guard let ref = self.document.documentRef() else {
            return nil
        }
        
        let catalogue = CGPDFDocumentGetCatalog(ref)

        self.attributes = PDFDictionary(dictionaryRef: catalogue)

        return self.attributes
    }
    
    func getCatalogue() -> CGPDFDictionaryRef? {
        
        guard let ref = self.document.documentRef() else {
            return nil
        }
        return CGPDFDocumentGetCatalog(ref)
    }
    
}