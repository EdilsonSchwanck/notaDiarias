//
//  AnotacaoViewController.swift
//  NotasDiarias
//
//  Created by Edilson Schwanck Borges on 23/02/22.
//

import UIKit
import CoreData

class AnotacaoViewController: UIViewController {

    @IBOutlet weak var texto: UITextView!
    var context: NSManagedObjectContext!
    var anotacao: NSManagedObject!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //configurações iniciais
        self.texto.becomeFirstResponder()
        if anotacao != nil{
            if let textoRecuperado = anotacao.value(forKey: "texto"){
                self.texto.text = String(describing: textoRecuperado)
            }
        }else{
            self.texto.text = ""
        }
        
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext
       
    }
    @IBAction func salvar(_ sender: Any) {
        if anotacao != nil {
            self.atualizarAnotacao()
        }else{
            self.salvarAnotacao()
        }
        
        
        
    }
    
    func atualizarAnotacao(){
        
        anotacao.setValue(self.texto.text, forKey: "texto")
        anotacao.setValue(Date(), forKey: "data")
        do {
            try context.save()
           
            // Alerta animeition
         
            let alert = UIAlertController(title: "Atenção", message: "Sua nota foi alterada com sucesso", preferredStyle: .alert)
            let acaOk = UIAlertAction(title: "Ok", style: .destructive) { UIAlertAction in
                self.navigationController?.popToRootViewController(animated: true)
            }
            alert.addAction(acaOk)
            self.present(alert, animated: true, completion: nil)
        } catch let erro {
            print("Erro ao atualizar anotação" + erro.localizedDescription)
        }
        
    }
    
    func salvarAnotacao(){
        let novaAnotacao = NSEntityDescription.insertNewObject(forEntityName: "Anotacao", into: context)
        
        novaAnotacao.setValue(self.texto.text, forKey: "texto")
        novaAnotacao.setValue(Date(), forKey: "data")
        
        do {
            try context.save()
           
            // Alerta animeition
         
            let alert = UIAlertController(title: "Atenção", message: "Sua nota foi salva com Sucesso!", preferredStyle: .alert)
            let acaOk = UIAlertAction(title: "Ok", style: .destructive) { UIAlertAction in
                self.navigationController?.popToRootViewController(animated: true)
            }
            alert.addAction(acaOk)
            self.present(alert, animated: true, completion: nil)
        } catch let erro{
            print("Erro ao salvar anotação" + erro.localizedDescription)
        }
    }
    



}
