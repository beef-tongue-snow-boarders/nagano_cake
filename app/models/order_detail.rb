class OrderDetail < ApplicationRecord
  enum making_status: { start_impossible: 0, production_waiting: 1, production: 2, production_complete: 3 }
end
