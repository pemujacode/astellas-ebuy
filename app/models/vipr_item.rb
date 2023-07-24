class ViprItem < ApplicationRecord
  belongs_to :vipr, required: true
  #before_save :calculate_linetotals

  private 

 


  def calculate_linetotals
     	self.amount = self.quantity * self.price
  end 






end
