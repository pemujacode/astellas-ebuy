class PurchaseOrderItem < ApplicationRecord
  belongs_to :purchase_order, required: true

  #before_save :calculate_linetotals

  private 

 


  def calculate_linetotals
     	self.amount = self.quantity * self.price
  end 





end
