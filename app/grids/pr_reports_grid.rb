class PrReportsGrid < BaseGrid

  scope do
    PurchaseRequest
  end

  filter(:id, :integer, :header => 'PR No', class: 'form-control')
  filter(:request_date, :date, :range => true)

  
  
  
  filter(:department, :enum,
    :select => lambda {Department.all.map {|p| [p.name]}},
    :include_blank => true
  ) 

  filter(:costcenter, :enum, :header => 'Request Type',
    :select => lambda {Costcenter.all.map {|p| [p.name]}},
    :include_blank => true,
    :class => 'form-control'
  ) 



  column(:id)
  column(:requester)
  column(:department)
  column(:costcenter)
  column(:item)
  column(:quantity)
  column(:purpose)
  column(:allocation)
  column(:notes)
  column(:status)








end
