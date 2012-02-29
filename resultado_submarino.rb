require 'hpricot'

class ResultadoSubmarino
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
        @doc.search('ul#ul_product_list1')        
    end
    
    def listar_produtos
        produtos = []
        @doc.search('ul#ul_product_list1/li/div.product').each do |p|
            nome = (p/"span.name/strong").text
            valor = (p/"span.for/strong").text
            
            produtos << {:nome=>nome, :valor=>valor}
        end
        
        produtos
    end
end
