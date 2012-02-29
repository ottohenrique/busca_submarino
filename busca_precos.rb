require 'open-uri'
require './resultado_submarino.rb'

def formata_linha titulo, valor
  coluna_titulo = titulo.ljust 100
  coluna_valor = valor.rjust 15
  "#{coluna_titulo} #{coluna_valor}\n"
end


if ARGV.size == 0
  puts "busca_precos.rb nome do produto"
  exit 0
end  

produto = ARGV[0]
resultado = BuscaNoSubmarino.new produto

if resultado.existem_resultados?
    print "Encontrou o produto #{produto}!\n"

    resultado.listar_produtos.each do |produto|
        print formata_linha produto[:nome], produto[:valor]
    end
else
    print "Não encontrou o produto :(\n"
end
