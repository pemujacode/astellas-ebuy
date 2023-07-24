class Authorization < ApplicationRecord
  belongs_to :user
  enum auth: { None: 2, ReadOnly:1 , Full:0 }

end
