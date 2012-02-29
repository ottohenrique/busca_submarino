# encoding: UTF-8

require 'hpricot'

class BuscaNoSubmarino
    SUBMARINO_URI_QUERY = "http://www.submarino.com.br/busca?q="
    
    doc = nil
    
    def initialize title
        pagina = buscar_no_submarino title
        @doc = Hpricot pagina        
    end
    
    def buscar_no_submarino title
        title_encoded = URI::encode title
        open "#{SUBMARINO_URI_QUERY}#{title_encoded}"
    end
    
    def existem_resultados?
        @doc.search('ul#ul_product_list1').size > 0
    end
    
    def listar_produtos
        produtos = []
        @doc.search('ul#ul_product_list1/li/div.product').each do |p|
            nome = p.search("span.name/strong").text
            valor = p.search("span.for/strong").text
            
            if p.search("span.notAvail").size > 0
                valor = "Não disponível"
            end
                                    
            produtos << {:nome=>nome, :valor=>valor}
        end
        
        produtos
    end
end
