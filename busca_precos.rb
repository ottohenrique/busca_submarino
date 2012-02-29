require 'open-uri'
require './resultado_submarino.rb'

def formata_linha titulo, valor
  coluna_titulo = titulo.ljust 100
  coluna_valor = valor.rjust 15
  "#{coluna_titulo} #{coluna_valor}\n"
end

bibliografia = false

precos_submarino = File.new "/work/precos_submarino.txt", 'w'

lista_de_livros = File.open '/work/bibliografia_mack.txt'

lista_de_livros.lines.each do |linha|
    linha.strip!
    
    if linha.match /^disciplina/i
        bibliografia = false
    end
    
    if linha.match /^bibliografia/i
        bibliografia = true
    end
    
    if bibliografia
       if linha.match /^[a-z]+\, [a-z]+\. .*\: /i
         print "Buscando livro #{linha}...\n"
         
          
         resultado = ResultadoSubmarino.new linha
         
         if resultado.existem_resultados?
            print "encontrou resultados!\n"
            
            precos_submarino.print "#{linha}\n"
            resultado.listar_produtos.each do |produto|
                precos_submarino.print formata_linha produto[:nome], produto[:valor]
            end
         else
           print "sem resultados...\n"
         end
         
         print "\n"
      end
    end
end    

precos_submarino.close
