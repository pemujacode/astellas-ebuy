module ViprsHelper

  def copy_from_po(name,f,**args)
  	  f.simple_fields_for @vipr_item do |builder|


         render 'vipr_item', f: builder 
   
    end
      link_to(name, '#')
   
  	
   
  end

  

end
